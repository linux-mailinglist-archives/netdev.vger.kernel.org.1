Return-Path: <netdev+bounces-139697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E039B3DD2
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A371C21AC6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F621D6DA9;
	Mon, 28 Oct 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="DdYHcuPA";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="bmJ8G2NQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000e8d01.pphosted.com (mx0a-000e8d01.pphosted.com [148.163.147.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19B18FDC2;
	Mon, 28 Oct 2024 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154969; cv=fail; b=XOQHhtW0KEkkrN5LMhb4D8UFmSTbi029NqI4THVfooAtmh/e4cqxt3kEFZDCaZ1Rji1DVf1JcRtqNNA7r2bh8eclLw8sZ5iIevAp89CbSjUanPAIMtHc/IU3/UEs489PnfJAMB+61MHBuEqFdP4d5NhDf3NXf523kvFZ47ZsVRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154969; c=relaxed/simple;
	bh=KEpHhdcMPTHPnKagZBqsL1Y1O8Ur17+heuwTW9uWoIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zl4vGGHJLi4s/HYrjuoesTvuUhHHI6cEUOwjk4BYWojyoCbgAColiXL2j8XsZvkjmUgrze0r8pWGBsXzHEwpPbFQR1UYtcPxa0nbJ+/WlPb1PsUjcUIgocuidVvYqgUUcZnWatMWb3snabxUhhpWoNc0b/F25U0BNgEojKxc/7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=DdYHcuPA; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=bmJ8G2NQ; arc=fail smtp.client-ip=148.163.147.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Received: from pps.filterd (m0136172.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SMTU4R000399;
	Mon, 28 Oct 2024 15:35:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=lKUjy
	lJhP6Scqng9UgdUw2HdV+4He6CRqBNyRIhZzkE=; b=DdYHcuPAeKK2spZnFck8D
	1oE/zg3ItUfvh+zmKQgsX1nTzcPnHwd6NjeVBDJPor5C9kBO30sJJb98LXPawvEd
	+pYpqUuxCnQjA9xnjhoi9JmEPWnbGz2QvBdc9FhgYDUSu96yrEOqEaOUvNtzLpw3
	F1IJHU9S/Jr+Q5KFo0XJE7KdyH4ncl8RLQrKKW2Vu/4qu/L7rvL/owKI22Kqqcnm
	+onf7b3H0+Vm3uOWW3NKGRomrReNXDT6ID59G/dxw59VKfHmtO1ih0CQ8vXmnx3X
	+iJoC9eSXjO/LiJGejteTrvBp+1j/Ti524qz1bta6xVV0GPaOk0sf+5l9yURd6a3
	Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 42jgerr585-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 15:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iatokHXaj5UCnCsn1sp4aYAjTIU35JYxIC9NQAXUbNNhHWqXTJQAH+HS9te4QytaNc8wXwyVrfUtn6F5ZyMwOFtQKHDrk67L7hOTMzxWvuxAk6Yh6dBm++H1IDAgpju9Ipz/YBAT1b7jYVidAL30dFMAFy1RRAjejeJYi8b1M4GQiQ9HpCd2MPXg3vtLhYkRpW17HLW5JBxaSVi/0RYALAo9Nh2RFdcyHGh4g1UZMUhgP0b3Z7JepjxJl/IMvIXO64MbB5X5hwS+OHrx5K+aN09f/Zh1i6LETP+RUOdErzoTLHh7mfN/wgdS92AefapJcXG+/NBaslzLKWXl9P9XLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKUjylJhP6Scqng9UgdUw2HdV+4He6CRqBNyRIhZzkE=;
 b=We8/Jg1Rrs9SjcVYmHFOC8tlH+UOaV5Ds4Vmot2DIgGUzI9Mz2aReGIO+70yEQLdbhwXL2nLVDpIf7dYtQ0OutZs3VYDw/PkStBSCyTGTQH4WIIl08PUpf0ukUeX7huH+Lj8unE+RxybM8XNCmXcXMCOBkUGVFUHrD0YudVfhNEPDwI9d+3oLblt0nbdNp6eeslUDcwGXOgQzq0A03/4AHk73KoBGUz2S1l4rlxdfvc8uVpmh4+TE1rClpckDCbnBWZXEZO39y0eoHavfYqOHlYoOLgwaJI7Pa+Fr01XbwYVZ4dFxzgxnhOrhTLpKSYHs+Ij4eGTcQuxcZOIzwrErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKUjylJhP6Scqng9UgdUw2HdV+4He6CRqBNyRIhZzkE=;
 b=bmJ8G2NQKO0C1vPFy561I8k3tt56YlYooe9WR5STbyFFnmDNxjSoTY798uWhtVx2vc5l1nmRsJsrIVc7P3DC2gJfw/BoTDldhTrtPc1gMFvNFGTvJzGMPRrF1uVIfZzErrlZEVGsiexEbO5o5AEGLzo6OYOGUZ1rnnYJECCzKfMOu/XGn60djmSiJR9JGMYG2J1edg018caMrGGXfv8YMPP1Ct2JxlDwZkWdY/s6pNch3MduhCqvi3X7oYaUgOy1FqCsOs8jqxwMVAdFPUe8Br4ZlgHdVv1R4RFpncs5ABpmDS3eK5xZPCsXGNZ5C5TTP5P88qcCQHl1T3IDUaSo9Q==
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by BY1PR22MB5660.namprd22.prod.outlook.com (2603:10b6:a03:4b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 22:35:25 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::a) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 22:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 22:35:24 +0000
Received: from pig.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.24) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 28 Oct 2024 15:35:11 -0700
From: Robert Joslyn <robert_joslyn@selinc.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <lee@kernel.org>, Robert Joslyn <robert_joslyn@selinc.com>
Subject: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network adapter
Date: Mon, 28 Oct 2024 15:35:08 -0700
Message-ID: <20241028223509.935-3-robert_joslyn@selinc.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|BY1PR22MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a28a68-dee4-4b64-d4bd-08dcf7a0d0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EY0MEKulNOKf6MDwtycFyk2THXztaNODnKuB4rQNINMoLYBNsLi1THM05MwQ?=
 =?us-ascii?Q?z0o+3DFsrw1SUnRHRevvfno2jF4218qGSwOO0CQAb431EO8Axm7j11PmJwIf?=
 =?us-ascii?Q?SGMpYuRZpmA5iOxEBqXL7V7VYyMkTIMVNuQXcmhtvH7I6osRZhVEsCxzwZzz?=
 =?us-ascii?Q?qV4PdiJUzdgzIvzYQWBDsCTuaDwtjAdNyPNbeQt6mos9h5l6lPkVLNy+1EfB?=
 =?us-ascii?Q?p/PwoFNYTMKQktqM+PD2I4j/r+6puJ2eii5L3mcwceUai/ovde2fsJKFnLoK?=
 =?us-ascii?Q?+0EfLhXOn+DxlOsQDiLW0NtLGfQK9JZuAR3heExEp119iGXzA/r9kDn9k49Q?=
 =?us-ascii?Q?mzqtWPhBNfc1+emlhwV8y+WVxTePLgIO6g9MqFZT2E07KBanMFGjHhmrzn3t?=
 =?us-ascii?Q?TLDyqPFj3YIDR7ArKQ2g5cmzqdOAepADs4q1oBjrJgqWTmPQZPNb9N5C8qJq?=
 =?us-ascii?Q?BJiLblKV8zvpHhLed07CLOY1Gu8KIj6euNNyuyHdIuV/4//C0HbsvPTklosS?=
 =?us-ascii?Q?Bck3c3SLzNC7Y/NS3dqqVau690nxaQbwWf46+BUVsKQb/I2OhA3RzwfLN+Vm?=
 =?us-ascii?Q?UKhiqCUGvJWgiPc8qweRHPJf+oMePiOJURL9DSRraX2h1hXxkchrPd64YUKq?=
 =?us-ascii?Q?rVx2zrr0eYSoPHhoR7XnKQF4Vbtc/bz6ygLbz9mcA/mtXV+oaHDTTc7Fcjfb?=
 =?us-ascii?Q?WVwhGwBB9YamdB85C/aA8CYHN7AGzZtQvUx6JsNkNVQsjIYKXfjiIjgZWedf?=
 =?us-ascii?Q?/MJYvCmiHpc99vRLFjhhMXRBAgdCrFrfFr6+FUinvl9g18Y1J7/1Baj9EkdK?=
 =?us-ascii?Q?4DAZy58YqR6hL8QFzwJUC62/w40b6mu00HHxkzBklPQ2ME45H/2XDrbb3X9R?=
 =?us-ascii?Q?JVONPxGoev1Kv0H4ggOSbQ69xTq3P7E1DnTfzxlUcPBgik4PfQZw9nJHDUiO?=
 =?us-ascii?Q?I4q9muwtk0gIpOaf+MiLMf4c6kbezTKOX3bKeZBP3XogW9AW11v2DQf+NWYh?=
 =?us-ascii?Q?ngYiX6/VWoVpvDnZRw0W/OPUlBhl6XCiNfUcIQLZWhH7iTqGNvUQ+BVO8Bzb?=
 =?us-ascii?Q?uVHtg/avt6JOvi4ovm8IXWOTEaD3TUxhepB3tXplM8k2XpVQXe+bCiFqE5Nu?=
 =?us-ascii?Q?98Qqky7bRIRZqkevsuK9eekTJUEyXfJHwebY96KME6kP0L8hpKvXzTn2eo6I?=
 =?us-ascii?Q?w1r64ho7Ux1SXOmR3sHSSH06/oqd0noJPO1+LrONxFjkyTit6D+Wu98trbQ8?=
 =?us-ascii?Q?2cVKS6tszc5DGpOFWcIWUJ+e20rcLv3sLr4qq0SIwNIrmxJgGjt6GskXiSaT?=
 =?us-ascii?Q?WT+3eERbabeOirjDfPbjPtWcV0dPG8cBB7w+WnL8dbjOfTEWPM6qxZwMNSDt?=
 =?us-ascii?Q?vjCQydo=3D?=
X-Forefront-Antispam-Report:
	CIP:74.117.212.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:email.selinc.com;PTR:wpul-exchange1.selinc.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 22:35:24.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a28a68-dee4-4b64-d4bd-08dcf7a0d0d3
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec;Ip=[74.117.212.83];Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR22MB5660
X-Proofpoint-ORIG-GUID: czCiHTNmp4Mh8KoVOOAk8b4SiAZaw2vS
X-Proofpoint-GUID: czCiHTNmp4Mh8KoVOOAk8b4SiAZaw2vS
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280177

Add support for SEL FPGA based network adapters. The network device is
implemented as an FPGA IP core and enumerated by the selpvmf driver.
This is used on multiple devices, including:
 - SEL-3350 mainboard
 - SEL-3390E4 card
 - SEL-3390T card

Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>
---
 MAINTAINERS                                  |   1 +
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
 41 files changed, 8117 insertions(+)
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

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a24b3be8aa5..83cac59aab67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20735,6 +20735,7 @@ M:	Robert Joslyn <robert_joslyn@selinc.com>
 S:	Supported
 B:	mailto:opensource@selinc.com
 F:	drivers/mfd/selpvmf-*
+F:	drivers/net/ethernet/sel/
 F:	drivers/platform/x86/sel3350-platform.c
 F:	include/linux/mfd/selpvmf.h
 
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 9a542e3c9b05..1f2af87f716d 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -181,6 +181,7 @@ source "drivers/net/ethernet/renesas/Kconfig"
 source "drivers/net/ethernet/rocker/Kconfig"
 source "drivers/net/ethernet/samsung/Kconfig"
 source "drivers/net/ethernet/seeq/Kconfig"
+source "drivers/net/ethernet/sel/Kconfig"
 source "drivers/net/ethernet/sgi/Kconfig"
 source "drivers/net/ethernet/silan/Kconfig"
 source "drivers/net/ethernet/sis/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 99fa180dedb8..10d851c6b4da 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_NET_VENDOR_RDC) += rdc/
 obj-$(CONFIG_NET_VENDOR_ROCKER) += rocker/
 obj-$(CONFIG_NET_VENDOR_SAMSUNG) += samsung/
 obj-$(CONFIG_NET_VENDOR_SEEQ) += seeq/
+obj-$(CONFIG_NET_VENDOR_SEL) += sel/
 obj-$(CONFIG_NET_VENDOR_SILAN) += silan/
 obj-$(CONFIG_NET_VENDOR_SIS) += sis/
 obj-$(CONFIG_NET_VENDOR_SOLARFLARE) += sfc/
diff --git a/drivers/net/ethernet/sel/Kconfig b/drivers/net/ethernet/sel/Kconfig
new file mode 100644
index 000000000000..3c7be7b6a131
--- /dev/null
+++ b/drivers/net/ethernet/sel/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+#
+# SEL network device configuration
+#
+
+config NET_VENDOR_SEL
+	bool "SEL devices"
+	default y
+	help
+	  If you have a network (Ethernet) card from SEL, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about SEL cards. If you say Y, you will
+	  be asked for your specific card in the following questions.
+
+if NET_VENDOR_SEL
+
+config SELPCIMAC
+	tristate "SEL PCI MAC support"
+	select CRC32
+	help
+	  This driver supports SEL FPGA based Ethernet devices, including:
+	      * SEL-3350 mainboard
+	      * SEL-3390E4
+	      * SEL-3390T
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called selpcimac.
+
+endif # NET_VENDOR_SEL
diff --git a/drivers/net/ethernet/sel/Makefile b/drivers/net/ethernet/sel/Makefile
new file mode 100644
index 000000000000..70d4809e5533
--- /dev/null
+++ b/drivers/net/ethernet/sel/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+#
+# Makefile for the SEL network device drivers.
+#
+
+selpcimac-objs	:= mac_main.o
+selpcimac-objs	+= ethtool.o
+selpcimac-objs	+= hw_interface.o
+selpcimac-objs	+= mdio.o
+selpcimac-objs	+= mii.o
+selpcimac-objs	+= mii_interface.o
+selpcimac-objs	+= netdev.o
+selpcimac-objs	+= netdev_isr.o
+selpcimac-objs	+= netdev_rx.o
+selpcimac-objs	+= netdev_tx.o
+selpcimac-objs	+= pci_mac_sysfs.o
+selpcimac-objs	+= sel_phy_broadcom.o
+selpcimac-objs	+= sel_phy_marvell.o
+selpcimac-objs	+= sel_phy_ti.o
+selpcimac-objs	+= sel_soft_phy.o
+selpcimac-objs	+= sfp.o
+obj-$(CONFIG_SELPCIMAC)	+= selpcimac.o
diff --git a/drivers/net/ethernet/sel/ethtool.c b/drivers/net/ethernet/sel/ethtool.c
new file mode 100644
index 000000000000..eacce3f8ebf3
--- /dev/null
+++ b/drivers/net/ethernet/sel/ethtool.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/workqueue.h>
+
+#include "ethtool.h"
+#include "mii.h"
+#include "netdev.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+
+/**
+ * ethtool_get_ksettings() - Get various device settings
+ *
+ * @netdev: net device object
+ * @ks:    the ksettings to get
+ *
+ * Return: 0 if successful, otherwise an appropriate negative error code
+ */
+static int ethtool_get_ksettings(struct net_device *netdev,
+				 struct ethtool_link_ksettings *ks)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	return sel_mii_ethtool_gksettings(&mac->mii_if, ks);
+}
+
+/**
+ * ethtool_set_ksettings() - Set various device settings
+ *
+ * @netdev: net device object
+ * @ks:    the ksettings to set
+ *
+ * Return: 0 if successful, otherwise an appropriate negative error code
+ */
+static int ethtool_set_ksettings(struct net_device *netdev,
+				 const struct ethtool_link_ksettings *ks)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	return sel_mii_ethtool_sksettings(&mac->mii_if, ks);
+}
+
+/**
+ * ethtool_get_regs_len() - Get the length of the hardware register memory
+ *
+ * @netdev: net device object
+ *
+ * Return: the size of the register memory
+ */
+static int ethtool_get_regs_len(struct net_device *netdev)
+{
+	return sizeof(struct sel_pci_mac_registers);
+}
+
+/**
+ * ethtool_get_regs() - Dump the internal hardware registers
+ *
+ * @netdev: net device object
+ * @regs:   ethtool specific information
+ * @p:      output buffer for device registers
+ */
+static void ethtool_get_regs(struct net_device *netdev,
+			     struct ethtool_regs *regs,
+			     void *p)
+{
+	u32 regsize = sizeof(struct sel_pci_mac_registers);
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+	u32 *buff = p;
+	u32 i;
+
+	memset(buff, 0, regsize);
+
+	for (i = 0; i < (regsize / sizeof(u32)); ++i)
+		buff[i] = ioread32((u32 *)mac->hw_mac + i);
+}
+
+/**
+ * ethtool_get_msglevel() - Get the currently set message tracing level
+ *
+ * @netdev: net device object
+ *
+ * Return: the message level set
+ */
+static u32 ethtool_get_msglevel(struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	return mac->msg_enable;
+}
+
+/**
+ * ethtool_set_msglevel() - Set a new message tracing level
+ *
+ * @netdev: net device object
+ * @value:  the message level to set
+ */
+static void ethtool_set_msglevel(struct net_device *netdev, u32 value)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	mac->msg_enable = value;
+}
+
+/**
+ * ethtool_nway_reset() - Restart Autonegotiation
+ *
+ * @netdev: net device object
+ *
+ * Return: 0 if successful, otherwise appropriate negative error code
+ */
+static int ethtool_nway_reset(struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	return sel_mii_nway_restart(&mac->mii_if);
+}
+
+/**
+ * ethtool_get_ringparam() - Get the current RX/TX ring parameters
+ *
+ * @netdev: net device object
+ * @ring:   ring parameters output buffer
+ */
+static void ethtool_get_ringparam(struct net_device *netdev,
+				  struct ethtool_ringparam *ring,
+				  struct kernel_ethtool_ringparam *kernel_ring,
+				  struct netlink_ext_ack *netack)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	ring->rx_max_pending = SEL_MAX_NUM_RX_BDS;
+	ring->tx_max_pending = SEL_MAX_NUM_TX_BDS;
+
+	ring->rx_pending = mac->num_rx_bds;
+	ring->tx_pending = mac->num_tx_bds;
+}
+
+/**
+ * ethtool_set_ringparam() - Set new RX/TX ring parameters
+ *
+ * @netdev: net device object
+ * @ring:   ring parameters input buffer
+ *
+ * Return: 0 if successful, otherwise appropriate negative error code
+ */
+static int ethtool_set_ringparam(struct net_device *netdev,
+				 struct ethtool_ringparam *ring,
+				 struct kernel_ethtool_ringparam *kernel_ring,
+				 struct netlink_ext_ack *netack)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+	bool running = netif_running(netdev);
+
+	/* Prevent the user from changing the minimum rxbds and anything
+	 * concerning jumbo frames, since they aren't supported.
+	 */
+	if (ring->rx_mini_pending > 0 || ring->rx_jumbo_pending > 0)
+		return -EINVAL;
+
+	if (running)
+		sel_down(mac);
+
+	mac->num_rx_bds = max_t(u32, ring->rx_pending, SEL_MIN_NUM_RX_BDS);
+	mac->num_rx_bds = min_t(u32, mac->num_rx_bds, SEL_MAX_NUM_RX_BDS);
+	mac->num_tx_bds = max_t(u32, ring->tx_pending, SEL_MIN_NUM_TX_BDS);
+	mac->num_tx_bds = min_t(u32, mac->num_tx_bds, SEL_MAX_NUM_TX_BDS);
+
+	if (running)
+		(void)sel_up(mac);
+
+	return 0;
+}
+
+/* eth_tool ETH_SS_TEST strings */
+static const char SEL_GSTRINGS_TEST[][ETH_GSTRING_LEN] = {
+	"Link test      (on/offline)",
+	"Loopback test  (offline)"
+};
+
+#define SEL_TEST_LEN ARRAY_SIZE(SEL_GSTRINGS_TEST)
+
+/**
+ * ethtool_set_phys_id() - Identify physical devices
+ *
+ * @netdev: net device object to identify
+ * @state:  the state to set the LEDs to
+ *
+ * It is initially called with the argument ETHTOOL_ID_ACTIVE,
+ * and must either activate asynchronous updates and return zero, return
+ * a negative error or return a positive frequency for synchronous
+ * indication (e.g. 1 for one on/off cycle per second).  If it returns
+ * a frequency then it will be called again at intervals with the
+ * argument ETHTOOL_ID_ON or ETHTOOL_ID_OFF and should set the state of
+ * the indicator accordingly. Finally, it is called with the argument
+ * ETHTOOL_ID_INACTIVE and must deactivate the indicator.
+ *
+ * Return: > 0 if successful, otherwise appropriate negative return value
+ */
+static int ethtool_set_phys_id(struct net_device *netdev,
+			       enum ethtool_phys_id_state state)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		/* We return a positive value which will indicate the
+		 * frequency at which this function is called with
+		 * ETHTOOL_ID_ON and ETHTOOL_ID_OFF.
+		 * (e.g. 2 for 2 on/off cycle per second)
+		 */
+		return 2;
+
+	case ETHTOOL_ID_ON:
+		iowrite32(ETH_LED_TEST_ON, &mac->hw_mac->led.eth_led);
+		break;
+
+	case ETHTOOL_ID_OFF:
+		iowrite32(ETH_LED_TEST_OFF, &mac->hw_mac->led.eth_led);
+		break;
+
+	case ETHTOOL_ID_INACTIVE:
+		iowrite32(ETH_LED_NORMAL, &mac->hw_mac->led.eth_led);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/* eth_tool ETH_SS_STATS strings */
+static const char SEL_GSTRINGS_STATS[][ETH_GSTRING_LEN] = {
+	"rx_packets", "tx_packets", "rx_bytes", "tx_bytes", "rx_errors",
+	"tx_errors", "rx_dropped", "tx_dropped"
+};
+
+#define SEL_STATS_LEN ARRAY_SIZE(SEL_GSTRINGS_STATS)
+
+/* eth_tool ETH_SS_PRIV_FLAGS
+ * Strings must be less than 32 characters in order to copy them into an
+ * ethtool description data buffer
+ */
+static const char * const sel_en_priv_flags[] = {
+	"Failover"
+};
+
+#define FAILOVER_ENABLED		0x01
+
+/**
+ * ethtool_get_sset_count() - Return the number of strings that
+ * get_strings will return
+ *
+ * @netdev: net device object
+ * @sset:   the string set being queried
+ *
+ * Return: the number of strings returned, or -EOPNOTSUPP if invalid sset
+ */
+static int ethtool_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_TEST:
+		return SEL_TEST_LEN;
+
+	case ETH_SS_STATS:
+		return SEL_STATS_LEN;
+
+	case ETH_SS_PRIV_FLAGS:
+		return ARRAY_SIZE(sel_en_priv_flags);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
+ * ethtool_get_ethtool_stats() - Return extended statistics about the device
+ *
+ * @netdev: net device object
+ * @stats:  unused parameter
+ * @data:   output statistics
+ */
+static void ethtool_get_ethtool_stats(struct net_device *netdev,
+				      struct ethtool_stats *stats,
+				      u64 *data)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+	u32 i;
+
+	/* Retrieve and store device stats that we support */
+	for (i = 0; i < SEL_STATS_LEN; i++)
+		data[i] = ((unsigned long *)&mac->stats)[i];
+}
+
+/*
+ * ethtool_get_strings() - Return a set of strings that describe this device
+ *
+ * @netdev:    net device object
+ * @stringset: the string set requested
+ * @data:      null terminated strings
+ */
+static void ethtool_get_strings(struct net_device *netdev,
+				u32 stringset,
+				u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_TEST:
+		memcpy(data, *SEL_GSTRINGS_TEST, sizeof(SEL_GSTRINGS_TEST));
+		break;
+
+	case ETH_SS_STATS:
+		memcpy(data, *SEL_GSTRINGS_STATS, sizeof(SEL_GSTRINGS_STATS));
+		break;
+
+	case ETH_SS_PRIV_FLAGS:
+		for (i = 0; i < ARRAY_SIZE(sel_en_priv_flags); i++) {
+			strscpy((data + (i * ETH_GSTRING_LEN)),
+				sel_en_priv_flags[i],
+				ETH_GSTRING_LEN);
+		}
+		break;
+	}
+}
+
+/*
+ * ethtool_get_priv_flags() - Returns the bitmask of the flags enabled
+ *
+ * @netdev: net device object
+ *
+ * @returns: The bitmask of all private flags which are enabled
+ */
+static u32 ethtool_get_priv_flags(struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	return mac->private_ethtool_settings;
+}
+
+/*
+ * ethtool_set_priv_flags() - Takes user input and sets flags enabled/disabled
+ *
+ * @netdev: net device object
+ * @flags: The private flag configuration requested by the user
+ *
+ * @returns: 0 if Successful otherwise negative error code
+ */
+static int ethtool_set_priv_flags(struct net_device *netdev, u32 flags)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	if ((flags & FAILOVER_ENABLED) != 0) {
+		mac->private_ethtool_settings = FAILOVER_ENABLED;
+
+		/* Enable failover in HW */
+		iowrite32(FAILOVER_ENABLED, &mac->hw_mac->mac.failover);
+	} else {
+		mac->private_ethtool_settings = 0;
+
+		/* Disable failover in HW */
+		iowrite32(0, &mac->hw_mac->mac.failover);
+	}
+
+	return 0;
+}
+
+/* Supported ethtool operations */
+static const struct ethtool_ops sel_ethtool_ops = {
+	.get_link_ksettings     = ethtool_get_ksettings,
+	.set_link_ksettings     = ethtool_set_ksettings,
+	.get_regs_len           = ethtool_get_regs_len,
+	.get_regs               = ethtool_get_regs,
+	.get_msglevel           = ethtool_get_msglevel,
+	.set_msglevel           = ethtool_set_msglevel,
+	.nway_reset             = ethtool_nway_reset,
+	.get_link               = ethtool_op_get_link, /* standard func */
+	.get_ringparam          = ethtool_get_ringparam,
+	.set_ringparam          = ethtool_set_ringparam,
+	.get_strings            = ethtool_get_strings,
+	.get_priv_flags		= ethtool_get_priv_flags,
+	.set_priv_flags		= ethtool_set_priv_flags,
+
+	.set_phys_id            = ethtool_set_phys_id,
+
+	.get_sset_count         = ethtool_get_sset_count,
+	.get_ethtool_stats      = ethtool_get_ethtool_stats,
+};
+
+/**
+ * sel_set_ethtool_ops() - initialize ethtool ops
+ *
+ * @netdev: net device object
+ */
+void sel_set_ethtool_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &sel_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/sel/ethtool.h b/drivers/net/ethernet/sel/ethtool.h
new file mode 100644
index 000000000000..018c9f7db30f
--- /dev/null
+++ b/drivers/net/ethernet/sel/ethtool.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_ETHTOOL_INCLUDED
+#define SEL_ETHTOOL_INCLUDED
+
+#include <linux/netdevice.h>
+
+#include "pci_mac.h"
+
+void sel_set_ethtool_ops(struct net_device *netdev);
+
+#endif /* SEL_ETHTOOL_INCLUDED */
diff --git a/drivers/net/ethernet/sel/hw_interface.c b/drivers/net/ethernet/sel/hw_interface.c
new file mode 100644
index 000000000000..766aba68e8d0
--- /dev/null
+++ b/drivers/net/ethernet/sel/hw_interface.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/if_ether.h> /* ETH_ALEN */
+#include <linux/io.h>
+#include <linux/netdevice.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "hw_interface.h"
+#include "pci_mac_hw_regs.h"
+#include "sel_phy.h"
+
+/**
+ * sel_write_flush() - Flush PCI writes
+ *
+ * @hw_mac: MAC base address register
+ */
+static void sel_write_flush(struct sel_pci_mac_registers *hw_mac)
+{
+	/* Flush PCI writes by doing a benign read */
+	(void)ioread32(&hw_mac->mac.revision);
+}
+
+/**
+ * sel_read_mod_write() - Read/modify/write a device address
+ *
+ * @addr: The address to modify
+ * @set_bits: The bits to set
+ * @clear_bits: The bits to clear
+ */
+void sel_read_mod_write(void __iomem *addr, u32 set_bits, u32 clear_bits)
+{
+	u32 data = 0;
+
+	data = ioread32(addr);
+	data |= set_bits;
+	data &= ~clear_bits;
+	iowrite32(data, addr);
+}
+
+/**
+ * sel_hw_reset() - Reset a MAC
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_hw_reset(struct sel_pci_mac_registers *hw_mac)
+{
+	int reset_delay_us = 11000;
+
+	iowrite32(MACSTAT_SOFT_RESET, &hw_mac->mac.macstat);
+	sel_write_flush(hw_mac);
+
+	/* According to HW, the PHY on the 3350 requires the longest
+	 * reset pulse at 10ms, minimum.  11ms was chosen to make sure
+	 * we don't wait too short.
+	 */
+	udelay(reset_delay_us);
+
+	iowrite32(0, &hw_mac->mac.macstat);
+	sel_write_flush(hw_mac);
+	/* The TI PHY requires a minimum of 30 us delay after a reset
+	 * before any access to the PHY management bus. Make the delay
+	 * 100 us to provide some margin as suggested by the HW team.
+	 */
+	udelay(100);
+}
+
+/**
+ * sel_enable_irq() - Enable interrupts related to a MAC
+ *
+ * @hw_mac: MAC base address register
+ * @imask:  The interrupt mask to set
+ */
+void sel_enable_irq(struct sel_pci_mac_registers *hw_mac, u32 imask)
+{
+	iowrite32(imask, &hw_mac->irq_ctrl.mask_set);
+}
+
+/**
+ *  sel_disable_irq() - Disable interrupts related to a MAC
+ *
+ *  @hw_mac: MAC base address register
+ *  @imask:  The interrupt mask to clear
+ *
+ *  This function requires the interrupt lock to be held.
+ */
+void sel_disable_irq(struct sel_pci_mac_registers *hw_mac, u32 imask)
+{
+	iowrite32(imask, &hw_mac->irq_ctrl.mask_clr);
+}
+
+/**
+ * sel_set_hw_mac_addr() - Set the mac address directly in hardware
+ *
+ * @hw_mac: MAC base address register
+ * @mac_address: 6-byte mac address
+ */
+void sel_set_hw_mac_addr(struct sel_pci_mac_registers *hw_mac,
+			 const u8 *mac_address)
+{
+	u32 mac_1;
+	u32 mac_2;
+
+	mac_1 = ((mac_address[5] << 24) |
+		(mac_address[4] << 16) |
+		(mac_address[3] << 8) |
+		(mac_address[2] << 0));
+
+	mac_2 = ((mac_address[1] << 24) |
+		(mac_address[0] << 16));
+
+	iowrite32(mac_1, &hw_mac->mac.mac_addr_set0);
+	iowrite32(mac_2, &hw_mac->mac.mac_addr_set1);
+}
+
+/**
+ * sel_get_hw_mac_addr() - Get the mac address directly from hardware
+ *
+ * @hw_mac: MAC base address register
+ * @mac_address: 6-byte mac address
+ * @size: Size of input buffer
+ *
+ * @return 0 if successful, otherwise appropriate negative error value
+ */
+int sel_get_hw_mac_addr(struct sel_pci_mac_registers *hw_mac,
+			u8 *mac_address,
+			u8 size)
+{
+	u32 mac_1;
+	u32 mac_2;
+
+	if (size < 6)
+		return -EINVAL;
+
+	/* Get the mac_address from the hw_registers */
+	mac_1 = ioread32(&hw_mac->mac.mac_addr_in0);
+	mac_2 = ioread32(&hw_mac->mac.mac_addr_in1);
+
+	mac_address[5] = (u8)((mac_1 >> 24) & 0xFFU);
+	mac_address[4] = (u8)((mac_1 >> 16) & 0xFFU);
+	mac_address[3] = (u8)((mac_1 >> 8) & 0xFFU);
+	mac_address[2] = (u8)((mac_1 >> 0) & 0xFFU);
+	mac_address[1] = (u8)((mac_2 >> 24) & 0xFFU);
+	mac_address[0] = (u8)((mac_2 >> 16) & 0xFFU);
+
+	return 0;
+}
+
+/**
+ * sel_check_and_report_link_status - Reports the link status to the OS
+ *
+ * @hw_mac: MAC base address register
+ * @netdev: OS's reference to our net device
+ */
+void sel_check_and_report_link_status(struct sel_pci_mac_registers *hw_mac,
+				      struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+	u32 macstat = ioread32(&hw_mac->mac.macstat);
+	int cur_link =  macstat & MACSTAT_LINK;
+	u32 speed;
+
+	speed = macstat & MACSTAT_SPEED_MASK;
+
+	if (cur_link) {
+		netdev_info(netdev,
+			    "Link is Up: %u Mbps %s Duplex\n",
+			    (speed == MACSTAT_SPEED_1000MB ?
+				1000 :
+				(speed == MACSTAT_SPEED_100MB ?
+				100 : 10)),
+			    ((macstat & MACSTAT_FULL_DUPLEX)
+				== MACSTAT_FULL_DUPLEX) ?
+			    "Full" : "Half");
+
+		netif_carrier_on(netdev);
+	} else {
+		netdev_info(netdev, "Link is Down\n");
+		netif_carrier_off(netdev);
+		if (mac->generic_phy->sel_phy_linkdown_poll) {
+			schedule_delayed_work(&mac->phylink_task,
+					      PHYLINK_RETRY_PERIOD);
+		}
+	}
+}
+
+/**
+ * sel_start_transmitter() - Signals hw to start transmitting
+ *
+ * @hw_mac: register definitions for hardware
+ */
+void sel_start_transmitter(struct sel_pci_mac_registers *hw_mac)
+{
+	sel_read_mod_write(&hw_mac->transmit.tstat, TSTAT_TX_EN, 0);
+}
+
+/**
+ * sel_stop_transmitter() - Stop the hardware from transmitting
+ *
+ * @hw_mac: register definitions for hardware
+ */
+void sel_stop_transmitter(struct sel_pci_mac_registers *hw_mac)
+{
+	sel_read_mod_write(&hw_mac->transmit.tstat, 0, TSTAT_TX_EN);
+
+	/* HW requires us to wait until all DMA transactions
+	 * have finished after disabling transmit, which could take
+	 * up to 10 ms.
+	 */
+	mdelay(10);
+}
+
+/**
+ * sel_start_receiver() - Start the hardware receiver
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_start_receiver(struct sel_pci_mac_registers *hw_mac)
+{
+	/* Enable the receiver */
+	sel_read_mod_write(&hw_mac->receive.rstat, RSTAT_RX_ENABLE, 0);
+
+	/* Clear RHLT which will start the receiver if it was stopped */
+	sel_read_mod_write(&hw_mac->receive.rstat, RSTAT_RHLT, 0);
+}
+
+/**
+ * sel_stop_receiver() - Stop the hardware receiver
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_stop_receiver(struct sel_pci_mac_registers *hw_mac)
+{
+	/* Stop the receiver */
+	sel_read_mod_write(&hw_mac->receive.rstat, 0, RSTAT_RX_ENABLE);
+
+	/* HW requires us to wait until all DMA transactions
+	 * have finished after disabling receive, which could take
+	 * up to 10 ms.
+	 */
+	mdelay(10);
+}
+
+/**
+ * sel_write_mc_addr_list() - Set a new multicast list
+ *
+ * @hw_mac: MAC base address register
+ * @netdev: OS's reference to our net device
+ *
+ * The hash table process used in the group hash filtering operates as
+ * follows. The Ethernet controller maps any 48-bit destination address
+ * into one of 256 bins, represented by the 256 bits in GADDR0 - 7. The
+ * eight low-order bits of a 32-bit CRC checksum of the 48-bit DA field
+ * are used to index into the hash table. The three high order bits of
+ * this 8-bit field are used to select one of the eight registers in the
+ * group hash table. The low-order five bits select a bit within the
+ * 32-bit register. A value of 0 selects GADDR0 bit 0.
+ */
+void sel_write_mc_addr_list(struct sel_pci_mac_registers *hw_mac,
+			    struct net_device *netdev)
+{
+	u32 group_address_values[NUM_GROUP_ADDR_REGS] = {0};
+	struct netdev_hw_addr *hw_addr;
+	u32 group_address_bit;
+	u32 group_address_reg;
+	u8 hash_table_index;
+	u32 crc;
+	u32 i;
+
+	/* Set up the multicast list in hardware using a calculated CRC
+	 * for each multicast address stored in the list
+	 */
+	netdev_for_each_mc_addr(hw_addr, netdev) {
+		/* Compute the crc for the 6-byte address */
+		crc = crc32(0xFFFFFFFFu, hw_addr->addr, ETH_ALEN);
+		crc = ~crc;
+
+		/* Evaluate lower 8 bits */
+		hash_table_index = (crc & 0xFFU);
+
+		/* lower 5 bits represent bit number (0-31) */
+		group_address_bit = (hash_table_index & 0x1FU);
+
+		/* upper 3 bits represent register number (0-7) */
+		group_address_reg = (hash_table_index >> 0x5U);
+
+		/* Set bit in group address register */
+		group_address_values[group_address_reg] |=
+			(1 << group_address_bit);
+	}
+
+	/* write group addresses to HW */
+	for (i = 0; i < NUM_GROUP_ADDR_REGS; i++) {
+		iowrite32(group_address_values[i],
+			  &hw_mac->mac.group_addr[i]);
+	}
+}
+
+/**
+ * sel_enable_promiscuous_mode() - Enable promiscuous mode
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_enable_promiscuous_mode(struct sel_pci_mac_registers *hw_mac)
+{
+	sel_read_mod_write(&hw_mac->receive.rstat,
+			   RSTAT_PROMISCUOUS_MODE_BIT,
+			   0);
+}
+
+/**
+ * sel_disable_promiscuous_mode()- Disable promiscuous mode
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_disable_promiscuous_mode(struct sel_pci_mac_registers *hw_mac)
+{
+	sel_read_mod_write(&hw_mac->receive.rstat,
+			   0,
+			   RSTAT_PROMISCUOUS_MODE_BIT);
+}
+
+/**
+ * sel_enable_jumbo_frames() - Enable jumbo frame reception
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_enable_jumbo_frames(struct sel_pci_mac_registers *hw_mac)
+{
+	sel_read_mod_write(&hw_mac->receive.rstat, RSTAT_JUMBO_ENABLE_BIT, 0);
+}
+
+/**
+ * sel_disable_jumbo_frames()- Disable jumbo frame reception
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_disable_jumbo_frames(struct sel_pci_mac_registers *hw_mac)
+{
+	sel_read_mod_write(&hw_mac->receive.rstat, 0, RSTAT_JUMBO_ENABLE_BIT);
+}
+
+/**
+ * sel_enable_multicast() - Enable all multicast addresses
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_enable_multicast(struct sel_pci_mac_registers *hw_mac)
+{
+	for (u8 i = 0; i < NUM_GROUP_ADDR_REGS; i++)
+		iowrite32(~0U, &hw_mac->mac.group_addr[i]);
+}
+
+/**
+ * sel_disable_multicast() - Disable all multicast addresses
+ *
+ * @hw_mac: MAC base address register
+ */
+void sel_disable_multicast(struct sel_pci_mac_registers *hw_mac)
+{
+	for (u8 i = 0; i < NUM_GROUP_ADDR_REGS; i++)
+		iowrite32(0U, &hw_mac->mac.group_addr[i]);
+}
+
+/**
+ * sel_set_intr_mod_rate() - Sets the interrupt moderation scheme
+ *
+ * @rate: The interrupt moderation scheme to set, low, med, or high
+ * @hw_mac: MAC base address register
+ */
+void sel_set_intr_mod_rate(enum INTR_MOD_RATE rate,
+			   struct sel_pci_mac_registers *hw_mac)
+{
+	switch (rate) {
+	case INTR_MOD_LOW:
+		iowrite32(0x12, &hw_mac->intr_moderation.rxabs);
+		iowrite32(0x02, &hw_mac->intr_moderation.rxpacket);
+		iowrite32(0x12, &hw_mac->intr_moderation.txabs);
+		iowrite32(0x02, &hw_mac->intr_moderation.txpacket);
+		iowrite32(0x0C, &hw_mac->intr_moderation.throttle);
+		break;
+
+	case INTR_MOD_MED:
+		iowrite32(0x49, &hw_mac->intr_moderation.rxabs);
+		iowrite32(0x07, &hw_mac->intr_moderation.rxpacket);
+		iowrite32(0x49, &hw_mac->intr_moderation.txabs);
+		iowrite32(0x07, &hw_mac->intr_moderation.txpacket);
+		iowrite32(0x31, &hw_mac->intr_moderation.throttle);
+		break;
+
+	case INTR_MOD_HIGH:
+		iowrite32(0x80, &hw_mac->intr_moderation.rxabs);
+		iowrite32(0x0C, &hw_mac->intr_moderation.rxpacket);
+		iowrite32(0x80, &hw_mac->intr_moderation.txabs);
+		iowrite32(0x0C, &hw_mac->intr_moderation.txpacket);
+		iowrite32(0x56, &hw_mac->intr_moderation.throttle);
+		break;
+	default:
+		/* Don't change any settings */
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/sel/hw_interface.h b/drivers/net/ethernet/sel/hw_interface.h
new file mode 100644
index 000000000000..52ba7a2699d2
--- /dev/null
+++ b/drivers/net/ethernet/sel/hw_interface.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_HW_INTERFACE_H_INCLUDED
+#define SEL_HW_INTERFACE_H_INCLUDED
+
+#include <linux/netdevice.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+
+#define SEL_RESET_WAIT_RETRIES 8
+
+void sel_read_mod_write(void __iomem *addr, u32 set_bits, u32 clear_bits);
+void sel_hw_reset(struct sel_pci_mac_registers *hw_mac);
+void sel_enable_irq(struct sel_pci_mac_registers *hw_mac, u32 imask);
+void sel_disable_irq(struct sel_pci_mac_registers *hw_mac, u32 imask);
+void sel_set_hw_mac_addr(struct sel_pci_mac_registers *hw_mac,
+			 const u8 *mac_address);
+int sel_get_hw_mac_addr(struct sel_pci_mac_registers *hw_mac,
+			u8 *mac_address,
+			u8 size);
+void sel_check_and_report_link_status(struct sel_pci_mac_registers *hw_mac,
+				      struct net_device *netdev);
+void sel_start_transmitter(struct sel_pci_mac_registers *hw_mac);
+void sel_stop_transmitter(struct sel_pci_mac_registers *hw_mac);
+void sel_start_receiver(struct sel_pci_mac_registers *hw_mac);
+void sel_stop_receiver(struct sel_pci_mac_registers *hw_mac);
+void sel_write_mc_addr_list(struct sel_pci_mac_registers *hw_mac,
+			    struct net_device *netdev);
+void sel_enable_promiscuous_mode(struct sel_pci_mac_registers *hw_mac);
+void sel_disable_promiscuous_mode(struct sel_pci_mac_registers *hw_mac);
+void sel_enable_jumbo_frames(struct sel_pci_mac_registers *hw_mac);
+void sel_disable_jumbo_frames(struct sel_pci_mac_registers *hw_mac);
+void sel_enable_multicast(struct sel_pci_mac_registers *hw_mac);
+void sel_disable_multicast(struct sel_pci_mac_registers *hw_mac);
+void sel_set_intr_mod_rate(enum INTR_MOD_RATE rate,
+			   struct sel_pci_mac_registers *hw_mac);
+
+#endif /* SEL_HW_INTERFACE_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/mac_main.c b/drivers/net/ethernet/sel/mac_main.c
new file mode 100644
index 000000000000..658a6747ffab
--- /dev/null
+++ b/drivers/net/ethernet/sel/mac_main.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2017 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/ioport.h> /* iomap, request region */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "netdev.h"
+#include "pci_mac.h"
+
+/**
+ * pci_mac_suspend() - Called when the system is entering sleep state
+ *
+ * @dev: This mfd representation of this device
+ *
+ * Return: 0
+ */
+static int pci_mac_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct selpcimac_platform_private *priv;
+
+	priv = platform_get_drvdata(pdev);
+
+	if (likely(priv))
+		selpcimac_suspend_device(priv->priv);
+
+	return 0;
+}
+
+/**
+ * pci_mac_resume() - Called when the system is leaving sleep state
+ *
+ * @dev: This mfd representation of this device
+ *
+ * Return: 0
+ */
+static int pci_mac_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct selpcimac_platform_private *priv;
+
+	priv = platform_get_drvdata(pdev);
+
+	if (likely(priv))
+		selpcimac_resume_device(priv->priv);
+
+	return 0;
+}
+
+/**
+ * pci_mac_probe() - probe method
+ *
+ *  @pdev: This mfd representation of this device
+ *
+ * Return: 0 if successful, otherwise negative error code
+ */
+static int pci_mac_probe(struct platform_device *pdev)
+{
+	struct selpcimac_platform_private *priv;
+	struct resource *mem_resource;
+	int irq_misc;
+	int irq_tx;
+	int irq_rx;
+	int rc = 0;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    sizeof(struct selpcimac_platform_private),
+			    GFP_KERNEL);
+	if (!priv) {
+		rc = -ENOMEM;
+		goto exit_failure;
+	}
+
+	mem_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem_resource) {
+		rc = -EINVAL;
+		goto exit_failure;
+	}
+
+	priv->address = ioremap(mem_resource->start,
+				mem_resource->end - mem_resource->start + 1);
+	if (!priv->address) {
+		rc = -ENOMEM;
+		goto exit_failure;
+	}
+
+	irq_rx = platform_get_irq(pdev, 0);
+	irq_tx = platform_get_irq(pdev, 1);
+	irq_misc = platform_get_irq(pdev, 2);
+
+	priv->priv = selpcimac_add_device(priv->address,
+					  irq_tx,
+					  irq_rx,
+					  irq_misc,
+					  &pdev->dev);
+	if (!priv->priv) {
+		rc = -ENOMEM;
+		goto exit_freemap;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	return rc;
+
+exit_freemap:
+	iounmap(priv->address);
+
+exit_failure:
+	return rc;
+}
+
+/*
+ * pci_mac_remove() - Removes a mac ddevice
+ *
+ * @pdev: This mfd representation of this device
+ *
+ * Called by the PCI subsystem when the device needs
+ * to be removed. Could be because the driver is getting
+ * unloaded or because of a hot-plug event.
+ */
+static void pci_mac_remove(struct platform_device *pdev)
+{
+	struct selpcimac_platform_private *priv;
+
+	priv = platform_get_drvdata(pdev);
+	platform_set_drvdata(pdev, NULL);
+
+	if (likely(priv)) {
+		selpcimac_remove_device(priv->priv);
+		iounmap(priv->address);
+	}
+}
+
+static const struct dev_pm_ops selpcimac_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(pci_mac_suspend, pci_mac_resume)
+};
+
+/* struct mfd_callbacks - platform driver info */
+static struct platform_driver mfd_callbacks = {
+	.probe = pci_mac_probe,
+	.remove = pci_mac_remove,
+	.driver.name = "selpcimac",
+	.driver.pm = pm_ptr(&selpcimac_pm_ops),
+};
+
+module_platform_driver(mfd_callbacks);
+
+MODULE_AUTHOR("Schweitzer Engineering Laboratories, Inc.");
+MODULE_DESCRIPTION("SEL Network Driver");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:selpcimac");
diff --git a/drivers/net/ethernet/sel/mdio.c b/drivers/net/ethernet/sel/mdio.c
new file mode 100644
index 000000000000..3baf4b153f9e
--- /dev/null
+++ b/drivers/net/ethernet/sel/mdio.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "mdio.h"
+#include "mii_interface.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+#include "sel_phy.h"
+#include "sel_phy_broadcom.h"
+#include "sel_phy_marvell.h"
+#include "sel_phy_ti.h"
+#include "sel_soft_phy.h"
+#include "semaphore.h"
+
+/* From IEEE 802.3u section 22.2.4.3.1:
+ * https://ieeexplore.ieee.org/document/7974916
+ *
+ * The 2, 16 bit physical ID registers are used together to represent OUI,
+ * Model, and Revision of a PHY.  The OUI is 24 bits, there are 6 bits in
+ * the Model, and Revision is given 4 Bits.  As this is a total of 34 bits,
+ * the specification drops the two most significant bits of the OUI and
+ * represents the data as:
+ *
+ * |                         OUI                                  |    Model    |    Rev     |
+ * |1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24|1 2 3 4  5  6| 1  2  3  4 |
+ *     |       PHY MSB                          |    PHY LSB                                 |
+ *     |1 2 3 4 5 6 7 8  9  10 11 12 13 14 15 16|1  2  3  4  5  6  7 8 9 10 11 12 13 14 15 16|
+ */
+
+/* The Broadcom PHY appears to be reporting a different company's OUI.
+ * From the spec sheet we would have expected OUI: 0x001018. Broadcom
+ * appears to have used multiple vendors' PHYs over time:
+ * https://elixir.bootlin.com/linux/v6.6.7/source/drivers/net/dsa/b53/b53_mdio.c#L286
+ */
+#define BROADCOM_OUI        ((u32)0x0143BCB0) // OUI: 0x0050EF, Model: 0x0B
+#define MARVELL_OUI         ((u32)0x01410DD0) // OUI: 0x005043, Model: 0x1D
+#define TI_OUI              ((u32)0x2000A0F0) // OUI: 0x080028, Model: 0x0F
+#define SEL_OUI             ((u32)0x029CC010) // OUI: 0x00A730, Model: 0x01
+#define PHY_OUI_MASK        ((u32)0xFFFFFC00)
+#define PHY_MODEL_MASK      ((u32)0x000003F0)
+#define PHY_REV_MASK        ((u32)0x0000000F)
+/* We want to ignore the revision of a phy and just support all of given
+ * OUI/Model pairs
+ */
+#define PHY_ID_MASK         (PHY_OUI_MASK | PHY_MODEL_MASK)
+#define PHY_ID_MSB_REGISTER ((u8)0x02)
+#define PHY_ID_LSB_REGISTER ((u8)0x03)
+
+/**
+ * mii_if_read() - mii_if_info interface to read a PHY register
+ *
+ * @netdev: the net device object
+ * @addr:   the phy address to read
+ * @reg:    the register to read
+ *
+ * Return: the value read from the PHY
+ */
+static int mii_if_read(struct net_device *netdev, int addr, int reg)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	return sel_mii_read(mac->hw_mac, (u8)addr, (u8)reg);
+}
+
+/**
+ * mii_if_write() - mii_if_info interface to write a PHY register
+ *
+ * @netdev: the net device object
+ * @addr:   the phy address to write
+ * @reg:    the register to write
+ * @val:    the data to write
+ */
+static void mii_if_write(struct net_device *netdev, int addr, int reg, int val)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	sel_mii_write(mac->hw_mac, (u8)addr, (u8)reg, (u16)val);
+}
+
+/**
+ * sel_mdio_probe() - Setup the MII interface for all the net devices
+ *
+ * @mac: net device context
+ *
+ * Return: 0 on success, otherwise negative return value
+ *
+ * This function can only be called after net device have been
+ * allocated.
+ */
+int sel_mdio_probe(struct sel_pci_mac *mac)
+{
+	/* Set the PHY ID and PHY REG masks (both are 5 bits, thus
+	 * both are 0x1F)
+	 */
+	u32 phy_id_result = 0;
+	int attempts = 5;
+	u16 phy_id_msb;
+	u16 phy_id_lsb;
+	u32 estatus;
+
+	/* Set the net device for this MII Interface */
+	mac->mii_if.dev = mac->netdev;
+
+	/* Store the PHY address */
+	mac->mii_if.phy_id = mac->phy_address;
+
+	mac->mii_if.phy_id_mask = MIIMADD_MII_REG_ADDR_MASK;
+	mac->mii_if.reg_num_mask = MIIMADD_MII_REG_ADDR_MASK;
+
+	/* Set the read/write handlers */
+
+	mac->mii_if.mdio_read = mii_if_read;
+	mac->mii_if.mdio_write = mii_if_write;
+
+	/* Determine the phy on the board and assign the function pointer */
+	while (attempts--) {
+		phy_id_msb = sel_mii_read(mac->hw_mac,
+					  mac->mii_if.phy_id,
+					  PHY_ID_MSB_REGISTER);
+		phy_id_lsb = sel_mii_read(mac->hw_mac,
+					  mac->mii_if.phy_id,
+					  PHY_ID_LSB_REGISTER);
+
+		phy_id_result = (u32)phy_id_msb;
+		phy_id_result <<= 16;
+		phy_id_result |= (u32)phy_id_lsb;
+		phy_id_result &= PHY_ID_MASK;
+
+		if (phy_id_result == BROADCOM_OUI) {
+			mac->generic_phy = sel_get_broadcom_phy_def();
+			break;
+		} else if (phy_id_result == MARVELL_OUI) {
+			mac->generic_phy = sel_get_marvell_phy_def();
+			break;
+		} else if (phy_id_result == TI_OUI) {
+			mac->generic_phy = sel_get_ti_phy_def();
+			break;
+		} else if (phy_id_result == SEL_OUI) {
+			mac->generic_phy = sel_get_soft_phy_def();
+			break;
+		}
+		phy_id_result = 0;
+		mdelay(1);
+	}
+
+	if (phy_id_result == 0)
+		return -ENXIO;
+
+	/* This is a Gigabit device, so it has gigabit registers */
+	estatus = sel_mii_read(mac->hw_mac, mac->mii_if.phy_id, MII_ESTATUS);
+	if ((estatus & ESTATUS_1000_TFULL) == ESTATUS_1000_TFULL)
+		mac->mii_if.supports_gmii = 1;
+	else
+		mac->mii_if.supports_gmii = 0;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/sel/mdio.h b/drivers/net/ethernet/sel/mdio.h
new file mode 100644
index 000000000000..72c33a3dbb91
--- /dev/null
+++ b/drivers/net/ethernet/sel/mdio.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_MDIO_H_INCLUDED
+#define SEL_MDIO_H_INCLUDED
+
+#include "pci_mac.h"
+
+int sel_mdio_probe(struct sel_pci_mac *mac);
+
+#endif /* SEL_MDIO_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/mii.c b/drivers/net/ethernet/sel/mii.c
new file mode 100644
index 000000000000..d351c92a7d5e
--- /dev/null
+++ b/drivers/net/ethernet/sel/mii.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ *
+ * MII Interface (This mimics this kernel's mii library mii.c)
+ *
+ * We use our own MII functions since SFP support requires us to
+ * set specific speeds based on the SFP that is connected. These functions
+ * are pretty much exactly the same as those found in the linux kernel's
+ * standard mii.c.
+ */
+
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+
+#include "mii.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+#include "sfp.h"
+
+/**
+ * mii_get_an() - read auto-negotiation state
+ *
+ * @mii:  MII interface
+ * @addr: the address to read (MII_ADVERTISE or MII_LPA)
+ *
+ * Return: the advertised speed
+ */
+static u32 mii_get_an(struct mii_if_info *mii, u16 addr)
+{
+	u32 result = 0;
+	int advert;
+
+	advert = mii->mdio_read(mii->dev, mii->phy_id, addr);
+
+	if (addr == MII_LPA) {
+		if ((advert & LPA_LPACK) != 0)
+			result |= ADVERTISED_Autoneg;
+	}
+
+	if (addr == MII_ADVERTISE) {
+		if ((advert & ADVERTISE_10HALF) != 0)
+			result |= ADVERTISED_10baseT_Half;
+
+		if ((advert & ADVERTISE_10FULL) != 0)
+			result |= ADVERTISED_10baseT_Full;
+
+		if ((advert & ADVERTISE_100HALF) != 0)
+			result |= ADVERTISED_100baseT_Half;
+
+		if ((advert & ADVERTISE_100FULL) != 0)
+			result |= ADVERTISED_100baseT_Full;
+
+		if ((advert & ADVERTISE_PAUSE_CAP) != 0)
+			result |= ADVERTISED_Pause;
+
+		if ((advert & ADVERTISE_PAUSE_ASYM) != 0)
+			result |= ADVERTISED_Asym_Pause;
+	}
+
+	return result;
+}
+
+/**
+ * sel_mii_ethtool_gksettings() - get settings that are specified in @ecmd
+ *
+ * @mii:  MII interface
+ * @ks: ethtool ksettings
+ *
+ * Return: 0 always.
+ */
+int sel_mii_ethtool_gksettings(struct mii_if_info *mii,
+			       struct ethtool_link_ksettings *ks)
+{
+	struct sel_pci_mac *mac;
+	struct net_device *dev;
+	unsigned long flags;
+	u32 advertising = 0;
+	u32 supported = 0;
+	u16 ctrl1000 = 0;
+	u32 macstat = 0;
+	u16 bmcr;
+	u16 bmsr;
+
+	dev = mii->dev;
+	mac = netdev_priv(dev);
+
+	ks->base.autoneg = AUTONEG_DISABLE;
+	ks->base.duplex = DUPLEX_UNKNOWN;
+	ks->base.speed = SPEED_UNKNOWN;
+
+	/* PHY and MAC are logically in the same package */
+	ks->base.transceiver = XCVR_INTERNAL;
+
+	ks->base.phy_address = mii->phy_id;
+	advertising = (ADVERTISED_TP | ADVERTISED_MII);
+	if (sfp_present(mac)) {
+		/* Fiber Settings */
+		ks->base.autoneg = AUTONEG_DISABLE;
+		spin_lock_irqsave(&mac->sfp_lock, flags);
+
+		if (sel_mii_link_ok(mii)) {
+			supported |= SUPPORTED_FIBRE | SUPPORTED_MII;
+			advertising |= ADVERTISED_FIBRE;
+
+			ks->base.duplex = DUPLEX_FULL;
+
+			switch (mac->sfp_type) {
+			case E100_SERDES:
+			case E100_SGMII:
+				ks->base.speed = SPEED_100;
+				supported |= SUPPORTED_100baseT_Full;
+				advertising |= ADVERTISED_100baseT_Full;
+				break;
+
+			case E1000_SERDES:
+			case E1000_SGMII:
+				ks->base.speed = SPEED_1000;
+				supported |= SUPPORTED_1000baseT_Full;
+				advertising |= ADVERTISED_1000baseT_Full;
+				break;
+
+			default:
+				/* We shouldn't reach this point
+				 * since all connected SFPs that are 'validated'
+				 * should have part numbers we expect.
+				 * Don't print here since we have the spinlock.
+				 */
+				break;
+			}
+		}
+		spin_unlock_irqrestore(&mac->sfp_lock, flags);
+	} else {
+		bmsr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMSR);
+		/* Copper Settings */
+		supported = SUPPORTED_TP | SUPPORTED_MII;
+		if ((bmsr & BMSR_ANEGCAPABLE) == BMSR_ANEGCAPABLE)
+			supported |= SUPPORTED_Autoneg;
+		if ((bmsr & BMSR_10HALF) == BMSR_10HALF)
+			supported |= SUPPORTED_10baseT_Half;
+		if ((bmsr & BMSR_10FULL) == BMSR_10FULL)
+			supported |= SUPPORTED_10baseT_Full;
+		if ((bmsr & BMSR_100HALF) == BMSR_100HALF)
+			supported |= SUPPORTED_100baseT_Half;
+		if ((bmsr & BMSR_100FULL) == BMSR_100FULL)
+			supported |= SUPPORTED_100baseT_Full;
+
+		if (mii->supports_gmii) {
+			/* Half Duplex 1Gbps is NOT supported */
+			supported |= SUPPORTED_1000baseT_Full;
+
+			ctrl1000 = mii->mdio_read(dev, mii->phy_id, MII_CTRL1000);
+		}
+
+		macstat = ioread32(&mac->hw_mac->mac.macstat);
+		if ((macstat & MACSTAT_LINK) == 0) {
+			ks->base.autoneg = AUTONEG_DISABLE;
+			ks->base.duplex = DUPLEX_UNKNOWN;
+			ks->base.speed = SPEED_UNKNOWN;
+		} else {
+			switch (macstat & MACSTAT_SPEED_MASK) {
+			case MACSTAT_SPEED_1000MB:
+				ks->base.speed = SPEED_1000;
+				break;
+			case MACSTAT_SPEED_100MB:
+				ks->base.speed = SPEED_100;
+				break;
+			default:
+				ks->base.speed = SPEED_10;
+				break;
+			}
+			if (macstat & MACSTAT_FULL_DUPLEX)
+				ks->base.duplex = DUPLEX_FULL;
+			else
+				ks->base.duplex = DUPLEX_HALF;
+		}
+
+		bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
+		if (bmcr & BMCR_ANENABLE) {
+			/* auto-negotiated. Determine speed / duplex */
+			advertising |= ADVERTISED_Autoneg;
+			ks->base.autoneg = AUTONEG_ENABLE;
+
+			/* Check own advertised speed/duplex */
+			advertising |= mii_get_an(mii, MII_ADVERTISE);
+			if (ctrl1000 & ADVERTISE_1000FULL)
+				advertising |= ADVERTISED_1000baseT_Full;
+		} else {
+			/* Not auto-negotiated */
+			ks->base.autoneg = AUTONEG_DISABLE;
+		}
+	}
+
+	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.supported,
+						supported);
+	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.advertising,
+						advertising);
+
+	mii->full_duplex = ks->base.duplex;
+
+	/* ignore maxtxpkt, maxrxpkt for now */
+
+	return 0;
+}
+
+/**
+ * sel_mii_ethtool_sksettings() - set settings that are specified in @ecmd
+ *
+ * @mii:  MII interface
+ * @ks: ethtool ksettings
+ *
+ * Return: 0 for success, negative on error.
+ */
+int sel_mii_ethtool_sksettings(struct mii_if_info *mii,
+			       const struct ethtool_link_ksettings *ks)
+{
+	struct sel_pci_mac *mac;
+	struct net_device *dev;
+	int err = 0;
+
+	dev = mii->dev;
+	mac = netdev_priv(dev);
+
+	if (sfp_present(mac)) {
+		/* Not allowed to set anything if there is no phy or
+		 * this is a fiber port
+		 */
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.speed != SPEED_10 &&
+	    ks->base.speed != SPEED_100 &&
+	    ks->base.speed != SPEED_1000) {
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.duplex != DUPLEX_HALF && ks->base.duplex != DUPLEX_FULL) {
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.speed == SPEED_1000 && ks->base.duplex == DUPLEX_HALF) {
+		/* 1Gbps Half Duplex is NOT supported */
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.port != PORT_MII && ks->base.port != PORT_TP) {
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.transceiver != XCVR_INTERNAL) {
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.phy_address != mii->phy_id) {
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.autoneg != AUTONEG_DISABLE &&
+	    ks->base.autoneg != AUTONEG_ENABLE) {
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.autoneg != AUTONEG_ENABLE && ks->base.speed == SPEED_1000) {
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	if (ks->base.speed == SPEED_1000 && !mii->supports_gmii) {
+		err = -EINVAL;
+		goto err_invalid_input;
+	}
+
+	/* ignore supported, maxtxpkt, maxrxpkt */
+
+	if (ks->base.autoneg == AUTONEG_ENABLE) {
+		u32 requested_advertising;
+		u32 bmcr;
+		u32 advert;
+		u32 tmp;
+		u32 advert2 = 0;
+		u32 tmp2 = 0;
+
+		ethtool_convert_link_mode_to_legacy_u32(&requested_advertising,
+							ks->link_modes.advertising);
+
+		/* We support advertisement of 10/100/1000 Full/Half
+		 * duplex. However, we don't support 1 Gbps Half Duplex,
+		 * so if that's the only one requested, we error out.
+		 * Otherwise, it's masked away below.
+		 */
+		if ((requested_advertising &
+		     (ADVERTISED_10baseT_Half |
+		      ADVERTISED_10baseT_Full |
+		      ADVERTISED_100baseT_Half |
+		      ADVERTISED_100baseT_Full |
+		      ADVERTISED_1000baseT_Full)) == 0) {
+			err = -EINVAL;
+			goto err_invalid_input;
+		}
+
+		/* advertise only what has been requested */
+		advert = mii->mdio_read(dev, mii->phy_id, MII_ADVERTISE);
+		tmp = (advert & ~(ADVERTISE_ALL | ADVERTISE_100BASE4));
+		if (mii->supports_gmii) {
+			advert2 = mii->mdio_read(dev, mii->phy_id, MII_CTRL1000);
+			tmp2 = advert2 & ~(ADVERTISE_1000HALF | ADVERTISE_1000FULL);
+		}
+
+		if (requested_advertising & ADVERTISED_10baseT_Half)
+			tmp |= ADVERTISE_10HALF;
+
+		if (requested_advertising & ADVERTISED_10baseT_Full)
+			tmp |= ADVERTISE_10FULL;
+
+		if (requested_advertising & ADVERTISED_100baseT_Half)
+			tmp |= ADVERTISE_100HALF;
+
+		if (requested_advertising & ADVERTISED_100baseT_Full)
+			tmp |= ADVERTISE_100FULL;
+
+		if (mii->supports_gmii) {
+			/* we only support 1Gbps FULL duplex */
+			if (requested_advertising & ADVERTISED_1000baseT_Full)
+				tmp2 |= ADVERTISE_1000FULL;
+		}
+
+		if (advert != tmp) {
+			mii->mdio_write(dev, mii->phy_id, MII_ADVERTISE, tmp);
+			mii->advertising = tmp;
+		}
+
+		if (mii->supports_gmii && advert2 != tmp2)
+			mii->mdio_write(dev, mii->phy_id, MII_CTRL1000, tmp2);
+
+		/* turn on auto negotiation, and force a renegotiate */
+		bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
+		bmcr |= (BMCR_ANENABLE | BMCR_ANRESTART);
+		mii->mdio_write(dev, mii->phy_id, MII_BMCR, bmcr);
+
+		mii->force_media = 0;
+	} else {
+		u32 bmcr;
+		u32 tmp;
+
+		/* turn off auto negotiation, set speed and duplex */
+		bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
+		tmp = (bmcr & ~(BMCR_ANENABLE | BMCR_SPEED100 |
+				BMCR_SPEED1000 | BMCR_FULLDPLX));
+
+		if (ks->base.speed == SPEED_1000)
+			tmp |= BMCR_SPEED1000;
+		else if (ks->base.speed == SPEED_100)
+			tmp |= BMCR_SPEED100;
+
+		if (ks->base.duplex == DUPLEX_FULL) {
+			tmp |= BMCR_FULLDPLX;
+			mii->full_duplex = 1;
+		} else {
+			mii->full_duplex = 0;
+		}
+
+		if (bmcr != tmp)
+			mii->mdio_write(dev, mii->phy_id, MII_BMCR, tmp);
+
+		mii->force_media = 1;
+	}
+
+err_invalid_input:
+
+	return err;
+}
+
+/**
+ * mii_link_ok() - is link status up/ok
+ *
+ * @mii: the MII interface
+ *
+ * Return: 1 if the MII reports link status up/ok, 0 otherwise.
+ */
+int sel_mii_link_ok(struct mii_if_info *mii)
+{
+	struct sel_pci_mac *mac = netdev_priv(mii->dev);
+	u32 macstat = ioread32(&mac->hw_mac->mac.macstat);
+
+	return ((macstat & MACSTAT_LINK) != 0) ? 1 : 0;
+}
+
+/**
+ * mii_nway_restart() - restart NWay (autonegotiation) for this interface
+ *
+ * @mii: the MII interface
+ *
+ * Return: 0 on success, negative on error.
+ */
+int sel_mii_nway_restart(struct mii_if_info *mii)
+{
+	int err = -EINVAL;
+	int bmcr;
+
+	/* if autoneg is off, it's an error */
+	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
+
+	if ((bmcr & BMCR_ANENABLE) != 0) {
+		bmcr |= BMCR_ANRESTART;
+		mii->mdio_write(mii->dev, mii->phy_id, MII_BMCR, bmcr);
+		err = 0;
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/sel/mii.h b/drivers/net/ethernet/sel/mii.h
new file mode 100644
index 000000000000..83e9f254b036
--- /dev/null
+++ b/drivers/net/ethernet/sel/mii.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_MII_H_INCLUDED
+#define SEL_MII_H_INCLUDED
+
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+
+int sel_mii_ethtool_gksettings(struct mii_if_info *mii,
+			       struct ethtool_link_ksettings *ks);
+int sel_mii_ethtool_sksettings(struct mii_if_info *mii,
+			       const struct ethtool_link_ksettings *ks);
+int sel_mii_link_ok(struct mii_if_info *mii);
+int sel_mii_nway_restart(struct mii_if_info *mii);
+
+#endif /* SEL_MII_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/mii_interface.c b/drivers/net/ethernet/sel/mii_interface.c
new file mode 100644
index 000000000000..e020d074c7a4
--- /dev/null
+++ b/drivers/net/ethernet/sel/mii_interface.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/types.h>
+
+#include "hw_interface.h"
+#include "mii_interface.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+#include "sel_phy.h"
+#include "semaphore.h"
+
+/**
+ * sel_mii_wait_busy() - Wait for the MII bus to become available
+ *
+ * @hw_mac: MAC base address
+ */
+static void sel_mii_wait_busy(struct sel_pci_mac_registers *hw_mac)
+{
+	u32 mdio_ind = 0;
+
+	/* Wait for device to become available */
+	do {
+		mdio_ind = ioread32(&hw_mac->mii.miimind);
+		udelay(10);
+	} while ((mdio_ind & MIIMIND_MII_BUSY) != 0);
+}
+
+/**
+ * sel_mii_read() - Read data from a specific phy register
+ *
+ * @hw_mac: MAC base address
+ * @phy:    the phy address to read from
+ * @reg:    the register to write to
+ *
+ * Return: the value read from the PHY
+ */
+u16 sel_mii_read(struct sel_pci_mac_registers *hw_mac, int phy, u8 reg)
+{
+	u16 data = 0;
+	u32 addr = 0;
+
+	WARN_ON_ONCE((phy & ~(0x1FU)) != 0);
+	WARN_ON_ONCE((reg & ~(0x1FU)) != 0);
+
+	/* acquire the hw semaphore and perform the read cycle */
+	sel_semaphore_acquire(hw_mac, SMI);
+
+	sel_mii_wait_busy(hw_mac);
+
+	addr = (phy << MIIMADD_MII_PHY_ADDR_OFFSET);
+	addr |= reg;
+
+	/* Set the address we wish to read from */
+	iowrite32(addr, &hw_mac->mii.miimadd);
+
+	sel_read_mod_write(&hw_mac->mii.miimcom, MIIMCOM_MII_READ_CYCLE, 0);
+	sel_mii_wait_busy(hw_mac);
+
+	/* Read the data returned */
+	data = (u16)ioread32(&hw_mac->mii.miimstat);
+
+	/* Clear the read cycle */
+	sel_read_mod_write(&hw_mac->mii.miimcom, 0, MIIMCOM_MII_READ_CYCLE);
+
+	sel_semaphore_release(hw_mac, SMI);
+
+	return data;
+}
+
+/**
+ * sel_mii_write() - Write data to a specific phy register
+ *
+ * @hw_mac: MAC base address
+ * @phy:    the phy address to write to
+ * @reg:    the register to write to
+ * @val:    the value to write
+ */
+void sel_mii_write(struct sel_pci_mac_registers *hw_mac, int phy, u8 reg, u16 val)
+{
+	u32 addr = 0;
+
+	WARN_ON_ONCE((phy & ~(0x1FU)) != 0);
+	WARN_ON_ONCE((reg & ~(0x1FU)) != 0);
+
+	/* acquire the hw semaphore and perform the write */
+	sel_semaphore_acquire(hw_mac, SMI);
+
+	/* Wait for bus to become available */
+	sel_mii_wait_busy(hw_mac);
+
+	addr = (phy << MIIMADD_MII_PHY_ADDR_OFFSET);
+	addr |= reg;
+	iowrite32(addr, &hw_mac->mii.miimadd);
+
+	iowrite32(val, &hw_mac->mii.miimcon);
+	sel_mii_wait_busy(hw_mac);
+
+	sel_semaphore_release(hw_mac, SMI);
+}
+
+/**
+ * sel_mii_read_mod_write() - Read/Modify/Write a PHY register
+ *
+ * @hw_mac:     MAC base address
+ * @phy:        the phy address to modify
+ * @reg:        the register to modify
+ * @set_bits:   the bits to set in the register
+ * @clear_bits: the bits to clear in the register
+ */
+void sel_mii_read_mod_write(struct sel_pci_mac_registers *hw_mac,
+			    int phy,
+			    u8 reg,
+			    u16 set_bits,
+			    u16 clear_bits)
+{
+	u32 data = 0;
+
+	WARN_ON_ONCE((phy & ~(0x1FU)) != 0);
+	WARN_ON_ONCE((reg & ~(0x1FU)) != 0);
+
+	data = sel_mii_read(hw_mac, phy, reg);
+	data |= set_bits;
+	data &= ~clear_bits;
+	sel_mii_write(hw_mac, phy, reg, data);
+}
diff --git a/drivers/net/ethernet/sel/mii_interface.h b/drivers/net/ethernet/sel/mii_interface.h
new file mode 100644
index 000000000000..b8f88fe1e1a0
--- /dev/null
+++ b/drivers/net/ethernet/sel/mii_interface.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_MII_INTERFACE_H_INCLUDED
+#define SEL_MII_INTERFACE_H_INCLUDED
+
+#include <linux/types.h>
+
+#include "pci_mac_hw_regs.h"
+
+u16 sel_mii_read(struct sel_pci_mac_registers *hw_mac, int phy, u8 reg);
+void sel_mii_write(struct sel_pci_mac_registers *hw_mac, int phy, u8 reg, u16 val);
+void sel_mii_read_mod_write(struct sel_pci_mac_registers *hw_mac,
+			    int phy,
+			    u8 reg,
+			    u16 set_bits,
+			    u16 clear_bits);
+
+#endif /* SEL_MII_INTERFACE_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/netdev.c b/drivers/net/ethernet/sel/netdev.c
new file mode 100644
index 000000000000..febce748211b
--- /dev/null
+++ b/drivers/net/ethernet/sel/netdev.c
@@ -0,0 +1,946 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+#include <linux/netdev_features.h>
+#include <linux/rtnetlink.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <uapi/linux/sockios.h>
+
+#include "ethtool.h"
+#include "hw_interface.h"
+#include "mdio.h"
+#include "mii.h"
+#include "netdev.h"
+#include "netdev_isr.h"
+#include "netdev_rx.h"
+#include "netdev_tx.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+#include "pci_mac_sysfs.h"
+#include "sel_pci_mac_ioctl.h"
+#include "sel_phy.h"
+#include "sfp.h"
+
+/* Default Tracing Level ( 0 > debug > 32 ) */
+#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
+
+/* Supported Interrupts */
+static const u32 SEL_SUPPORTED_IMASKS =
+	(IRQ_RXF_BIT  |
+	 IRQ_TXF_BIT  |
+	 IRQ_SFP_BIT  |
+	 IRQ_LINK_BIT |
+	 IRQ_DMA_ERR_BIT  |
+	 IRQ_PORT_ERR_BIT |
+	 IRQ_RX_HALTED_BIT);
+
+/**
+ * sel_open() - Called when the net device transitions to the up state
+ *
+ * @netdev: net device object
+ *
+ * Return: 0 if successful, otherwise appropriate negative error code
+ */
+static int sel_open(struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	return sel_up(mac);
+}
+
+/**
+ * sel_close() - Called when the net device transitions to the down state
+ *
+ * @netdev: net device object
+ *
+ * Return: 0 always.
+ */
+static int sel_close(struct net_device *netdev)
+{
+	sel_down(netdev_priv(netdev));
+
+	return 0;
+}
+
+/**
+ * sel_set_mac() - Set the net device mac address
+ *
+ * @netdev:     the net device object
+ * @mac_addr:  the mac address to set
+ *
+ * The mac address is also set in hardware here as well
+ *
+ * Return: 0 if successful, otherwise appropriate negative error code
+ */
+static int sel_set_mac(struct net_device *netdev, void *mac_addr)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+	struct sockaddr *addr = mac_addr;
+
+	if (!addr)
+		return -EINVAL;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	dev_addr_mod(netdev, 0, addr->sa_data, ETH_ALEN);
+
+	sel_set_hw_mac_addr(mac->hw_mac, netdev->dev_addr);
+	return 0;
+}
+
+/**
+ * sel_set_rx_mode() - Adjust network device receive packet filter
+ *
+ * @netdev: net device object
+ */
+static void sel_set_rx_mode(struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	if ((netdev->flags & IFF_PROMISC) != 0)
+		sel_enable_promiscuous_mode(mac->hw_mac);
+	else
+		sel_disable_promiscuous_mode(mac->hw_mac);
+
+	if ((netdev->flags & IFF_ALLMULTI) == IFF_ALLMULTI) {
+		/* Enable multicast for all addresses */
+		sel_enable_multicast(mac->hw_mac);
+	} else if ((netdev->flags & IFF_MULTICAST) == IFF_MULTICAST) {
+		/* Set up the multicast list in hardware*/
+		sel_write_mc_addr_list(mac->hw_mac, netdev);
+	} else {
+		/* Disable multicast for all addresses */
+		sel_disable_multicast(mac->hw_mac);
+	}
+}
+
+/**
+ * sel_get_stats() - Return device stats
+ *
+ * @netdev: net device object
+ *
+ * Return: device statistics
+ */
+static struct net_device_stats *sel_get_stats(struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	return &mac->stats;
+}
+
+/**
+ * sel_change_mtu() - Set a new MTU for a net device
+ *
+ * @netdev:  the net device to configure
+ * @new_mtu: the mtu to set
+ *
+ * Return: 0 if successful, otherwise negative error code
+ */
+static int sel_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	netdev->mtu = new_mtu;
+
+	/* If the adapter was UP when MTU was changed, we have to
+	 * bring it down and then back up to change the size
+	 */
+	if (netif_running(netdev)) {
+		sel_down(mac);
+		(void)sel_up(mac);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/**
+ * sel_netpoll() - Polling Interrupt
+ *
+ * @netdev: net device object
+ *
+ * Used by things like netconsole to send skbs without having to
+ * re-enable interrupts. It's not called while the interrupt routine
+ * is executing.
+ */
+static void sel_netpoll(struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	sel_disable_irq(mac->hw_mac, ~0U);
+
+	sel_intr_transmit(mac->transmit_irq, netdev);
+	sel_intr_receive(mac->receive_irq, netdev);
+	sel_intr_misc(mac->misc_irq, netdev);
+	sel_enable_irq(mac->hw_mac, SEL_SUPPORTED_IMASKS);
+}
+#endif
+
+/**
+ * sel_set_features() - Set user changeable features
+ *
+ * @netdev: net device object
+ * @features: changed features
+ *
+ * Called when the user tries to change
+ * the features specified in hw_feature list
+ * of the net device
+ */
+static int sel_set_features(struct net_device *netdev, netdev_features_t features)
+{
+	netdev_features_t changed = features ^ netdev->features;
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	/* Return if receive checksum or transmit checksum is not changed */
+	if (!(changed & (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)))
+		return 0;
+
+	/* Update the receive and transmit checksum enable fields in the
+	 * private struct
+	 */
+	netdev->features = features;
+	mac->rx_csum_enabled =
+		!!(features & (NETIF_F_RXCSUM | NETIF_F_IPV6_CSUM));
+
+	/* no need to keep track of a tx csum enabled, OS will not send
+	 * us partially checksummed packets if user disables tx csum
+	 * using ethtool
+	 */
+
+	return 0;
+}
+
+/*
+ * sel_config_hwtstamp() - Configures the hwtstamp register
+ *
+ * @mac: netdevice private context
+ * @config: hw timestamp config
+ *
+ * @return: Negative error code on error, or zero on success
+ */
+static int sel_config_hwtstamp(struct sel_pci_mac *mac,
+			       struct hwtstamp_config *config)
+{
+	/* flags reserved for future extensions*/
+	if (config->flags != 0)
+		return -EINVAL;
+
+	/* Nothing to do hw wise for rx or tx. Therefore there is no
+	 * configuration needed for tx as it is just on or off.
+	 *
+	 * This driver currently supports an all on, or all off rx
+	 * filter model. Therefore any filter request will result in
+	 * timestamping all packets.
+	 */
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		config->rx_filter = 0;
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_ALL:
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	mac->hwtstamp_config = *config;
+
+	return 0;
+}
+
+/*
+ * sel_private_ioctl() - ioctl for sel mac driver's custom ioctls
+ *
+ * @netdev - Netdevice for this nic
+ * @ifreq - Interface request struct for socket ioctls
+ * @addr - The address provided by userspace for this operation
+ * @cmd - The command operation for this ioctl
+ *
+ * @return - Negative error code on error, or zero on success
+ */
+static int sel_private_ioctl(struct net_device *netdev,
+			     struct ifreq *ifr,
+			     void __user *addr,
+			     int cmd)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+	struct sel_pci_mac_ethercat ecat;
+	int ret_val = 0;
+
+	switch (cmd) {
+	case SEL_PCI_MAC_ETHERCAT_GET:
+		ecat.ethercat_enabled = ioread32(&mac->hw_mac->ethercat.config);
+		ecat.offset = ioread32(&mac->hw_mac->ethercat.offset);
+
+		ret_val = copy_to_user(addr, &ecat,
+				       sizeof(ecat)) ? -EFAULT : 0;
+		break;
+	case SEL_PCI_MAC_ETHERCAT_SET:
+		if (copy_from_user(&ecat, addr, sizeof(ecat))) {
+			ret_val = -EFAULT;
+			break;
+		}
+
+		if (ecat.ethercat_enabled)
+			iowrite32(0x1u, &mac->hw_mac->ethercat.config);
+		else
+			iowrite32(0x0u, &mac->hw_mac->ethercat.config);
+		iowrite32(ecat.offset, &mac->hw_mac->ethercat.offset);
+
+		break;
+	default:
+		ret_val = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret_val;
+}
+
+/*
+ * sel_ioctl() - ioctl for sel mac driver
+ *
+ * @netdev - Netdevice for this nic
+ * @ifreq - Interface request struct for socket ioctls
+ * @cmd - The command operation for this ioctl
+ *
+ * @return - Negative error code on error, or zero on success
+ */
+static int sel_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+	struct hwtstamp_config config;
+	int ret_val = 0;
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		/* Retrieve the current config, update it, and copy it back */
+		if (copy_from_user(&config, ifr->ifr_data, sizeof(config))) {
+			ret_val = -EFAULT;
+			break;
+		}
+
+		ret_val = sel_config_hwtstamp(mac, &config);
+		if (ret_val == 0) {
+			ret_val = copy_to_user(ifr->ifr_data, &config,
+					       sizeof(config)) ? -EFAULT : 0;
+		}
+		break;
+	case SIOCGHWTSTAMP:
+		/* Copy the current config back to the user */
+		ret_val = copy_to_user(ifr->ifr_data, &mac->hwtstamp_config,
+				       sizeof(mac->hwtstamp_config)) ? -EFAULT : 0;
+		break;
+	default:
+		/* Continue to call our private ioctls to support kernels
+		 * where they have not been separated.
+		 */
+		ret_val = sel_private_ioctl(netdev, ifr, ifr->ifr_data, cmd);
+		break;
+	}
+
+	return ret_val;
+}
+
+static void sel_phylink_restart(struct work_struct *work)
+{
+	struct sel_pci_mac *mac = container_of(work,
+					       struct sel_pci_mac,
+					       phylink_task.work);
+	u32 macstat = ioread32(&mac->hw_mac->mac.macstat);
+	int cur_link =  macstat & MACSTAT_LINK;
+
+	if (!cur_link && mac->generic_phy->sel_phy_linkdown_poll) {
+		mac->generic_phy->sel_phy_linkdown_poll(mac->hw_mac,
+							mac->mii_if.phy_id);
+		schedule_delayed_work(&mac->phylink_task, PHYLINK_RETRY_PERIOD);
+	}
+}
+
+/* Management hooks for the SEL network devices */
+static const struct net_device_ops sel_netdev_ops = {
+	.ndo_open               = sel_open,
+	.ndo_stop               = sel_close,
+	.ndo_start_xmit         = sel_xmit_frame,
+	.ndo_set_rx_mode        = sel_set_rx_mode,
+	.ndo_set_mac_address    = sel_set_mac,
+	.ndo_change_mtu         = sel_change_mtu,
+	.ndo_tx_timeout         = sel_tx_timeout,
+	.ndo_validate_addr      = eth_validate_addr,
+	.ndo_get_stats          = sel_get_stats,
+	.ndo_eth_ioctl          = sel_ioctl,
+	.ndo_siocdevprivate     = sel_private_ioctl,
+	.ndo_do_ioctl           = sel_ioctl,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller    = sel_netpoll,
+#endif
+	.ndo_set_features	= sel_set_features,
+};
+
+/**
+ * sel_up() - Initialize and start the network interface
+ *
+ * @mac: net device context
+ *
+ * Return: 0 if successful, otherwise appropriate negative error value
+ */
+int sel_up(struct sel_pci_mac *mac)
+{
+	int err;
+
+	sel_hw_reset(mac->hw_mac);
+	netif_carrier_off(mac->netdev);
+
+	err = selpcimac_rx_initialize(mac);
+	if (err != 0) {
+		netif_err(mac, ifup, mac->netdev,
+			  "[ERROR] Failed to allocate receive memory.\n");
+		goto all_done;
+	}
+
+	err = sel_alloc_transmit_memory(mac);
+	if (err != 0) {
+		netif_err(mac, ifup, mac->netdev,
+			  "[ERROR] Failed to allocate transmit memory.\n");
+		goto err_rx_clean_list;
+	}
+
+	/* HW requires us to read the mac address from the mac_addr_in registers
+	 * and write it back to the mac_addr_set registers. We retrieved the mac
+	 * address as part of device add. But need to set it before starting the
+	 * nic.
+	 */
+	sel_set_hw_mac_addr(mac->hw_mac, mac->netdev->dev_addr);
+
+	/* Start up the PHY */
+	mac->generic_phy->sel_phy_power_up(mac->hw_mac, mac->mii_if.phy_id);
+
+	/* Reset the PHY to a known configuration */
+	err = mac->generic_phy->sel_phy_reset(mac->hw_mac, mac->mii_if.phy_id);
+	if (err != 0) {
+		netif_err(mac, ifup, mac->netdev,
+			  "[ERROR] Could not reset the PHY.\n");
+		goto err_rx_clean_list;
+	}
+
+	/* Setup the PHY with required settings */
+	mac->generic_phy->sel_phy_setup(mac->hw_mac, mac->mii_if.phy_id);
+
+	/* Initialized the link work item. */
+	INIT_DELAYED_WORK(&mac->phylink_task, sel_phylink_restart);
+
+	/* Attach the shared PCI interrupt to this net device */
+	err = request_irq(mac->transmit_irq,
+			  sel_intr_transmit,
+			  IRQF_SHARED,
+			  mac->netdev->name,
+			  mac->netdev);
+	if (err != 0)
+		goto err_tx_clean_list;
+
+	err = request_irq(mac->receive_irq,
+			  sel_intr_receive,
+			  IRQF_SHARED,
+			  mac->netdev->name,
+			  mac->netdev);
+	if (err != 0)
+		goto free_transmit_irq;
+
+	err = request_irq(mac->misc_irq,
+			  sel_intr_misc,
+			  IRQF_SHARED,
+			  mac->netdev->name,
+			  mac->netdev);
+	if (err != 0)
+		goto free_receive_irq;
+
+	/* Set LEDs into mac mode */
+	iowrite32(ETH_LED_NORMAL, &mac->hw_mac->led.eth_led);
+
+	/* Reset receive filter (multicast list, promiscuous mode, etc) */
+	sel_set_rx_mode(mac->netdev);
+
+	/* Turn on jumbo frame support if needed */
+	if (mac->netdev->mtu > ETH_DATA_LEN)
+		sel_enable_jumbo_frames(mac->hw_mac);
+	else
+		sel_disable_jumbo_frames(mac->hw_mac);
+
+	/* Initialize any SFPs */
+	sfp_init(mac);
+	sfp_update(mac);
+
+	/* Start the transmitter */
+	sel_start_transmitter(mac->hw_mac);
+
+	/* Start the receiver */
+	sel_start_receiver(mac->hw_mac);
+
+	/* Start accepting transmit packets */
+	netif_wake_queue(mac->netdev);
+
+	/* Enable NAPI polling */
+	napi_enable(&mac->napi_rx);
+	napi_enable(&mac->napi_tx);
+
+	/* Detect link state since interrupts have not yet been enabled */
+	sel_check_and_report_link_status(mac->hw_mac, mac->netdev);
+
+	/* Enable interrupts */
+	sel_enable_irq(mac->hw_mac, SEL_SUPPORTED_IMASKS);
+
+	goto all_done;
+
+free_receive_irq:
+	free_irq(mac->receive_irq, mac->netdev);
+
+free_transmit_irq:
+	free_irq(mac->transmit_irq, mac->netdev);
+
+err_tx_clean_list:
+	sel_free_transmit_memory(mac);
+
+err_rx_clean_list:
+	selpcimac_rx_cleanup(mac);
+
+all_done:
+	return err;
+}
+
+/**
+ * sel_down() - Shutdown the network interface
+ *
+ * @mac: net device context
+ */
+void sel_down(struct sel_pci_mac *mac)
+{
+	/* If a tx clean is in progress, we need to wait */
+	while (test_and_set_bit(SYNC_FLAGS_TX_BD_CLEANING, &mac->sync_flags)) {
+		// Give time back to the processor while we wait
+		schedule();
+	}
+
+	/* Disable NAPI polling. We have to do this before the
+	 * sel_disable_irq call because the napi functions re-enable
+	 * interrupts on completion.
+	 */
+	napi_disable(&mac->napi_tx);
+	napi_disable(&mac->napi_rx);
+
+	/* Disable interrupts */
+	sel_disable_irq(mac->hw_mac, ~0U);
+
+	/* Stop the link poll if it is running */
+	cancel_delayed_work_sync(&mac->phylink_task);
+
+	/* Disable the attached SFP (if any) */
+	sfp_exit(mac);
+
+	/* Stop the transmit queue */
+	if (!netif_queue_stopped(mac->netdev)) {
+		/* Same as netif_stop_queue, except it guarantees that
+		 * xmit function is not running on any other processors
+		 */
+		netif_tx_disable(mac->netdev);
+	}
+
+	/* Stop the receiver and transmitter */
+	sel_stop_receiver(mac->hw_mac);
+	sel_stop_transmitter(mac->hw_mac);
+
+	/* Reset the PHY to a known configuration */
+	mac->generic_phy->sel_phy_reset(mac->hw_mac, mac->mii_if.phy_id);
+
+	/* Stop and power down the PHY */
+	mac->generic_phy->sel_phy_power_down(mac->hw_mac, mac->mii_if.phy_id);
+
+	/* Free the IRQs */
+	free_irq(mac->misc_irq, mac->netdev);
+	free_irq(mac->receive_irq, mac->netdev);
+	free_irq(mac->transmit_irq, mac->netdev);
+
+	/* Free the transmit and receive memory */
+	selpcimac_rx_cleanup(mac);
+	sel_free_transmit_memory(mac);
+
+	/* Explicitly set the link state as down */
+	netif_carrier_off(mac->netdev);
+
+	/* Clear the cleaning bit so it is not set when sel_up is called */
+	clear_bit(SYNC_FLAGS_TX_BD_CLEANING, &mac->sync_flags);
+}
+
+/**
+ * sel_reset_task() - Asynchronous device reset workitem.
+ *
+ * @work: work item object
+ * @data: work item object
+ */
+static void sel_reset_task(struct work_struct *work)
+{
+	/* This net device is unresponsive, so restart it */
+	struct sel_pci_mac *mac = container_of(work,
+					       struct sel_pci_mac,
+					       reset_task);
+
+	struct net_device *netdev = mac->netdev;
+
+	/* We grab the semaphore used by the kernel during netdev
+	 * open() and close() before we reset
+	 * to protect against any other reset operations.
+	 */
+
+	rtnl_lock();
+	if (netif_running(netdev)) {
+		sel_down(mac);
+		(void)sel_up(mac);
+	}
+	rtnl_unlock();
+}
+
+/**
+ * unregister_net_device() - Unregister the netdevice
+ *
+ *  @mac: net device context
+ */
+static void unregister_net_device(struct sel_pci_mac *mac)
+{
+	struct net_device *netdev = mac->netdev;
+
+	unregister_netdev(netdev);
+}
+
+/**
+ * register_net_device() - Register the netdevice
+ *
+ *  @mac: net device context
+ *
+ * Return: 0 if successful, otherwise negative error code
+ */
+static int register_net_device(struct sel_pci_mac *mac)
+{
+	/* Let's reset the device before we register it */
+	sel_hw_reset(mac->hw_mac);
+
+	return register_netdev(mac->netdev);
+}
+
+/**
+ * setup_net_device() - Setup the net_device structure for the MAC
+ *
+ * @mac: selpcimac context that contains the net_device structure
+ *
+ */
+static void setup_net_device(struct sel_pci_mac *mac)
+{
+	SET_NETDEV_DEV(mac->netdev, mac->current_dev);
+
+	mac->netdev->netdev_ops = &sel_netdev_ops;
+
+	mac->netdev->features = NETIF_F_SG;
+
+	mac->netdev->min_mtu = ETH_MIN_MTU;
+	if (mac->cap_jumbo_frame) {
+		mac->netdev->max_mtu = SEL_MAX_JUMBO_FRAME_SIZE -
+			(ETH_HLEN + ETH_FCS_LEN);
+	} else {
+		mac->netdev->max_mtu = ETH_DATA_LEN;
+	}
+
+	mac->rx_csum_enabled = false;
+
+	if (mac->cap_csum_offload) {
+		mac->netdev->features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+		mac->netdev->features |= NETIF_F_RXCSUM;
+		mac->netdev->hw_features =
+			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM;
+		mac->rx_csum_enabled = true;
+	}
+	if (mac->dma_64_bit)
+		mac->netdev->features |= NETIF_F_HIGHDMA;
+
+	/* Set the transmit timeout */
+	mac->netdev->watchdog_timeo = SEL_TX_TIMEOUT;
+
+	/* Assign a port identifier for userspace */
+	mac->netdev->dev_port = mac->port_num + 1;
+
+	/* Set up the attributes group */
+	sel_set_attributes(mac->netdev);
+
+	/* Set up the ethtool operations */
+	sel_set_ethtool_ops(mac->netdev);
+
+	/* We give the device a name with the "%d" so the kernel
+	 * can replace it with a respectable name, such as eth0.
+	 */
+	strscpy(mac->netdev->name, "eth%d", sizeof(mac->netdev->name));
+
+	/* Register the NAPI polling operation */
+	netif_napi_add(mac->netdev, &mac->napi_rx, sel_poll_rx);
+
+	netif_napi_add_tx_weight(mac->netdev, &mac->napi_tx, sel_poll_tx, 2);
+}
+
+/**
+ * read_information() - Read in device information from the hardware
+ *
+ * @mac: Context for this selpcimac device.
+ */
+static void read_information(struct sel_pci_mac *mac)
+{
+	u32 value = ioread32(&mac->hw_mac->mac.revision);
+
+	mac->major = (value >> 8) & 0xFF;
+	mac->minor = value & 0xFF;
+
+	value = ioread32(&mac->hw_mac->mac.port_num);
+	mac->phy_address = (value & PORT_NUM_PHY_ADDR_MASK) >> PORT_NUM_PHY_ADDR_BITSHIFT;
+	mac->port_num = value & PORT_NUM_MASK;
+
+	sel_get_hw_mac_addr(mac->hw_mac, mac->netdev->perm_addr, ETH_ALEN);
+
+	netdev_vdbg(mac->netdev, "Port [%d] MAC Address: %pM\n",
+		    mac->port_num,
+		    &mac->netdev->perm_addr);
+
+	if (!is_valid_ether_addr(mac->netdev->perm_addr)) {
+		netdev_vdbg(mac->netdev, "---------------------------------------------\n");
+		netdev_vdbg(mac->netdev, "Invalid MAC address detected: %pM\n",
+			    &mac->netdev->perm_addr);
+		netdev_vdbg(mac->netdev, "---------------------------------------------\n");
+		memset(mac->netdev->perm_addr, 0xFF, ETH_ALEN);
+	}
+	dev_addr_mod(mac->netdev, 0, mac->netdev->perm_addr, ETH_ALEN);
+
+	value = ioread32(&mac->hw_mac->mac.macstat);
+	mac->max_buffer_sz = value >> 16;
+}
+
+/**
+ * read_capabilities() - Read and decode the device capabilities
+ *
+ * @mac: Context for this selpcimac device.
+ */
+static void read_capabilities(struct sel_pci_mac *mac)
+{
+	u32 value = ioread32(&mac->hw_mac->mac.capabilities);
+
+	mac->cap_legacy = (value & CAPABILITIES_LEGACY) ==
+		CAPABILITIES_LEGACY;
+
+	mac->cap_csum_offload =
+		(value & CAPABILITIES_CSUM_OFFLOAD) ==
+		CAPABILITIES_CSUM_OFFLOAD;
+
+	mac->cap_jumbo_frame =
+		(value & CAPABILITIES_JUMBO_FRAMES) ==
+		CAPABILITIES_JUMBO_FRAMES;
+
+	/* Future RTL enhancement will allow hw to inform if this
+	 * capability exists. Set it to true for now until the RTL
+	 * enhancement is made.
+	 */
+	mac->cap_timestamp = true;
+}
+
+/**
+ * set_defaults() - Sets up default values in private mac struct and hw
+ *
+ * @mac: Context for this selpcimac device.
+ */
+static void set_defaults(struct sel_pci_mac *mac)
+{
+	mac->sfp_configuration = SFP_AUTO;
+
+	mac->interrupt_moderation_rate = INTR_MOD_MED;
+	sel_set_intr_mod_rate(mac->interrupt_moderation_rate, mac->hw_mac);
+}
+
+/**
+ * selpcimac_suspend_device() - Detach and bring down the netdevice
+ *
+ * @mac: net device context
+ */
+void selpcimac_suspend_device(struct sel_pci_mac *mac)
+{
+	/* Mark this device as removed and no longer available */
+	netif_device_detach(mac->netdev);
+
+	/* Bring down the net device */
+
+	if (netif_running(mac->netdev))
+		sel_down(mac);
+}
+
+/**
+ * selpcimac_resume_device() - Attach and bring up the netdevice
+ *
+ * @mac: net device context
+ */
+void selpcimac_resume_device(struct sel_pci_mac *mac)
+{
+	int err = 0;
+
+	if (netif_running(mac->netdev) && (sel_up(mac) != 0)) {
+		err = -EIO;
+		goto shutdown_device;
+	}
+
+	netif_device_attach(mac->netdev);
+	return;
+
+shutdown_device:
+
+	selpcimac_suspend_device(mac);
+}
+
+/**
+ * selpcimac_add_device() - Add a new selpcimac device to the system
+ *
+ * @address: mapped base address of the selpcimac device
+ * @transmit_irq: first assigned interrupt for the device
+ * @receive_irq: second assigned interrupt for the device
+ * @misc_irq: third assigned interrupt for the device
+ * @dev: device for the selpcimac
+ *
+ * Return: A device context structure that should be passed to all other
+ *         selpcimac functions.
+ */
+void *selpcimac_add_device(void __iomem *address,
+			   int transmit_irq,
+			   int receive_irq,
+			   int misc_irq,
+			   struct device *dev)
+{
+	struct net_device *netdev;
+	struct sel_pci_mac *mac;
+	int rc = 0;
+
+	netdev = alloc_etherdev(sizeof(struct sel_pci_mac));
+	if (!netdev)
+		goto exit_failure;
+
+	mac = netdev_priv(netdev);
+	mac->netdev = netdev;
+	mac->hw_mac = address;
+	mac->transmit_irq = transmit_irq;
+	mac->receive_irq = receive_irq;
+	mac->misc_irq = misc_irq;
+	mac->current_dev = dev;
+
+	/* Ensure the MAC is in known good state before accessing anything */
+	sel_hw_reset(mac->hw_mac);
+
+	read_capabilities(mac);
+
+	/* This driver does not support the Legacy firmware */
+	if (mac->cap_legacy) {
+		netdev_warn(mac->netdev,
+			    "SEL Mac: Legacy firmware detected. Please perform a firmware update.\n");
+		goto free_net_device;
+	}
+
+	read_information(mac);
+
+	set_defaults(mac);
+
+	/* Need to pass parent device because the following calls need
+	 * a device with access to physical hardware.
+	 */
+	if (dma_set_mask(mac->current_dev->parent, DMA_BIT_MASK(64)) == 0) {
+		dma_set_coherent_mask(mac->current_dev->parent, DMA_BIT_MASK(64));
+		mac->dma_64_bit = true;
+	} else if (dma_set_mask(mac->current_dev->parent, DMA_BIT_MASK(32)) == 0) {
+		dma_set_coherent_mask(mac->current_dev->parent, DMA_BIT_MASK(32));
+		mac->dma_64_bit = false;
+	} else {
+		/* Failed to set the DMA mask to 64-bit or 32-bit */
+		goto free_net_device;
+	}
+
+	spin_lock_init(&mac->tx_lock);
+	spin_lock_init(&mac->sfp_lock);
+
+	mac->num_rx_bds = SEL_NUM_RX_BDS;
+	mac->num_tx_bds = SEL_NUM_TX_BDS;
+
+	/* Turn off all private ethtool settings */
+	mac->private_ethtool_settings = 0;
+
+	/* Setup netif messaging flags, use default */
+	mac->msg_enable = netif_msg_init(-1, DEFAULT_MSG_ENABLE);
+
+	/* Initialize the transmit work_queue item.
+	 * This work_t is scheduled by the net_dev tx_timeout function
+	 * using the default workqueue provided by the kernel
+	 */
+	INIT_WORK(&mac->reset_task, sel_reset_task);
+
+	/* Setup the net device for this mac */
+	setup_net_device(mac);
+
+	/* Initialize the attached PHY
+	 * This has to be done after the allocation of
+	 * the net devices
+	 */
+	rc = sel_mdio_probe(mac);
+	if (rc != 0) {
+		netdev_err(mac->netdev,
+			   "SEL PCI MAC: ERROR: No Ethernet PHY found\n");
+		goto teardown_net_device;
+	}
+
+	/* Register the net device for this mac */
+	rc = register_net_device(mac);
+	if (rc != 0)
+		goto teardown_net_device;
+
+	return mac;
+
+teardown_net_device:
+	netif_napi_del(&mac->napi_tx);
+	netif_napi_del(&mac->napi_rx);
+
+free_net_device:
+	free_netdev(mac->netdev);
+
+exit_failure:
+	return NULL;
+}
+
+/**
+ * selpcimac_remove_device() - remove a selpcimac device from the system
+ *
+ * @mac: selpcimac context returned from selpcimac_add_device
+ */
+void selpcimac_remove_device(struct sel_pci_mac *mac)
+{
+	cancel_work_sync(&mac->reset_task);
+	unregister_net_device(mac);
+	netif_napi_del(&mac->napi_tx);
+	netif_napi_del(&mac->napi_rx);
+	free_netdev(mac->netdev);
+}
diff --git a/drivers/net/ethernet/sel/netdev.h b/drivers/net/ethernet/sel/netdev.h
new file mode 100644
index 000000000000..463326386ba1
--- /dev/null
+++ b/drivers/net/ethernet/sel/netdev.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_NETDEV_H_INCLUDED
+#define SEL_NETDEV_H_INCLUDED
+
+#include "pci_mac.h"
+
+int sel_up(struct sel_pci_mac *mac);
+void sel_down(struct sel_pci_mac *mac);
+void selpcimac_suspend_device(struct sel_pci_mac *mac);
+void selpcimac_resume_device(struct sel_pci_mac *mac);
+void *selpcimac_add_device(void __iomem *address,
+			   int transmit_irq,
+			   int receive_irq,
+			   int misc_irq,
+			   struct device *dev);
+void selpcimac_remove_device(struct sel_pci_mac *mac);
+
+#endif /* SEL_NETDEV_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/netdev_isr.c b/drivers/net/ethernet/sel/netdev_isr.c
new file mode 100644
index 000000000000..fe18178294ea
--- /dev/null
+++ b/drivers/net/ethernet/sel/netdev_isr.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/netdevice.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "netdev_isr.h"
+#include "netdev_rx.h"
+#include "netdev_tx.h"
+#include "hw_interface.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+#include "mii.h"
+#include "sfp.h"
+
+/**
+ * sel_intr_receive() - handler for rx interrupts
+ *
+ * @irq: interrupt number
+ * @dev_id: context passed to interrupt handler
+ *
+ * Return:
+ *  IRQ_NONE if there is no interrupt for this driver to process.
+ *  IRQ_HANDLED if this driver processed the interrupt.
+ */
+irqreturn_t sel_intr_receive(int irq, void *dev_id)
+{
+	struct sel_pci_mac *mac = netdev_priv(dev_id);
+	u32 event;
+	u32 mask;
+
+	/* This same routine is used for legacy pci interrupts, so make
+	 * sure it's ours before we process it
+	 */
+	event = ioread32(&mac->hw_mac->irq_ctrl.event_set);
+	mask = ioread32(&mac->hw_mac->irq_ctrl.mask_set);
+
+	event &= mask & IRQ_RXF_BIT;
+	if (event == 0)
+		return IRQ_NONE;
+
+	/* Only disable the interrupts if we are definitely going to schedule
+	 * a NAPI call. This prevents us from missing an interrupt.  If
+	 * the 'other' interrupt comes in then we can safely ignore it
+	 * because the napi_schedule_prep() call will make sure we don't
+	 * miss servicing it.
+	 */
+	if (likely(napi_schedule_prep(&mac->napi_rx))) {
+		sel_disable_irq(mac->hw_mac, IRQ_RXF_BIT);
+		__napi_schedule(&mac->napi_rx);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * sel_intr_transmit() - handler for tx interrupts
+ *
+ * @irq: interrupt number
+ * @dev_id: context passed to interrupt handler
+ *
+ * Return:
+ *  IRQ_NONE if there is no interrupt for this driver to process.
+ *  IRQ_HANDLED if this driver processed the interrupt.
+ */
+irqreturn_t sel_intr_transmit(int irq, void *dev_id)
+{
+	struct sel_pci_mac *mac = netdev_priv(dev_id);
+	u32 event;
+	u32 mask;
+
+	/* This same routine is used for legacy pci interrupts, so make
+	 * sure it's ours before we process it
+	 */
+	event = ioread32(&mac->hw_mac->irq_ctrl.event_set);
+	mask = ioread32(&mac->hw_mac->irq_ctrl.mask_set);
+
+	event &= mask & IRQ_TXF_BIT;
+	if (event == 0)
+		return IRQ_NONE;
+
+	/* Only disable the interrupts if we are definitely going to schedule
+	 * a NAPI call. This prevents us from missing an interrupt.  If
+	 * the 'other' interrupt comes in then we can safely ignore it
+	 * because the napi_schedule_prep() call will make sure we don't
+	 * miss servicing it.
+	 */
+	if (likely(napi_schedule_prep(&mac->napi_tx))) {
+		sel_disable_irq(mac->hw_mac, IRQ_TXF_BIT);
+		__napi_schedule(&mac->napi_tx);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * sel_intr_misc() - Device interrupt handler for misc interrupts
+ *
+ * @irq: interrupt number
+ * @dev_id: context passed to interrupt handler
+ *
+ * Return:
+ *  IRQ_NONE if there is no interrupt for this driver to process.
+ *  IRQ_HANDLED if this driver processed the interrupt.
+ */
+irqreturn_t sel_intr_misc(int irq, void *dev_id)
+{
+	struct sel_pci_mac *mac = netdev_priv(dev_id);
+	u32 event;
+	u32 mask;
+
+	event = ioread32(&mac->hw_mac->irq_ctrl.event_set);
+	mask = ioread32(&mac->hw_mac->irq_ctrl.mask_set);
+
+	event &= mask;
+
+	if (event == 0)
+		return IRQ_NONE;
+
+	/* Disable interrupts */
+	sel_disable_irq(mac->hw_mac, event);
+
+	/* Ack the event(s) */
+	iowrite32(event, &mac->hw_mac->irq_ctrl.event_clr);
+
+	/* If SFPs are attached, query for them */
+	if ((event & IRQ_SFP_BIT) != 0)
+		sfp_update(mac);
+
+	/* Check link state */
+	if ((event & IRQ_LINK_BIT) != 0)
+		sel_check_and_report_link_status(mac->hw_mac, mac->netdev);
+
+	/* DMA errors are fatal, panic */
+	if ((event & IRQ_DMA_ERR_BIT) != 0)
+		panic("SEL PCI MAC: An Unrecoverable DMA error has occurred!");
+
+	/* Recoverable hardware error, driver reset needed */
+	if ((event & IRQ_PORT_ERR_BIT) != 0)
+		schedule_work(&mac->reset_task);
+
+	/* RX packets may have been dropped, update stats */
+	if ((event & IRQ_RX_HALTED_BIT) != 0)
+		mac->stats.rx_dropped++;
+
+	/* Enable interrupts */
+	sel_enable_irq(mac->hw_mac, event);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * sel_poll_rx() - Called periodically by the kernel when NAPI is enabled
+ *
+ * @napi: the napi handle
+ * @budget: the max number of packets that can be indicated
+ *
+ * In our interrupt handler, we disable interrupts and call __napi_schedule,
+ * which then calls our polling function. In this function, if we don't
+ * complete enough work (indicate a certain amount of received packets,
+ * i.e. the budget param), we re-enable interrupts and disable NAPI
+ * polling mode. NAPI polling helps to decrease the number of interrupts.
+ * The function runs in an interrupt context (softirq), however, hardware
+ * interrupts are technically still enabled. We explicitly disabled RX
+ * hardware interrupts before scheduling NAPI, so no need to worry about
+ * them ocurring.
+ *
+ * Return: the number of packets processed
+ */
+int sel_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct sel_pci_mac *mac = container_of(napi,
+					       struct sel_pci_mac,
+					       napi_rx);
+	int work_done = 0;
+
+	iowrite32(IRQ_RXF_BIT, &mac->hw_mac->irq_ctrl.event_clr);
+
+	work_done = selpcimac_rx_clean(mac, budget);
+
+	/* Don't acknowledge any pending event at this point. This may
+	 * cause the driver to miss reception or transmission of a packet.
+	 *
+	 * We need to set RHLT to ensure the receiver resumes operation
+	 * if it stopped for some reason.
+	 *
+	 * When we have processed less than the budget, this means we
+	 * haven't done the minimum required amount of work to stay in
+	 * polling mode, meaning we really haven't received many
+	 * interrupts. Thus we can safely return to interrupt mode.
+	 */
+	if (work_done < budget) {
+		napi_complete(napi);
+		sel_enable_irq(mac->hw_mac, IRQ_RXF_BIT);
+		sel_read_mod_write(&mac->hw_mac->receive.rstat, RSTAT_RHLT, 0);
+	}
+
+	return work_done;
+}
+
+/**
+ * sel_poll_rx() - Called periodically by the kernel when napi is enabled
+ *
+ * @napi: the napi handle
+ * @budget: the max number of packets that can be indicated
+ *
+ * In our interrupt handler, we disable interrupts and call __napi_schedule,
+ * which then calls our polling function. In this function, if we don't
+ * complete enough work (indicate a certain amount of received packets,
+ * i.e. the budget param), we re-enable interrupts and disable NAPI
+ * polling mode. NAPI polling helps to decrease the number of interrupts.
+ * The function runs in an interrupt context (softirq), however, hardware
+ * interrupts are technically still enabled. We explicitly disabled TX
+ * hardware interrupts before scheduling NAPI, so no need to worry about
+ * them ocurring.
+ *
+ * Return: the number of packets processed
+ */
+int sel_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct sel_pci_mac *mac = container_of(napi,
+					       struct sel_pci_mac,
+					       napi_tx);
+
+	iowrite32(IRQ_TXF_BIT, &mac->hw_mac->irq_ctrl.event_clr);
+
+	(void)sel_tx_clean(mac);
+
+	/* Don't acknowledge any pending event at this point. This may
+	 * cause the driver to miss reception or transmission of a packet.
+	 */
+
+	napi_complete(napi);
+	sel_enable_irq(mac->hw_mac, IRQ_TXF_BIT);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/sel/netdev_isr.h b/drivers/net/ethernet/sel/netdev_isr.h
new file mode 100644
index 000000000000..bc63ee227787
--- /dev/null
+++ b/drivers/net/ethernet/sel/netdev_isr.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef NETDEV_ISR_H_INCLUDED
+#define NETDEV_ISR_H_INCLUDED
+
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+
+irqreturn_t sel_intr_receive(int irq, void *dev_id);
+irqreturn_t sel_intr_transmit(int irq, void *dev_id);
+irqreturn_t sel_intr_misc(int irq, void *dev_id);
+int sel_poll_rx(struct napi_struct *napi, int budget);
+int sel_poll_tx(struct napi_struct *napi, int budget);
+
+#endif /* NETDEV_ISR_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/netdev_rx.c b/drivers/net/ethernet/sel/netdev_rx.c
new file mode 100644
index 000000000000..9150c27337fa
--- /dev/null
+++ b/drivers/net/ethernet/sel/netdev_rx.c
@@ -0,0 +1,785 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/if_ether.h>
+#include <linux/ktime.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "hw_interface.h"
+#include "netdev_rx.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+
+#define RX_BUFFER_PAD NET_SKB_PAD
+#define MAX_FRAME_SIZE 1632
+#define RX_SKBFRAG_SIZE \
+	(RX_BUFFER_PAD + MAX_FRAME_SIZE + \
+	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
+/**
+ * selpcimac_rx_alloc_page() - Allocate a network fragment page.
+ */
+static struct page *selpcimac_rx_alloc_page(struct selpcimac_rx_ring *ring)
+{
+	struct page *page = dev_alloc_page();
+
+	return page;
+}
+
+/**
+ * selpcimac_rx_free_page() - free a network fragment page.
+ */
+static void selpcimac_rx_free_page(struct selpcimac_rx_ring *ring,
+				   struct page *page)
+{
+	__free_page(page);
+}
+
+/**
+ * selpcimac_desc_to_clean() - Calculates the number of RX buffer descriptors
+ *     that are available to clean.
+ *
+ * ring->next_to_clean is the next buffer descriptor that should be cleaned.
+ * ring->next_to_use is the next buffer descriptor that the hardware will use
+ * to put data into.  All descriptors are clean if next_to_clean is one less
+ * than next_to_use.
+ *
+ * @ring: RX Ring to calculate on.
+ *
+ * Returns:  Number of buffer descriptors that are ready to clean.
+ */
+static int selpcimac_desc_to_clean(struct selpcimac_rx_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	return ((ntc >= ntu) ? ring->count : 0) + ntu - ntc - 1;
+}
+
+/**
+ * selpcimac_init_rxbd() - Readies an RXBD in the ring for hardware use.
+ *
+ * To make an RXBD ready to use for hardware we have to fill out the
+ * address to the buffer that will hold the fragment data.  We then need to
+ * set the buffer descriptor index and empty bit.  After the empty bit is
+ * set, the buffer descriptor belongs to hardware and should not be accessed
+ * until either the EMT bit is cleared by hardware, software clears the
+ * RSTAT[RX_EN] bit, or the hardware resets.
+ *
+ * @desc: Pointer to the buffer descriptor to initialize
+ * @bi:   Pointer to the buffer_info structure describing the allocated
+ *        buffer to give to hardware.
+ * @idx:  Index of the RXBD in the ring.
+ */
+static void selpcimac_init_rxbd(struct sel_rx_bd *desc,
+				struct selpcimac_rx_buffer *bi,
+				u16 idx)
+{
+	dma_addr_t addr;
+	u32 bdctrl;
+
+	WARN_ON_ONCE(!bi->page);
+
+	/* page_offset points to the beginning of the allocated memory range
+	 * but we add some padding bytes at the beginning to allow for
+	 * information to be put there.
+	 */
+	addr = bi->dma + bi->page_offset + RX_BUFFER_PAD;
+	desc->rxbd_addr0 = cpu_to_le32(lower_32_bits(addr));
+	desc->rxbd_addr1 = cpu_to_le32(upper_32_bits(addr));
+
+	/* Insert a memory barrier to ensure everything is in RAM before
+	 * we set the EMT flag and let hardware use it.
+	 */
+	wmb();
+
+	/* It's important to remember to NOT set the error bits
+	 * because hardware will not clear them, it only sets.
+	 */
+	bdctrl = RXBD_CTRL_EMT | (idx & RXBD_CTRL_ID_MASK);
+	desc->rxbd_ctrl = cpu_to_le32(bdctrl);
+}
+
+/**
+ * selpcimac_cleanup_rxbd() - Remove an RXBD from hardware control.
+ *
+ * This is only safely called if RSTAT[RX_EN] == 0
+ *
+ * @desc: Pointer to the buffer descriptor to cleanup
+ */
+static void selpcimac_cleanup_rxbd(struct sel_rx_bd *desc)
+{
+	desc->rxbd_ctrl &= (cpu_to_le32(~(RXBD_CTRL_EMT)));
+}
+
+/**
+ * selpcimac_alloc_mapped_page() - Allocate a new page and map it for DMA.
+ *
+ * This function will ensure the passed in rx_buffer has a valid page to
+ * give to the hardware.  A new page will be allocated only if the page
+ * pointer in the RX buffer is NULL.  If the page pointer is not NULL, the
+ * page is already allocated and we are reusing it.
+ *
+ * @ring: Pointer to the ring that owns the RX buffer.
+ * @bi:   Pointer to the RX buffer structure to allocate for.
+ *
+ * Returns:  true if a page was successfully allocated, false otherwise.
+ */
+static bool selpcimac_alloc_mapped_page(struct selpcimac_rx_ring *ring,
+					struct selpcimac_rx_buffer *bi)
+{
+	struct page *page = bi->page;
+	dma_addr_t dma;
+
+	/* Already allocated, nothing to do */
+	if (page)
+		return true;
+
+	page = selpcimac_rx_alloc_page(ring);
+	if (likely(page)) {
+		dma = dma_map_page(ring->dev, page, 0,
+				   PAGE_SIZE, DMA_FROM_DEVICE);
+		if (dma_mapping_error(ring->dev, dma)) {
+			selpcimac_rx_free_page(ring, page);
+			page = NULL;
+		} else {
+			bi->dma = dma;
+			bi->page = page;
+			bi->page_offset = 0;
+		}
+	}
+	return (page);
+}
+
+/**
+ * selpcimac_free_mapped_page() - Free a page allocated for an RX buffer.
+ *
+ * @ring: Pointer to the ring that owns the RX buffer.
+ * @bi:   Pointer to the RX buffer structure to allocate for.
+ */
+static void selpcimac_free_mapped_page(struct selpcimac_rx_ring *ring,
+				       struct selpcimac_rx_buffer *bi)
+{
+	if (bi->dma) {
+		dma_unmap_page(ring->dev, bi->dma, PAGE_SIZE, DMA_FROM_DEVICE);
+		bi->dma = 0;
+	}
+
+	if (bi->page) {
+		selpcimac_rx_free_page(ring, bi->page);
+		bi->page = NULL;
+	}
+}
+
+/**
+ * selpcimac_clean_rx_ring() - Clean RX buffers in the ring to prepare them
+ *     for hardware.
+ *
+ * This function will do as much as it can.  If it fails to allocate pages
+ * for a buffer, it will stop cleaning an let the process continue.  This is
+ * not necessarily a fatal error, it just means that someone used all the
+ * memory.  Limp along with what we have and hope it clears up later.
+ *
+ * @ring: Pointer to the ring to clean.
+ */
+static void selpcimac_clean_rx_ring(struct selpcimac_rx_ring *ring)
+{
+	int to_clean = selpcimac_desc_to_clean(ring);
+	struct selpcimac_rx_buffer *bi;
+	struct sel_rx_bd *desc;
+	u16 i;
+
+	/* Nothing to do */
+	if (!to_clean)
+		return;
+
+	i = ring->next_to_clean;
+	bi = &ring->buffer_info[i];
+	desc = &ring->desc[i];
+
+	do {
+		/* Failed allocation is not fatal, just bails early */
+		if (!selpcimac_alloc_mapped_page(ring, bi))
+			break;
+
+		selpcimac_init_rxbd(desc, bi, i);
+
+		--to_clean;
+		++bi;
+		++desc;
+		++i;
+		if (i == ring->count) {
+			bi = ring->buffer_info;
+			desc = ring->desc;
+			i = 0;
+		}
+	} while (to_clean);
+
+	ring->next_to_clean = i;
+	ring->next_to_alloc = i;
+}
+
+/**
+ * selpcimac_init_rx_buffers() - Initialize RX buffers for hardware use.
+ *
+ * @ring: RX ring that will own the RX buffers
+ *
+ * Returns: 0 if initialized correctly, -ENOMEM if it couldn't allocate
+ *     memory for the RX buffer array.
+ */
+static int selpcimac_init_rx_buffers(struct selpcimac_rx_ring *ring)
+{
+	WARN_ON_ONCE(!ring->desc);
+	WARN_ON_ONCE(ring->buffer_info);
+
+	ring->buffer_info = kcalloc(ring->count,
+				    sizeof(struct selpcimac_rx_buffer),
+				    GFP_KERNEL);
+	if (!ring->buffer_info)
+		return -ENOMEM;
+
+	selpcimac_clean_rx_ring(ring);
+	return 0;
+}
+
+/**
+ * selpcimac_cleanup_rx_buffers() - Cleanup the buffers in preparation for
+ *     stopping the ethernet device.
+ *
+ * This function is only safe to call if RSTAT[RX_EN] == 0
+ *
+ * @ring: Ring to cleanup RX buffers on.
+ */
+static void selpcimac_cleanup_rx_buffers(struct selpcimac_rx_ring *ring)
+{
+	struct selpcimac_rx_buffer *bi = ring->buffer_info;
+	struct sel_rx_bd *desc = ring->desc;
+	u16 i = 0;
+
+	while (i != ring->count) {
+		selpcimac_cleanup_rxbd(desc);
+		selpcimac_free_mapped_page(ring, bi);
+
+		++bi;
+		++desc;
+		++i;
+	}
+
+	ring->next_to_use = 0;
+	ring->next_to_clean = 0;
+	ring->next_to_alloc = 0;
+
+	kfree(ring->buffer_info);
+	ring->buffer_info = NULL;
+}
+
+/**
+ * selpcimac_initialize_rx_ring() - Initialize the receive ring.
+ *
+ * This function allocates the buffer descriptor ring for the hardware,
+ * initializes it, and programs it to the hardware.  It also starts the
+ * receive buffer allocation process.
+ *
+ * @ring: RX ring to initialize
+ *
+ * Returns: 0 if successful, -ENOMEM if we couldn't initialize the ring.
+ */
+static int selpcimac_initialize_rx_ring(struct selpcimac_rx_ring *ring)
+{
+	/* Allocation is an array of the currently configured number
+	 * of RX buffer descriptors rounded up to the nearest 4k.
+	 */
+	ring->size = (sizeof(struct sel_rx_bd) * ring->count);
+	ring->size = ALIGN(ring->size, 4096);
+
+	ring->desc = dma_alloc_coherent(ring->dev,
+					ring->size,
+					&ring->dma,
+					GFP_KERNEL);
+	if (!ring->desc)
+		goto err;
+
+	WARN_ON_ONCE((ring->dma % SEL_DATA_ALIGN) != 0);
+
+	memset(ring->desc, 0, ring->size);
+	ring->last_bd = ring->dma +
+		(ring->count - 1) * sizeof(struct sel_rx_bd);
+	ring->next_to_use = 0;
+	ring->next_to_clean = 0;
+
+	if (selpcimac_init_rx_buffers(ring))
+		goto err_free;
+
+	return 0;
+
+err_free:
+	dma_free_coherent(ring->dev, ring->size, ring->desc, ring->dma);
+	ring->desc = NULL;
+	ring->dma = 0;
+	ring->last_bd = 0;
+	ring->size = 0;
+err:
+	return -ENOMEM;
+}
+
+/**
+ * selpcimac_cleanup_rx_ring() - Cleanup an initialized RX ring and free
+ *     its resources.
+ *
+ * @ring: Ring to cleanup.
+ */
+static void selpcimac_cleanup_rx_ring(struct selpcimac_rx_ring *ring)
+{
+	if (ring->skb) {
+		dev_kfree_skb(ring->skb);
+		ring->skb = NULL;
+	}
+
+	if (ring->buffer_info)
+		selpcimac_cleanup_rx_buffers(ring);
+
+	if (ring->desc) {
+		dma_free_coherent(ring->dev, ring->size, ring->desc, ring->dma);
+		ring->desc = NULL;
+		ring->dma = 0;
+		ring->last_bd = 0;
+		ring->size = 0;
+	}
+}
+
+/**
+ * selpcimac_rx_initialize() - Initialize the receive chain for a MAC.
+ *
+ * @mac: MAC to initialize the receive chain on.
+ *
+ * Returns: 0 if successful, -ENOMEM if there was a memory allocation problem.
+ */
+int selpcimac_rx_initialize(struct sel_pci_mac *mac)
+{
+	/* The SELPCIMAC device isn't a stand alone hardware device so
+	 * DMA resources need to be assigned to its parent.
+	 */
+	mac->rx_ring.dev = mac->current_dev->parent;
+	mac->rx_ring.netdev = mac->netdev;
+	mac->rx_ring.count = mac->num_rx_bds;
+
+	/* The SELPCIMAC driver does not currently support big pages. */
+	BUILD_BUG_ON(PAGE_SIZE > 8192);
+
+	/* Calculate packet truesize. If we fit in half a page, we can
+	 * reuse pages.
+	 */
+	mac->rx_ring.truesize = (RX_SKBFRAG_SIZE < (PAGE_SIZE / 2)) ?
+		(PAGE_SIZE / 2) : PAGE_SIZE;
+
+	if (selpcimac_initialize_rx_ring(&mac->rx_ring))
+		return -ENOMEM;
+
+	iowrite32(lower_32_bits(mac->rx_ring.last_bd),
+		  &mac->hw_mac->receive.rx_bd_last_l);
+	iowrite32(upper_32_bits(mac->rx_ring.last_bd),
+		  &mac->hw_mac->receive.rx_bd_last_h);
+	iowrite32(lower_32_bits(mac->rx_ring.dma),
+		  &mac->hw_mac->receive.rx_bd_first_l);
+	iowrite32(upper_32_bits(mac->rx_ring.dma),
+		  &mac->hw_mac->receive.rx_bd_first_h);
+
+	return 0;
+}
+
+/**
+ * selpcimac_rx_cleanup() - Cleanup all RX resources.
+ *
+ * This function should be called when we bring down a port.
+ *
+ * @mac: MAC device to cleanup.
+ */
+void selpcimac_rx_cleanup(struct sel_pci_mac *mac)
+{
+	selpcimac_cleanup_rx_ring(&mac->rx_ring);
+}
+
+/**
+ * selpcimac_reuse_rx_buffer() - Reuse RX buffer page allocation.
+ *
+ * This transfers ownership of an allocated page from one buffer to another so
+ * it can be reused to save memory resources.
+ *
+ * @ring: RX ring that owns the buffers.
+ * @bi: RX buffer that will relinquish the page.
+ */
+static void selpcimac_reuse_rx_buffer(struct selpcimac_rx_ring *ring,
+				      struct selpcimac_rx_buffer *bi)
+{
+	struct selpcimac_rx_buffer *newbi;
+	u16 nta = ring->next_to_alloc;
+
+	newbi = &ring->buffer_info[nta];
+
+	nta++;
+	ring->next_to_alloc = (nta == ring->count) ? 0 : nta;
+
+	/* transfer ownership to the new rx buffer, and sync */
+	*newbi = *bi;
+	bi->page = NULL;
+	bi->dma = 0;
+	bi->page_offset = 0;
+
+	dma_sync_single_range_for_device(ring->dev,
+					 newbi->dma,
+					 newbi->page_offset,
+					 ring->truesize,
+					 DMA_FROM_DEVICE);
+}
+
+/**
+ * selpcimac_add_rx_frag() - Add a frame fragment to an SKB.
+ *
+ * Adds the data from an RX fragment to an allocated SKB.  If it's the first
+ * fragment, it assumes the packet was built with build_skb and the fragement
+ * is in the SKB data pointer.  If it's not the first it adds it to the
+ * frags list.
+ *
+ * @bi: RX buffer information structure describing the fragment
+ * @skb: Allocated SKB that will receive the data.
+ * @size: Size of the fragment
+ * @first: True if this is the first fragment in the packet.
+ *
+ * Return: True if the fragment can be reused for another RX buffer, false if
+ *     it should not be reused.
+ */
+static bool selpcimac_add_rx_frag(struct selpcimac_rx_ring *ring,
+				  struct selpcimac_rx_buffer *bi,
+				  struct sk_buff *skb,
+				  u32 size,
+				  bool first)
+{
+	/* This is the first fragment and we used build_skb to generate the
+	 * skb, so the data is in the skb data buffer instead of the frags
+	 * list.  We only need to update the skb size
+	 */
+	if (likely(first)) {
+		skb_put(skb, size);
+	} else {
+		/* This is a jumbo frame fragment.  Add it to the frags list */
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				bi->page, bi->page_offset + RX_BUFFER_PAD,
+				size, ring->truesize);
+	}
+
+	/* If truesize is the entire page, then we can't reuse the page */
+	if (ring->truesize == PAGE_SIZE)
+		return false;
+
+	/* Only reuse the page if we are the only owner and if the system
+	 * isn't struggling for memory
+	 */
+	if (unlikely((page_count(bi->page) != 1) || page_is_pfmemalloc(bi->page)))
+		return false;
+
+	/* We are definitely reusing.  Flip to the other half and add a
+	 * reference so the skb deallocator doesn't free the page
+	 */
+	bi->page_offset ^= ring->truesize;
+	page_ref_inc(bi->page);
+
+	return true;
+}
+
+/**
+ * selpcimac_alloc_or_append_skb() - Create an SKB and add a fragment to it.
+ *
+ * If there isn't an SKB already allocated, allocate a new skb and add data to
+ * it.  If the SKB is already allocated, just append data to it.
+ *
+ * @ring: RX ring being processed.
+ * @bi: RX buffer describing the fragment just received.
+ * @size:  Size of the received fragment.
+ * @skb: NULL to allocate a new SKB or a pointer to an SKB that has a
+ *       partial packet from previous fragments.
+ *
+ * @return: Pointer to an allocated SKB containing the fragments.
+ */
+static struct sk_buff *selpcimac_alloc_or_append_skb(struct selpcimac_rx_ring *ring,
+						     struct selpcimac_rx_buffer *bi,
+						     u32 size,
+						     struct sk_buff *skb)
+{
+	bool first = false;
+	void *addr;
+
+	/* This is the first fragment.  Allocate a new skb */
+	if (likely(!skb)) {
+		addr = page_address(bi->page) + bi->page_offset;
+		skb = build_skb(addr, RX_SKBFRAG_SIZE);
+		if (unlikely(!skb))
+			return NULL;
+		skb_reserve(skb, RX_BUFFER_PAD);
+		first = true;
+	}
+
+	dma_sync_single_range_for_cpu(ring->dev,
+				      bi->dma,
+				      bi->page_offset,
+				      ring->truesize,
+				      DMA_FROM_DEVICE);
+
+	/* A true return from selpcimac_add_rx_frag() means that the page can
+	 * be reused.  A false return from selpcimac_add_rx_frag() means the
+	 * page can not be reused, but the addition still worked.
+	 */
+	if (selpcimac_add_rx_frag(ring, bi, skb, size, first)) {
+		selpcimac_reuse_rx_buffer(ring, bi);
+	} else {
+		dma_unmap_page(ring->dev, bi->dma, PAGE_SIZE, DMA_FROM_DEVICE);
+		bi->dma = 0;
+		/* Page has been added to SKB so will be freed when SKB is
+		 * freed.  We can just ignore it and let it realloc.
+		 */
+		bi->page_offset = 0;
+		bi->page = NULL;
+	}
+
+	return skb;
+}
+
+/**
+ * selpcimac_process_frame() - Fill out the SKB with information and handoff
+ *
+ * Fills in information about timestamps and checksum offload and hand up to
+ * the operating system to process.
+ *
+ * @ring: RX Ring being processed.
+ * @desc: Hardware buffer descriptor that is pointing to the last fragment of
+ *        the packet.
+ * @skb:  Built SKB describing the valid packet.
+ */
+static void selpcimac_process_frame(struct selpcimac_rx_ring *ring,
+				    struct sel_rx_bd *desc,
+				    struct sk_buff *skb)
+{
+	struct sel_pci_mac *mac = container_of(ring,
+					       struct sel_pci_mac,
+					       rx_ring);
+	struct skb_shared_hwtstamps *rx_hwtstamp;
+	u32 packet_status;
+	u32 rxbd_ns;
+	u64 rxbd_sec;
+
+	packet_status = le32_to_cpu(desc->rxbd_ctrl);
+	if (mac->rx_csum_enabled) {
+		if ((packet_status & RXBD_CTRL_IPV4_FOUND &&
+		     packet_status & RXBD_CTRL_IPV4_VALID) ||
+		    (packet_status & RXBD_CTRL_UDP_FOUND &&
+		     packet_status & RXBD_CTRL_UDP_VALID) ||
+		    (packet_status & RXBD_CTRL_TCP_FOUND &&
+		     packet_status & RXBD_CTRL_TCP_VALID)) {
+			/* The hardware identified one or more supported
+			 * protocols with valid checksums.
+			 */
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+			if ((packet_status & RXBD_CTRL_UDP_FOUND &&
+			     packet_status & RXBD_CTRL_UDP_VALID) ||
+			    (packet_status & RXBD_CTRL_TCP_FOUND &&
+			     packet_status & RXBD_CTRL_TCP_VALID)) {
+				skb->csum_level = 1;
+			} else {
+				skb->csum_level = 0;
+			}
+		} else {
+			/* The hardware may have identified a supported
+			 * protocol that had an invalid checksum. This
+			 * may be a false finding due to some parts of
+			 * the v6 protocol not being fully supported, so
+			 * make the kernel calculate checksums to avoid
+			 * falsely dropping a packet.
+			 */
+			skb->ip_summed = CHECKSUM_NONE;
+		}
+	}
+
+	if (mac->cap_timestamp) {
+		if (mac->hwtstamp_config.rx_filter == HWTSTAMP_FILTER_ALL) {
+			rx_hwtstamp = skb_hwtstamps(skb);
+
+			rxbd_ns = le32_to_cpu(desc->rxbd_ns);
+			rxbd_sec = le32_to_cpu(desc->rxbd_sec1_len);
+			rxbd_sec &= RXBD_SEC1_LEN_SEC_HI_MASK;
+			rxbd_sec <<= RXBD_SEC1_LEN_SEC_HI_SHIFT;
+			rxbd_sec += le32_to_cpu(desc->rxbd_sec0);
+
+			memset(rx_hwtstamp, 0, sizeof(*rx_hwtstamp));
+			rx_hwtstamp->hwtstamp = ktime_set(rxbd_sec, rxbd_ns);
+		}
+	}
+
+	mac->stats.rx_packets++;
+	mac->stats.rx_bytes += skb->len;
+	skb->protocol = eth_type_trans(skb, ring->netdev);
+	napi_gro_receive(&mac->napi_rx, skb);
+}
+
+/**
+ * selpcimac_clean_rx_buffer() - Handle a received packet fragment.
+ *
+ * This function will examine the indicated fragment for valid data.
+ * If the data is valid, it will process it and indicate the packet to
+ * the operating system.  If it is invalid, it will drop the fragment
+ * and do nothing.
+ *
+ * Multiple fragments may be needed to indicated a received frame.  The
+ * currently accepted fragments are stored in an SKB in the ring
+ * structure that must be maintained between calls to this function.  The
+ * skb will only be given to Linux when it is complete.
+ *
+ * If the function handles a fragment in any way, even if it was a bad
+ * fragment, it should return true.  This indicates to the caller that
+ * something was processed and it should move to the next fragment.  False
+ * should only be returned if nothing was done.
+ *
+ * @ring: Ring being processed.
+ * @bi:   RX buffer information about the current fragment.
+ * @desc: RXBD for the current fragment.
+ *
+ * Returns: True if it processed a fragment, false if the fragment is not
+ *     ready to be processed
+ */
+static bool selpcimac_clean_rx_buffer(struct selpcimac_rx_ring *ring,
+				      struct selpcimac_rx_buffer *bi,
+				      struct sel_rx_bd *desc)
+{
+	struct sel_pci_mac *mac = container_of(ring,
+					       struct sel_pci_mac,
+					       rx_ring);
+	u32 size = le32_to_cpu(desc->rxbd_sec1_len);
+	u32 ctrl = le32_to_cpu(desc->rxbd_ctrl);
+
+	size &= RXBD_SEC1_LEN_LEN_MASK;
+	size >>= RXBD_SEC1_LEN_LEN_SHIFT;
+
+	/* No new packets in hardware */
+	if (ctrl & RXBD_CTRL_EMT)
+		return false;
+
+	/* LOST_OTHERS indicates that the HW dropped a packet before
+	 * receiving this one.  It does not indicate a problem with
+	 * this frame.
+	 */
+	if ((ctrl & RXBD_CTRL_LOST_OTHERS) != 0)
+		mac->stats.rx_dropped++;
+
+	/* Lost a fragment in a packet somehow. Cleanup and keep going
+	 * because this fragment is probably ok.
+	 */
+	if (ring->skb && ((ctrl & RXBD_CTRL_FRAG) == 0)) {
+		mac->stats.rx_dropped++;
+		dev_kfree_skb(ring->skb);
+		ring->skb = NULL;
+	}
+
+	/* Valid buffer, create or add it to an skb */
+	ring->skb = selpcimac_alloc_or_append_skb(ring, bi, size, ring->skb);
+	if (unlikely(!ring->skb)) {
+		/* There was no memory to allocate an skb.  Return false and
+		 * hope there is by the next time we come around to service.
+		 */
+		return false;
+	}
+
+	/* The hardware is telling us there is an error with the packet
+	 * being received. Discard the working packet and continue
+	 * processing buffers. This must be done after we have handled
+	 * taking data out of the ring and allocating new memory buffers.
+	 */
+	if ((ctrl & RXBD_CTRL_ERR) != 0) {
+		mac->stats.rx_errors++;
+		mac->stats.rx_dropped++;
+		dev_kfree_skb(ring->skb);
+		ring->skb = NULL;
+		return true;
+	}
+
+	/* Nothing more to do if this is not the last fragment */
+	if ((ctrl & RXBD_CTRL_LST) == 0)
+		return true;
+
+	/* Definitely a good packet, process it and hand it up */
+	selpcimac_process_frame(ring, desc, ring->skb);
+	ring->skb = NULL;
+
+	return true;
+}
+
+/**
+ * selpcimac_rx_clean() - Packet reception handler.
+ *
+ * This function should be called by the NAPI process to handle packets
+ * that have been received by the MAC.  It should process packets up to
+ * the specified number of packets in work_limit and then return.
+ *
+ * Packet cleaning starts at the next_to_use index of the ring.  Packets
+ * that have been processed need to be cleaned which is done at regular
+ * packet intervals or at the end of the process.
+ *
+ * @mac:  MAC with the packets to be processed.
+ * @work_limit: Number of packet fragments to process.
+ *
+ * Returns: Number of packet fragments actually processed.
+ */
+int selpcimac_rx_clean(struct sel_pci_mac *mac, int work_limit)
+{
+	u16 to_clean = selpcimac_desc_to_clean(&mac->rx_ring);
+	struct selpcimac_rx_ring *ring = &mac->rx_ring;
+	struct selpcimac_rx_buffer *bi;
+	u16 ntu = ring->next_to_use;
+	struct sel_rx_bd *desc;
+	u16 handled = 0;
+
+	bi = &ring->buffer_info[ntu];
+	desc = &ring->desc[ntu];
+
+	/* Insert a memory barrier to ensure everything is in RAM before
+	 * we read the memory used by hardware.
+	 */
+	rmb();
+
+	while (work_limit--) {
+		/* Reallocate early to prevent running out */
+		if (to_clean > 16) {
+			selpcimac_clean_rx_ring(ring);
+			to_clean = 0;
+		}
+
+		if (!selpcimac_clean_rx_buffer(ring, bi, desc)) {
+			/* All packets handled */
+			break;
+		}
+		++handled;
+		++to_clean;
+		++ntu;
+		++bi;
+		++desc;
+		if (unlikely(ntu == ring->count)) {
+			ntu = 0;
+			bi = ring->buffer_info;
+			desc = ring->desc;
+		}
+		ring->next_to_use = ntu;
+	}
+
+	selpcimac_clean_rx_ring(ring);
+	/* Poke RHLT just in case we filled up */
+	sel_read_mod_write(&mac->hw_mac->receive.rstat, RSTAT_RHLT, 0);
+
+	return handled;
+}
diff --git a/drivers/net/ethernet/sel/netdev_rx.h b/drivers/net/ethernet/sel/netdev_rx.h
new file mode 100644
index 000000000000..5247095315d8
--- /dev/null
+++ b/drivers/net/ethernet/sel/netdev_rx.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef NETDEV_RX_H_INCLUDED
+#define NETDEV_RX_H_INCLUDED
+
+#include "pci_mac.h"
+
+int selpcimac_rx_initialize(struct sel_pci_mac *mac);
+void selpcimac_rx_cleanup(struct sel_pci_mac *mac);
+int selpcimac_rx_clean(struct sel_pci_mac *mac, int work_limit);
+
+#endif /* NETDEV_RX_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/netdev_tx.c b/drivers/net/ethernet/sel/netdev_tx.c
new file mode 100644
index 000000000000..784ad905625d
--- /dev/null
+++ b/drivers/net/ethernet/sel/netdev_tx.c
@@ -0,0 +1,647 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/ktime.h>
+#include <linux/io.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/rtnetlink.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "hw_interface.h"
+#include "netdev_tx.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+
+static void handle_tx_timestamp(struct sel_tx_bd_wrapper *tx)
+{
+	struct skb_shared_hwtstamps tx_hwtstamp;
+	u64 txbd_sec;
+	u32 txbd_ns;
+
+	if (skb_shinfo(tx->skbuf)->tx_flags & SKBTX_IN_PROGRESS) {
+		txbd_ns = le32_to_cpu(tx->bd->txbd_ns);
+		txbd_ns &= TXBD_NS_NS_MASK;
+		txbd_sec = le32_to_cpu(tx->bd->txbd_sec1_len);
+		txbd_sec &= TXBD_SEC1_LEN_SEC_HI_MASK;
+		txbd_sec <<= TXBD_SEC1_LEN_SEC_HI_SHIFT;
+		txbd_sec += le32_to_cpu(tx->bd->txbd_sec0);
+
+		memset(&tx_hwtstamp, 0, sizeof(tx_hwtstamp));
+		tx_hwtstamp.hwtstamp = ktime_set(txbd_sec, txbd_ns);
+
+		skb_tstamp_tx(tx->skbuf, &tx_hwtstamp);
+	}
+}
+
+/**
+ * sel_unmap_tx_buffer() - unmap a tx_bd_wrapper from DMA.
+ *
+ * Ensures the correct unmap function gets called based on information
+ * from the wrapper
+ *
+ * @mac: Private data for this mac
+ * @txbd: Wrapper to be unmapped
+ */
+static void sel_unmap_tx_buffer(struct sel_pci_mac *mac,
+				struct sel_tx_bd_wrapper *txbd)
+{
+	/* already unmapped */
+	if (txbd->dma == 0)
+		return;
+
+	if (txbd->unmap) {
+		/* The head is in the skb so was allocated with
+		 * dma_map_single. Fragments are mapped with the page
+		 * equivalent.
+		 */
+		if (txbd->frag) {
+			dma_unmap_page(mac->current_dev->parent,
+				       txbd->dma,
+				       txbd->dma_len,
+				       DMA_TO_DEVICE);
+		} else {
+			dma_unmap_single(mac->current_dev->parent,
+					 txbd->dma,
+					 txbd->dma_len,
+					 DMA_TO_DEVICE);
+		}
+	}
+	txbd->dma = 0;
+	txbd->dma_offset = 0;
+	txbd->dma_len = 0;
+}
+
+/**
+ * sel_tx_clean() - Process all packets that have been sent by the hardware
+ *
+ * @mac: Net device context
+ *
+ * This function frees any data buffers allocated for a completed TXBD,
+ * and frees the associated skb. This function can only run in
+ * soft irq context.
+ *
+ * Return: number of TX packets processed
+ */
+int sel_tx_clean(struct sel_pci_mac *mac)
+{
+	struct sel_tx_bd_wrapper *dty_tx;
+	u32 tx_cleaned = 0;
+	u32 ctrl;
+
+	/* If someone is already cleaning, bail */
+	if (test_and_set_bit(SYNC_FLAGS_TX_BD_CLEANING, &mac->sync_flags))
+		return NETDEV_TX_OK;
+
+	while (mac->tx_bd_avail != mac->num_tx_bds) {
+		dty_tx = mac->dty_tx;
+
+		ctrl = le32_to_cpu(dty_tx->bd->txbd_ctrl);
+		if ((ctrl & TXBD_CTRL_RDY) != 0)
+			break;
+
+		sel_unmap_tx_buffer(mac, dty_tx);
+
+		/* The packet status information is only valid on the
+		 * last fragment. Other fragments just get returned.
+		 */
+		if ((ctrl & TXBD_CTRL_LST) != 0) {
+			if ((ctrl & TXBD_CTRL_ERR) != 0) {
+				mac->stats.tx_errors++;
+				mac->stats.tx_dropped++;
+			}
+
+			if (mac->cap_timestamp)
+				handle_tx_timestamp(dty_tx);
+
+			mac->stats.tx_packets++;
+			mac->stats.tx_bytes += dty_tx->skbuf->len;
+
+			dev_kfree_skb_any(dty_tx->skbuf);
+			dty_tx->skbuf = NULL;
+		}
+
+		++tx_cleaned;
+		mac->dty_tx = dty_tx->next;
+
+		spin_lock(&mac->tx_lock);
+		mac->tx_bd_avail++;
+		spin_unlock(&mac->tx_lock);
+	}
+
+	/* Recover from running out of Tx resources in xmit_frame
+	 * by starting the queue of transmit packets if it was stopped
+	 * and we have TXBDs available
+	 */
+	if (unlikely(tx_cleaned > 0 && netif_queue_stopped(mac->netdev)))
+		netif_wake_queue(mac->netdev);
+
+	clear_bit(SYNC_FLAGS_TX_BD_CLEANING, &mac->sync_flags);
+
+	return tx_cleaned;
+}
+
+/**
+ * sel_tx_timeout() - Called when the net device interface senses a
+ * timeout in packet transmission
+ *
+ * @netdev: Net device object
+ *
+ * Remark: This function runs in the interrupt context
+ */
+void sel_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+
+	/* Reset the device outside of interrupt context since bringing
+	 * the device up or down involves allocated memory
+	 */
+	schedule_work(&mac->reset_task);
+}
+
+/**
+ * send_frame_setup_checksum() - Send the frame setup checksum
+ *
+ * @mac: Private data for this mac
+ * @last: Last buffer descriptor in the ring
+ */
+static void send_frame_setup_checksum(struct sel_pci_mac *mac,
+				      struct sel_tx_bd_wrapper *last)
+{
+	u32 header_offset;
+	u32 csum_offset;
+	u32 reg;
+
+	/* csum enables are in the NS field */
+	last->bd->txbd_ns = cpu_to_le32(0);
+
+	/* Hardware is not capable */
+	if (!mac->cap_csum_offload)
+		return;
+
+	/* Stack didn't request a checksum */
+	if (last->skbuf->ip_summed != CHECKSUM_PARTIAL)
+		return;
+
+	switch (last->skbuf->protocol) {
+	/* sk_buff protocol member is in big endian notation */
+	case cpu_to_be16(ETH_P_IP):
+		switch (ip_hdr(last->skbuf)->protocol) {
+		/* Note: csum enable bits for UDP and TCP are
+		 * located at the most significant bits
+		 * of the  TXBD nanosecond timestamp register.
+		 */
+		case IPPROTO_TCP:
+			last->bd->txbd_ns |=
+				cpu_to_le32(TXBD_NS_CSUM_TCP_EN);
+			break;
+		case IPPROTO_UDP:
+			last->bd->txbd_ns |=
+				cpu_to_le32(TXBD_NS_CSUM_UDP_EN);
+			break;
+		}
+		break;
+	case cpu_to_be16(ETH_P_IPV6):
+		switch (ipv6_hdr(last->skbuf)->nexthdr) {
+		case IPPROTO_TCP:
+			last->bd->txbd_ns |=
+				cpu_to_le32(TXBD_NS_CSUM_TCP_EN);
+			break;
+		case IPPROTO_UDP:
+			last->bd->txbd_ns |=
+				cpu_to_le32(TXBD_NS_CSUM_UDP_EN);
+			break;
+		}
+		break;
+	}
+
+	reg = le32_to_cpu(last->bd->txbd_csum);
+
+	reg &= ~(TXBD_CSUM_HEADER_OFFSET_MASK);
+	header_offset = (u8)skb_checksum_start_offset(last->skbuf);
+	header_offset <<= TXBD_CSUM_HEADER_OFFSET_SHIFT;
+	reg |= TXBD_CSUM_HEADER_OFFSET_MASK & header_offset;
+
+	reg &= ~(TXBD_CSUM_CSUM_OFFSET_MASK);
+	csum_offset = (u32)((u8)skb_checksum_start_offset(last->skbuf) +
+			    (u8)last->skbuf->csum_offset);
+	csum_offset <<= TXBD_CSUM_CSUM_OFFSET_SHIFT;
+	reg |= TXBD_CSUM_CSUM_OFFSET_MASK & csum_offset;
+
+	last->bd->txbd_csum = cpu_to_le32(reg);
+}
+
+/**
+ * send_frame_setup_timestamp() - Sends the frame setup timestamp
+ *
+ * @mac: Private data for this mac
+ * @last: Last buffer descriptor in the ring
+ */
+static void send_frame_setup_timestamp(struct sel_pci_mac *mac,
+				       struct sel_tx_bd_wrapper *last)
+{
+	if (mac->cap_timestamp &&
+	    mac->hwtstamp_config.tx_type == HWTSTAMP_TX_ON) {
+		if (unlikely(skb_shinfo(last->skbuf)->tx_flags & SKBTX_HW_TSTAMP))
+			skb_shinfo(last->skbuf)->tx_flags |= SKBTX_IN_PROGRESS;
+		else
+			skb_tx_timestamp(last->skbuf);
+	}
+}
+
+/**
+ * sel_send_frame() - Sends the frame
+ *
+ * @mac: Private data for this mac
+ * @last: Last buffer descriptor in the frame
+ */
+static void sel_send_frame(struct sel_pci_mac *mac,
+			   struct sel_tx_bd_wrapper *last)
+{
+	dma_addr_t addr;
+	u32 ctrl;
+
+	for (; mac->cur_tx != last->next; mac->cur_tx = mac->cur_tx->next) {
+		addr = mac->cur_tx->dma + mac->cur_tx->dma_offset;
+		mac->cur_tx->bd->txbd_addr0 = cpu_to_le32(lower_32_bits(addr));
+		mac->cur_tx->bd->txbd_addr1 = cpu_to_le32(upper_32_bits(addr));
+		mac->cur_tx->bd->txbd_sec1_len =
+				cpu_to_le32(mac->cur_tx->len << RXBD_SEC1_LEN_LEN_SHIFT);
+
+		ctrl = mac->cur_tx->index;
+		ctrl |= TXBD_CTRL_RDY;
+		ctrl &= ~TXBD_CTRL_ERR;
+
+		/* only the last bd needs extra stuff */
+		if (mac->cur_tx->last) {
+			ctrl |= TXBD_CTRL_LST;
+			send_frame_setup_checksum(mac, last);
+			send_frame_setup_timestamp(mac, last);
+		}
+
+		/* After writing the RDY bit to th RAM we are not allowed
+		 * to modify the BD in anyway until the HW clears the bit,
+		 * or we disable the transmitter. These two operations need
+		 * to be protected with a bottom half lock to ensure we don't
+		 * mess up synchronization in the cleanup queue.
+		 */
+		spin_lock_bh(&mac->tx_lock);
+		mac->cur_tx->bd->txbd_ctrl = cpu_to_le32(ctrl);
+		mac->tx_bd_avail--;
+		spin_unlock_bh(&mac->tx_lock);
+	}
+}
+
+/**
+ * sel_fill_txbds() - Breaks a buffer into hardware sized fragments and fills
+ *      out the appropriate number of txbds.
+ *
+ * The kernel can sometimes hand us fragments that are too big for hardware.
+ * This function breaks it into multiple fragments.
+ *
+ * @tofill: TXBD wrapper to fill next
+ * @skb: SKB being sent
+ * @addr: DMA mapped address of the start of the fragment to send
+ * @total_len: Total size of the DMA mapping.
+ * @max_len: Maximum fragment size hardware can handle
+ * @frag: True if this was mapped as a DMA page fragment or fals if it was
+ *        a non-page map.
+ *
+ * Returns: A pointer to the next TXBD that should be filled.
+ */
+static struct sel_tx_bd_wrapper *sel_fill_txbds(struct sel_tx_bd_wrapper *tofill,
+						struct sk_buff *skb,
+						dma_addr_t addr,
+						int total_len,
+						int max_len,
+						int frag)
+{
+	struct sel_tx_bd_wrapper *last;
+	int len = total_len;
+	int offset = 0;
+	int frag_len;
+
+	/* nothing to do */
+	if (len == 0)
+		return tofill;
+
+	while (len) {
+		last = tofill;
+		frag_len = (len < max_len) ? len : max_len;
+
+		tofill->unmap = false;
+		tofill->last = false;
+		tofill->frag = frag;
+		tofill->skbuf = skb;
+		tofill->len = frag_len;
+		tofill->dma = addr;
+		tofill->dma_offset = offset;
+		tofill->dma_len = total_len;
+
+		len -= frag_len;
+		offset += frag_len;
+		tofill = tofill->next;
+	}
+
+	last->unmap = true;
+	return tofill;
+}
+
+/**
+ * sel_map_xmit_frame() - Maps the transmit frame
+ *
+ * @mac: Private data for this mac
+ * @skb: Socket buffer
+ *
+ * Return: The filled out buffer descriptor
+ */
+static struct sel_tx_bd_wrapper *sel_map_xmit_frame(struct sel_pci_mac *mac,
+						    struct sk_buff *skb)
+{
+	struct sel_tx_bd_wrapper *tofill = mac->cur_tx;
+	struct sel_tx_bd_wrapper *start = mac->cur_tx;
+	dma_addr_t dma;
+	int len;
+	int i;
+
+	/* skbs may or may not have some data on the head */
+	if (skb_headlen(skb)) {
+		dma = dma_map_single(mac->current_dev->parent,
+				     skb->data,
+				     skb_headlen(skb),
+				     DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(mac->current_dev->parent, dma)))
+			goto err_exit;
+		tofill = sel_fill_txbds(tofill, skb, dma, skb_headlen(skb),
+					mac->max_buffer_sz, false);
+	}
+
+	/* If there are fragments, then add the additional data, making
+	 * sure to update the last flag on the previous fragment we filled
+	 * out so we know where the real last is
+	 */
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; ++i) {
+		len = skb_frag_size(&skb_shinfo(skb)->frags[i]);
+		dma = skb_frag_dma_map(mac->current_dev->parent,
+				       &skb_shinfo(skb)->frags[i],
+				       0,
+				       len,
+				       DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(mac->current_dev->parent, dma)))
+			goto err_unmap_exit;
+		tofill = sel_fill_txbds(tofill, skb, dma, len,
+					mac->max_buffer_sz, true);
+	}
+
+	while (start->next != tofill)
+		start = start->next;
+	start->last = true;
+	return start;
+
+err_unmap_exit:
+	while (start != tofill) {
+		sel_unmap_tx_buffer(mac, start);
+		start = start->next;
+	}
+
+err_exit:
+	return NULL;
+}
+
+/**
+ * sel_count_txbd_needed() - Counts the number of TXBDs needed to send a frame
+ *
+ * This function takes into account the maximum size the hardware can handle
+ * for later fragmentation of the SKB.
+ *
+ * @skb: The SKB being transmitted.
+ * @max_bd_size: The maximum size of fragment the hardware can accept.
+ *
+ * Return: Count of TXBDs needed to send the packet.
+ */
+static int sel_count_txbd_needed(struct sk_buff *skb, int max_bd_size)
+{
+	int count = 0;
+	int len;
+	int i;
+
+	len = skb_headlen(skb);
+	if (len) {
+		count += (len / max_bd_size);
+		count += (len % max_bd_size) ? 1 : 0;
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; ++i) {
+		len = skb_frag_size(&skb_shinfo(skb)->frags[i]);
+		count += (len / max_bd_size);
+		count += (len % max_bd_size) ? 1 : 0;
+	}
+
+	return count;
+}
+
+/**
+ * sel_xmit_frame() - Transmit a packet
+ *
+ * @skb: The packet to be transmitted
+ * @netdev: The net device object
+ *
+ * If scatter/gather is supported, the first frag is stored in skb->data,
+ * with length skb_headlen(skb). The remaining frags have a total size of
+ * skb->len - skb_headlen(skb), and are retrieved using
+ * skb_shinfo(skb)->frags[n] and skb_shinfo(skb)->nr_frags. This function
+ * can not be called higher than soft irq context. The kernel calls this
+ * function from process level context.
+ *
+ * Return: NETDEV_TX_OK if transmit succeeded, NETDEV_TX_BUSY otherwise
+ */
+netdev_tx_t sel_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct sel_pci_mac *mac = netdev_priv(netdev);
+	struct sel_tx_bd_wrapper *last_tx = NULL;
+	netdev_tx_t retval = NETDEV_TX_OK;
+	int txbd_needed;
+
+	if (unlikely(skb->len <= 0)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* limitations in the hardware prevent packet sizes less than 5 bytes.
+	 * We also want to make sure we don't exceed the fifo size.
+	 */
+	if (unlikely(skb->len < 5)) {
+		mac->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Make sure we have enough buffer descriptors for a packet before
+	 * we give it to hardware.  Make sure to always leave at least one
+	 * buffer descriptor unused so the hardware cannot catch up to itself
+	 */
+	txbd_needed = sel_count_txbd_needed(skb, mac->max_buffer_sz);
+	if (unlikely(mac->tx_bd_avail <= txbd_needed)) {
+		netif_stop_queue(netdev);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* If we can't map memory, just drop the packet */
+	last_tx = sel_map_xmit_frame(mac, skb);
+	if (!last_tx) {
+		mac->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	sel_send_frame(mac, last_tx);
+
+	mac->cur_tx = last_tx->next;
+
+	/* Clear the THLT bit to start a transmission by writing a 1. */
+	sel_read_mod_write(&mac->hw_mac->transmit.tstat, TSTAT_THLT, 0);
+
+	/* If we are running out of space, stop the TX queue */
+	if (unlikely(mac->tx_bd_avail == 0))
+		netif_stop_queue(netdev);
+
+	return retval;
+}
+
+/**
+ * sel_free_transmit_memory() - Free the memory associated with the
+ * transmit path.
+ *
+ * @mac: net device context
+ *
+ * This function must not be called from an atomic context.
+ */
+void sel_free_transmit_memory(struct sel_pci_mac *mac)
+{
+	struct sel_tx_bd_wrapper *tx;
+
+	/* Packets may have already been sent to hardware.
+	 * Unmap those packets and free the respective
+	 * skb memory
+	 */
+	while (mac->tx_bd_avail != mac->num_tx_bds) {
+		tx = mac->dty_tx;
+
+		sel_unmap_tx_buffer(mac, tx);
+
+		/* The tx_wrapper containing the last buffer in a
+		 * frame contains the skb ptr to be freed
+		 */
+		if (tx->skbuf) {
+			if (tx->last)
+				dev_kfree_skb_any(tx->skbuf);
+			tx->skbuf = NULL;
+		}
+
+		mac->dty_tx = tx->next;
+		mac->tx_bd_avail++;
+	}
+
+	if (mac->first_tx_bd_dma_addr != 0) {
+		dma_free_coherent(mac->current_dev->parent,
+				  mac->tx_bd_buffer_size,
+				  mac->first_tx_bd,
+				  mac->first_tx_bd_dma_addr);
+
+		mac->first_tx_bd_dma_addr = 0;
+		mac->first_tx_bd = 0;
+	}
+
+	kfree(mac->base_tx);
+	mac->base_tx = NULL;
+
+	mac->cur_tx = NULL;
+	mac->dty_tx = NULL;
+	mac->tx_bd_avail = 0;
+}
+
+/**
+ * sel_alloc_transmit_memory() - Allocate the memory associated with the
+ * transmit path
+ *
+ * @mac: the net device context
+ *
+ * The caller needs to eventually call sel_free_transmit_memory in order
+ * to free memory allocated in this function.
+ *
+ * Return: 0 if successful, otherwise an appropriate negative error code
+ */
+int sel_alloc_transmit_memory(struct sel_pci_mac *mac)
+{
+	dma_addr_t last;
+	u16 i;
+
+	/* Round up to the nearest 4k to align with memory pages */
+	mac->tx_bd_buffer_size = sizeof(struct sel_tx_bd) * mac->num_tx_bds;
+	mac->tx_bd_buffer_size = ALIGN(mac->tx_bd_buffer_size, 4096);
+	mac->first_tx_bd = dma_alloc_coherent(mac->current_dev->parent,
+					      mac->tx_bd_buffer_size,
+					      &mac->first_tx_bd_dma_addr,
+					      GFP_KERNEL | __GFP_ZERO);
+	if (!mac->first_tx_bd)
+		return -ENOMEM;
+
+	mac->base_tx = kcalloc(mac->num_tx_bds, sizeof(struct sel_tx_bd_wrapper),
+			       GFP_KERNEL);
+	if (!mac->base_tx)
+		goto err_free_bd_ring;
+
+	for (i = 0; i < mac->num_tx_bds; i++) {
+		/* The ID field must be set to the descriptor index so
+		 * that lost packet detection works correctly
+		 */
+		mac->first_tx_bd[i].txbd_ctrl =
+			cpu_to_le32(i & TXBD_CTRL_ID_MASK);
+
+		mac->base_tx[i].index = i;
+		mac->base_tx[i].bd = &mac->first_tx_bd[i];
+		mac->base_tx[i].next = &mac->base_tx[i + 1];
+		if ((i + 1) >= mac->num_tx_bds)
+			mac->base_tx[i].next = &mac->base_tx[0];
+	}
+
+	/* Initialize the txbd wrapper ptrs
+	 * cur_tx is the currently available txbd wrapper
+	 * dty_tx is the txbd wrapper containing the oldest packet sent
+	 * and not marked as sent yet.
+	 */
+	mac->cur_tx = mac->base_tx;
+	mac->dty_tx = mac->base_tx;
+
+	mac->tx_bd_avail = mac->num_tx_bds;
+
+	last = mac->first_tx_bd_dma_addr +
+		((mac->num_tx_bds - 1) * sizeof(struct sel_tx_bd));
+	iowrite32(lower_32_bits(last), &mac->hw_mac->transmit.tx_bd_last_l);
+	iowrite32(upper_32_bits(last), &mac->hw_mac->transmit.tx_bd_last_h);
+	iowrite32(lower_32_bits(mac->first_tx_bd_dma_addr),
+		  &mac->hw_mac->transmit.tx_bd_first_l);
+	iowrite32(upper_32_bits(mac->first_tx_bd_dma_addr),
+		  &mac->hw_mac->transmit.tx_bd_first_h);
+
+	return 0;
+
+err_free_bd_ring:
+	dma_free_coherent(mac->current_dev->parent,
+			  mac->tx_bd_buffer_size,
+			  mac->first_tx_bd,
+			  mac->first_tx_bd_dma_addr);
+
+	return -ENOMEM;
+}
diff --git a/drivers/net/ethernet/sel/netdev_tx.h b/drivers/net/ethernet/sel/netdev_tx.h
new file mode 100644
index 000000000000..0ca232ad0f43
--- /dev/null
+++ b/drivers/net/ethernet/sel/netdev_tx.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef NETDEV_TX_H_INCLUDED
+#define NETDEV_TX_H_INCLUDED
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+
+#include "pci_mac.h"
+
+int sel_tx_clean(struct sel_pci_mac *mac);
+void sel_tx_timeout(struct net_device *netdev, unsigned int txqueue);
+netdev_tx_t sel_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
+void sel_free_transmit_memory(struct sel_pci_mac *mac);
+int sel_alloc_transmit_memory(struct sel_pci_mac *mac);
+
+#endif /* NETDEV_TX_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/pci_mac.h b/drivers/net/ethernet/sel/pci_mac.h
new file mode 100644
index 000000000000..6dac5c82185b
--- /dev/null
+++ b/drivers/net/ethernet/sel/pci_mac.h
@@ -0,0 +1,290 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef _PCI_MAC_H_
+#define _PCI_MAC_H_
+
+#include <linux/bitops.h>
+#include <linux/if_vlan.h>
+#include <linux/mii.h>
+#include <linux/netdevice.h>
+#include <linux/net_tstamp.h>
+
+#define SEL_MAX_JUMBO_FRAME_SIZE 9216
+
+/* Required alignment for rx base and tx base */
+#define SEL_DATA_ALIGN 16U
+
+/* Number of packets required to be processed in order stay in polling mode */
+#define SEL_NAPI_WEIGHT 64U
+
+/* default number of rx and tx bds */
+#define SEL_NUM_RX_BDS 2048U
+#define SEL_NUM_TX_BDS 2048U
+
+/* minimum number of rx and tx bds */
+#define SEL_MIN_NUM_RX_BDS 1024U
+#define SEL_MIN_NUM_TX_BDS 1024U
+
+/* max number of rx and tx bds */
+#define SEL_MAX_NUM_RX_BDS 4096U
+#define SEL_MAX_NUM_TX_BDS 4096U
+
+/* Time window, in seconds, in which transmit packets must be sent by
+ * hardware before a reset is triggered
+ */
+#define SEL_TX_TIMEOUT     (3 * HZ)
+#define SEL_WATCHDOG_SEC   (2 * HZ)
+
+/* max size of the data buffer in each txbd */
+#define SEL_MAX_BYTES_PER_TXBD  2048U
+
+/* Size of Receive Buffer */
+#define SEL_RX_BUFF_LEN (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
+
+/* Sync Bits Definitions */
+#define SYNC_FLAGS_TX_BD_CLEANING		0
+
+/* Phy Link errata wait period. 5 seconds.*/
+#define PHYLINK_RETRY_PERIOD			(5 * (HZ))
+
+/**
+ * sfp_types - types of supported sfp's
+ *
+ * The type field in the eeprom specifies how to configure the phy for a given
+ * sfp. We also use these when bypassing an sfp configuration and setting it
+ * to what the user tells us.
+ */
+enum sfp_types {
+	E1000_SERDES	= 4,
+	E100_SERDES	= 5,
+	E100_SGMII	= 6,
+	E1000_SGMII	= 7,
+};
+
+/* Enum for SFP configuration settings */
+enum sfp_configurations {
+	SFP_AUTO,
+	SFP_BYPASS_100_SERDES,
+	SFP_BYPASS_1000_SERDES,
+	SFP_BYPASS_100_SGMII,
+	SFP_BYPASS_1000_SGMII
+};
+
+/* Enum for interrupt moderation rate settints */
+enum INTR_MOD_RATE {
+	INTR_MOD_LOW,
+	INTR_MOD_MED,
+	INTR_MOD_HIGH
+};
+
+/* Name the shared resources that need arbitration */
+enum ARB_RESOURCE {
+	SMI,
+	I2C,
+	ARB_REQ_2,
+	ARB_REQ_3
+};
+
+/**
+ * struct sel_tx_bd_wrapper - Wrapper for transmit buffer descriptors
+ *
+ * This is used to link TXBDs together, and associate an sk_buff with each bd
+ */
+struct sel_tx_bd_wrapper {
+	/* The buffer descriptor we are wrapping */
+	struct sel_tx_bd *bd;
+
+	/* Next bd in list */
+	struct sel_tx_bd_wrapper *next;
+
+	/* skb buffer for this descriptor */
+	struct sk_buff *skbuf;
+
+	dma_addr_t dma; /* Mapped DMA address */
+	int dma_offset; /* Offset into the mapping of start of data */
+	int dma_len;    /* True length of DMA mapping */
+	int len;        /* Length of fragment */
+	bool frag;      /* True if allocated as a skb fragment */
+	bool unmap;     /* True if this is the last fragment in the mapping */
+
+	/* bd index for lost packet detection */
+	u16 index;
+
+	/* last fragment in a packet */
+	bool last;
+};
+
+/* struct selpcimac_platform_private - private platform data*/
+struct selpcimac_platform_private {
+	void __iomem *address;
+	void *priv;
+};
+
+struct selpcimac_rx_buffer {
+	dma_addr_t dma;
+	struct page *page;
+	__u32 page_offset;
+};
+
+struct selpcimac_rx_ring {
+	struct device *dev;     /* Device to allocate the DMA to */
+	unsigned int size;      /* length of dma allocation in bytes */
+	dma_addr_t dma;         /* physical address of the ring */
+	dma_addr_t last_bd;     /* physical address of the last BD in ring */
+	unsigned int truesize;  /* Actual size of the packet buffer. */
+
+	unsigned int count;     /* Number of BDs in the ring */
+	struct sel_rx_bd *desc; /* virtual address of the ring in BD structs */
+	u16 next_to_use;        /* Next BD index to be used for data */
+	u16 next_to_clean;      /* Next BD index to be cleaned for reuse */
+	u16 next_to_alloc;      /* Next BD index to allocate a page for */
+
+	/* Information about buffer allocations */
+	struct selpcimac_rx_buffer *buffer_info;
+
+	/* Allocated skbuff we are holding until all fragments are received */
+	struct sk_buff *skb;
+
+	struct net_device *netdev;
+};
+
+/**
+ * struct sel_pci_mac - Net Device Context Area
+ */
+struct sel_pci_mac {
+	/* Capabilities */
+	bool cap_legacy;
+	bool cap_csum_offload;
+	bool cap_timestamp;
+	bool cap_jumbo_frame;
+
+	u8 major;
+	u8 minor;
+
+	/* the port number of this device */
+	int port_num;
+
+	/* the mii address of the phy for this mac */
+	int phy_address;
+
+	int max_buffer_sz;
+
+	/* ptr to this MAC's mapped memory */
+	struct sel_pci_mac_registers __iomem *hw_mac;
+
+	/* IRQs for this mac */
+	int transmit_irq;
+	int receive_irq;
+	int misc_irq;
+
+	/* parent device object */
+	struct device *current_dev;
+
+	/* net device stats */
+	struct net_device_stats stats;
+
+	/* net device object for this MAC */
+	struct net_device *netdev;
+
+	/* NAPI interface object for receive */
+	struct napi_struct napi_rx;
+
+	/* NAPI interface object for transmit */
+	struct napi_struct napi_tx;
+
+	/* Configuration for hw timestamps */
+	struct hwtstamp_config hwtstamp_config;
+
+	/* lock used to serialize SFP management registers */
+	spinlock_t sfp_lock;
+
+	/* lock to protect transmit memory */
+	spinlock_t tx_lock;
+
+	/* total number of TXBDs */
+	u32 num_tx_bds;
+
+	/* total number of RXBDs */
+	u32 num_rx_bds;
+
+	/* work item for unresponsive transmits */
+	struct work_struct reset_task;
+
+	/* work item for handling SFP events */
+	struct work_struct sfp_task;
+
+	/* work item for Phy Link errata */
+	struct delayed_work phylink_task;
+
+	/* RX checksum enable */
+	bool rx_csum_enabled;
+
+	/* number of TXBDs available */
+	u32 tx_bd_avail;
+
+	/* pool of TXBDs */
+	struct pci_pool *tx_bd_pool;
+
+	/* size of TXBD ring */
+	u32 tx_bd_buffer_size;
+
+	/* address of the first tx bd */
+	dma_addr_t first_tx_bd_dma_addr;
+
+	/* address of the last tx bd */
+	dma_addr_t last_tx_bd_dma_addr;
+
+	/* first kernel mem address for TXBDs */
+	struct sel_tx_bd *first_tx_bd;
+
+	/* base address of TXBD wrappers */
+	struct sel_tx_bd_wrapper *base_tx;
+
+	/* Wrapper for current bd to use */
+	struct sel_tx_bd_wrapper *cur_tx;
+
+	/* Wrapper for dirty bd (oldest unprocessed TXBD that was sent) */
+	struct sel_tx_bd_wrapper *dty_tx;
+
+	/* RX Ring state */
+	struct selpcimac_rx_ring rx_ring;
+
+	/* related to netif messaging for this net device */
+	u32 msg_enable;
+
+	/* pointer to the generic phy structure */
+	struct sel_generic_phy *generic_phy;
+
+	/* the MII interface associated with this net device */
+	struct mii_if_info mii_if;
+
+	/* Whether the sfp is enabled */
+	bool sfp_enabled;
+
+	/* type of the attached SFP */
+	u8 sfp_type;
+
+	/* Uses the sfp_configuration enum */
+	u32 sfp_configuration;
+
+	/* Whether we are using a 64-bit DMA mask */
+	bool dma_64_bit;
+
+	/* Interrupt Moderation Setting 0=low, 1=medium, 2=high */
+	enum INTR_MOD_RATE interrupt_moderation_rate;
+
+	/* Failover */
+	u32 private_ethtool_settings;
+
+	/* set of flags to give the driver a place to do synchronization
+	 * of processes
+	 */
+	unsigned long sync_flags;
+};
+
+#endif /* _PCI_MAC_H_ */
diff --git a/drivers/net/ethernet/sel/pci_mac_hw_regs.h b/drivers/net/ethernet/sel/pci_mac_hw_regs.h
new file mode 100644
index 000000000000..2c41c92d7dc1
--- /dev/null
+++ b/drivers/net/ethernet/sel/pci_mac_hw_regs.h
@@ -0,0 +1,370 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_PCI_MAC_HW_REGS_H_INCLUDED
+#define SEL_PCI_MAC_HW_REGS_H_INCLUDED
+
+#include <linux/types.h>
+
+/**
+ * struct sel_tx_bd - Transmit Buffer Descriptor (TXBD)
+ */
+struct sel_tx_bd {
+	/* Transmit buffer pointer address */
+	__le32 volatile txbd_addr0;
+	__le32 volatile txbd_addr1;
+
+	/* Transmit packet timestamp valid when txbd_ctrl[LST] is set */
+	__le32 volatile txbd_sec0;
+	__le32 volatile txbd_sec1_len;
+	__le32 volatile txbd_ns;
+
+	__le32 volatile txbd_csum;
+
+	__le32 volatile reserved1;
+
+	__le32 volatile txbd_ctrl;
+} __packed;
+
+/* Transmit buffer descriptor csum (TXBD_CSUM) field definitions */
+#define TXBD_CSUM_HEADER_OFFSET_MASK 0xFF000000U
+#define TXBD_CSUM_HEADER_OFFSET_SHIFT 24
+#define TXBD_CSUM_CSUM_OFFSET_MASK 0x00FF0000U
+#define TXBD_CSUM_CSUM_OFFSET_SHIFT 16
+#define TXBD_CSUM_RX_PCP_MASK 0x0000E000U
+#define TXBD_CSUM_RX_PCP_SHIFT 13
+#define TXBD_CSUM_RX_DEI BIT(12)
+#define TXBD_CSUM_RX_VID_MASK 0x00000FFFU
+
+/* Transmit buffer descriptor ns (TXBD_NS) field definitions */
+#define TXBD_NS_NS_MASK 0x3FFFFFFFU
+#define TXBD_NS_CSUM_TCP_EN BIT(30)
+#define TXBD_NS_CSUM_UDP_EN BIT(31)
+
+/* Transmit buffer descriptor sec/len (TXBD_SEC1_LEN) field definitions */
+#define TXBD_SEC1_LEN_SEC_HI_MASK 0xFFFFU
+#define TXBD_SEC1_LEN_SEC_HI_SHIFT 32
+#define TXBD_SEC1_LEN_LEN_MASK 0xFFFF0000U
+#define TXBD_SEC1_LEN_LEN_SHIFT 16
+
+/* Transmit buffer descriptor checksum (TXBD_CSUM) field definitions */
+#define TXBD_CSUM_CSUM_EN	BIT(16)
+#define TXBD_CSUM_HDR_OFF_MASK	0xFF00UL
+#define TXBD_CSUM_HDR_OFF_SHIFT	8
+#define TXBD_CSUM_CSUM_OFF_MASK	0xFFUL
+
+/* Transmit buffer descriptor control (TXBD_CTRL) field definitions */
+#define TXBD_CTRL_RDY BIT(31)
+#define TXBD_CTRL_ERR BIT(30)
+#define TXBD_CTRL_LST BIT(23)
+#define TXBD_CTRL_ID_MASK 0x00000FFFUL
+
+/**
+ * struct sel_rx_bd - Receive Buffer Descriptor (RXBD)
+ */
+struct sel_rx_bd {
+	/* Receive buffer pointer address */
+	__le32 volatile rxbd_addr0;
+	__le32 volatile rxbd_addr1;
+
+	/* Received packet timestamp valid when rxbd_ctrl[LST] is set */
+	__le32 volatile rxbd_sec0;
+	__le32 volatile rxbd_sec1_len;
+	__le32 volatile rxbd_ns;
+
+	__le32 volatile reserved0;
+	__le32 volatile reserved1;
+
+	__le32 volatile rxbd_ctrl;
+} __packed;
+
+/* Receive buffer descriptor sec/len (RXBD_SEC1_LEN) field definitions */
+#define RXBD_SEC1_LEN_SEC_HI_MASK 0xFFFFU
+#define RXBD_SEC1_LEN_SEC_HI_SHIFT 32
+#define RXBD_SEC1_LEN_LEN_MASK 0xFFFF0000U
+#define RXBD_SEC1_LEN_LEN_SHIFT 16
+
+/* Receive buffer descriptor control (RXBD_CTRL) field definitions */
+#define RXBD_CTRL_EMT BIT(31)
+#define RXBD_CTRL_ERR BIT(30)
+#define RXBD_CTRL_FRAG BIT(29)
+#define RXBD_CTRL_LOST_OTHERS BIT(28)
+#define RXBD_CTRL_LST BIT(23)
+#define RXBD_CTRL_ID_MASK 0x00000FFFUL
+
+#define RXBD_CTRL_UDP_VALID BIT(21)
+#define RXBD_CTRL_UDP_FOUND BIT(20)
+#define RXBD_CTRL_TCP_VALID BIT(19)
+#define RXBD_CTRL_TCP_FOUND BIT(18)
+#define RXBD_CTRL_IPV4_VALID BIT(17)
+#define RXBD_CTRL_IPV4_FOUND BIT(16)
+
+/* Information memory layout for attached SFP */
+struct sfp_info {
+	__le32 compliance_code;
+	__le32 bit_rate;
+	__le32 km_link_length_cap;
+	__le32 m_100m_link_length_cap;
+	__le32 m_50_10m_link_length_cap;
+	__le32 m_62_10m_link_length_cap;
+	__le32 link_length_cap_copper;
+	__le32 link_length_cap_fiber;
+	__le32 laser_wavelength;
+	__le32 diag_monitoring_type;
+	__le32 rx_power_low_alarm;
+	__le32 rx_power_low_warning;
+	__le32 internal_temp;
+	__le32 supply_voltage;
+	__le32 tx_bias_current;
+	__le32 tx_power;
+	__le32 rx_power;
+	__le32 rx_low_power_warning_alarm;
+	__le32 sel_part_number;
+	__le32 sel_part_serial_num_3;
+	__le32 sel_part_serial_num_2;
+	__le32 sel_part_serial_num_1;
+	__le32 sel_part_serial_num_0;
+	__le32 intr_evnt_sfp;
+} __packed;
+
+/* Register interface for the MAC */
+struct sel_pci_mac_registers {
+	struct mac_registers {
+		__le32 capabilities;
+		__le32 reserved1;
+		__le32 revision;
+		__le32 port_num;
+		__le32 mac_addr_in0;
+		__le32 mac_addr_in1;
+		__le32 mac_addr_set0;
+		__le32 mac_addr_set1;
+		__le32 failover;
+		__le32 arbitration;
+		__le32 macstat;
+		__le32 reserved2;
+#define NUM_GROUP_ADDR_REGS 8U
+		__le32 group_addr[NUM_GROUP_ADDR_REGS];
+	} mac;
+
+	struct intr_moderation_registers {
+		__le32 rxabs;
+		__le32 rxpacket;
+		__le32 txabs;
+		__le32 txpacket;
+		__le32 throttle;
+	} intr_moderation;
+
+	struct transmitter_registers {
+		__le32 tstat;
+		__le32 tx_bd_first_l;
+		__le32 tx_bd_first_h;
+		__le32 tx_bd_last_l;
+		__le32 tx_bd_last_h;
+		__le32 tx_rd_ptr;
+		__le32 tx_wr_ptr;
+		__le32 reserved[5];
+	} transmit;
+
+	struct receive_interface {
+		__le32 rstat;
+		__le32 rx_bd_first_l;
+		__le32 rx_bd_first_h;
+		__le32 rx_bd_last_l;
+		__le32 rx_bd_last_h;
+		__le32 rx_rd_ptr;
+		__le32 rx_wr_ptr;
+		__le32 reserved2[20];
+	} receive;
+
+	struct led_registers {
+		__le32 eth_led;
+		__le32 reserved[3];
+	} led;
+
+	struct irq_control_registers {
+		__le32 event_set;
+		__le32 event_clr;
+		__le32 mask_set;
+		__le32 mask_clr;
+		__le32 reserved[120];
+	} irq_ctrl;
+
+	/* 0x300 */
+	struct ethercat_registers {
+		__le32 config;
+		__le32 offset;
+	} ethercat;
+
+	struct reserved_registers {
+		__le32 reserved[126];
+	} reserved;
+
+	/* 0x500 */
+	struct i2c_registers {
+		__le32 i2c_control;
+		__le32 i2c_wr_data;
+		__le32 i2c_rd_data;
+	} i2c;
+
+	struct reserved_registers2 {
+		__le32 reserved[125];
+	} reserved2;
+
+	/* 0x700 */
+	struct mii_registers {
+		__le32 miimcfg;
+		__le32 miimcom;
+		__le32 miimadd;
+		__le32 miimcon;
+		__le32 miimstat;
+		__le32 miimind;
+		__le32 reserved[10];
+	} mii;
+
+	struct master_clock_registers {
+		__le32 clock_control;
+
+		__le32 time_adj_seconds_high;
+		__le32 time_adj_seconds_low;
+		__le32 time_adj_nanoseconds;
+
+		__le32 reserved_1;
+		__le32 read_time_seconds_high;
+		__le32 read_time_seconds_low;
+		__le32 read_time_nanoseconds;
+
+		__le32 clock_period_nanoseconds;
+		__le32 clock_period_sub_nanoseconds_high;
+		__le32 clock_period_sub_nanoseconds_low;
+
+		__le32 reserved_2;
+
+		__le32 temp_rate_nanoseconds;
+		__le32 temp_rate_sub_nanoseconds_high;
+		__le32 temp_rate_sub_nanoseconds_low;
+		__le32 temp_rate_duration;
+
+	} mc;
+} __packed;
+
+/* Cababilities register */
+#define CAPABILITIES_JUMBO_FRAMES    BIT(4)
+#define CAPABILITIES_CSUM_OFFLOAD    BIT(3)
+#define CAPABILITIES_FAILOVER_MASTER BIT(2)
+#define CAPABILITIES_FAILOVER_SLAVE  BIT(1)
+#define CAPABILITIES_LEGACY          BIT(0)
+
+/* Port Number register */
+#define PORT_NUM_MASK 0x000000FFUL
+#define PORT_NUM_PHY_ADDR_MASK 0xFF00UL
+#define PORT_NUM_PHY_ADDR_BITSHIFT 8U
+
+/* Hardware arbitration register */
+#define SMI_REQ_SET		BIT(0)
+#define SMI_REQ_GRANTED		BIT(16)
+#define SMI_REQ_CLEAR		BIT(8)
+#define I2C_REQ_SET		BIT(1)
+#define I2C_REQ_GRANTED		BIT(17)
+#define I2C_REQ_CLEAR		BIT(9)
+#define ARB_REQ_2_SET		BIT(2)
+#define ARB_REQ_2_GRANTED	BIT(18)
+#define ARB_REQ_2_CLEAR		BIT(10)
+#define ARB_REQ_3_SET		BIT(3)
+#define ARB_REQ_3_GRANTED	BIT(19)
+#define ARB_REQ_3_CLEAR		BIT(11)
+
+/* MAC status register */
+#define MACSTAT_MAXFRM_MASK 0xFFFFUL
+#define MACSTAT_MAXFRM_SHIFT 16
+#define MACSTAT_SOFT_RESET BIT(15)
+#define MACSTAT_SFP_DETECT BIT(13)
+#define MACSTAT_SFP_ENABLE BIT(12)
+#define MACSTAT_FULL_DUPLEX BIT(8)
+#define MACSTAT_SPEED_MASK (BIT(5) | BIT(4))
+#define MACSTAT_SPEED_10MB 0
+#define MACSTAT_SPEED_100MB BIT(4)
+#define MACSTAT_SPEED_1000MB BIT(5)
+#define MACSTAT_LINK BIT(0)
+
+/* Transmit status register */
+#define TSTAT_THLT BIT(31)
+#define TSTAT_TX_DMA_IP BIT(30)
+#define TSTAT_TX_EN BIT(16)
+#define TSTAT_TX_EMPTY_BYTES_MASK 0xFFFFUL
+
+/* Receive status register */
+#define RSTAT_RHLT BIT(31)
+#define RSTAT_RX_DMA_IP BIT(30)
+#define RSTAT_JUMBO_ENABLE_BIT BIT(19)
+#define RSTAT_BROADCAST_REJECT_BIT BIT(18)
+#define RSTAT_PROMISCUOUS_MODE_BIT BIT(17)
+#define RSTAT_RX_ENABLE BIT(16)
+#define RSTAT_RX_EMPTY_BYTES_MASK 0xFFFFUL
+
+/* Ethernet LED control register */
+#define ETH_LED_MODE_MAC 0
+#define ETH_LED_MODE_SOFTWARE BIT(8)
+#define ETH_LED_MODE_SOFTWARE_BLINK BIT(9)
+#define ETH_LED_MODE_PHY (BIT(8) | BIT(9))
+#define ETH_LED_RX_ACTIVITY BIT(2)
+#define ETH_LED_TX_ACTIVITY BIT(1)
+#define ETH_LED_LINK BIT(0)
+#define ETH_LED_TEST_ON (ETH_LED_MODE_SOFTWARE | ETH_LED_TX_ACTIVITY | \
+			 ETH_LED_RX_ACTIVITY | ETH_LED_LINK)
+#define ETH_LED_TEST_OFF ETH_LED_MODE_SOFTWARE
+#define ETH_LED_NORMAL ETH_LED_MODE_PHY
+
+/* Interrupt register(s) both mask and status */
+#define IRQ_TXF_BIT        BIT(0)
+#define IRQ_RXF_BIT        BIT(1)
+#define IRQ_LINK_BIT       BIT(2)
+#define IRQ_SFP_BIT        BIT(3)
+#define IRQ_DMA_ERR_BIT    BIT(5)
+#define IRQ_PORT_ERR_BIT   BIT(6)
+#define IRQ_RX_HALTED_BIT  BIT(7)
+
+/* I2C Interface register(s) */
+#define SEL_I2C_CTRL_ERR	BIT(31)
+#define SEL_I2C_SLV_ADDR_SHIFT	13
+#define SEL_I2C_REG_ADDR_SHIFT	5
+#define SEL_I2C_TRANS_LEN_SHIFT	2
+#define SEL_I2C_DIRECTION_SHIFT	1
+#define SEL_I2C_START_SHIFT	0
+#define SEL_I2C_DIRECTION_READ  BIT(1)
+#define SEL_I2C_DIRECTION_WRITE 0
+#define SEL_I2C_START           BIT(0)
+
+/* MIIMCFG register */
+#define MIIMCFG_MII_RST_MASK (BIT(31))
+
+/* MIIMCOM register */
+#define MIIMCOM_MII_READ_CYCLE (BIT(0))
+#define MIIMCOM_MII_SCAN_CYCLE (BIT(1))
+
+/* MIIMADD register */
+#define MIIMADD_MII_REG_ADDR_MASK   0x001FUL
+#define MIIMADD_MII_PHY_ADDR_MASK   0x1F00UL
+#define MIIMADD_MII_PHY_ADDR_OFFSET 8UL
+
+/* MIIMCON register */
+#define MIIMCON_MII_PHY_CONTROL_MASK 0xFFFFUL
+
+/* MIIMSTAT register */
+#define MIIMSTAT_MII_PHY_STATUS_MASK 0xFFFFUL
+
+/* MIIMIND register */
+#define MIIMIND_MII_BUSY	BIT(0)
+#define MIIMIND_MII_SCAN	BIT(1)
+#define MIIMIND_MII_NOT_VALID	BIT(2)
+
+/* MASTER CLOCK CONTROL register */
+#define MC_LOAD_FORCE_TIME	BIT(0)
+#define MC_STEP_TIME		BIT(1)
+#define MC_TS_DECREMENT		BIT(2)
+#define MC_LOAD_PERIOD		BIT(4)
+
+#endif /* SEL_PCI_MAC_HW_REGS_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/pci_mac_sysfs.c b/drivers/net/ethernet/sel/pci_mac_sysfs.c
new file mode 100644
index 000000000000..aba1b0e3fa8e
--- /dev/null
+++ b/drivers/net/ethernet/sel/pci_mac_sysfs.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include "hw_interface.h"
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+#include "pci_mac_sysfs.h"
+#include "sfp.h"
+
+/**
+ * enum sel_dev_attributes - device attributes
+ *
+ * These names match the exact names of the attributes supported
+ * via sysfs. These attributes configure ALL ports with the same
+ * values.
+ */
+enum sel_dev_attributes {
+	SFP_CONFIGURATION     = 0,
+	INTR_MOD_RATE	      = 1,
+	INTR_RX_ABS           = 2,
+	INTR_RX_PACKET        = 3,
+	INTR_TX_ABS           = 4,
+	INTR_TX_PACKET        = 5,
+	INTR_THROTTLE         = 6,
+	ETH_REGISTERED        = 7,
+	SFP_ID                = 8,
+	SFP_DIAG              = 9
+};
+
+#define INTR_MOD_MAX 255u
+
+/**
+ * dump_sfp_id() - Print the id values for this ports SFP
+ *
+ * @mac:	SEL MAC device
+ * @buff:	Buffer to write id values to
+ * @size:	The size of the buffer to write to
+ *
+ * @returns: Number of bytes written to buff
+ */
+static ssize_t dump_sfp_id(struct sel_pci_mac *mac, char *buff, int size)
+{
+	struct sel_sfp_id id;
+	ssize_t rc = 0;
+
+	if (sfp_read_id(mac, &id) < 0)
+		return 0;
+
+	if (id.sel_part[0] != 0) {
+		rc += snprintf(buff + rc, size - rc,
+			       "SELPartNumber: %.4s-%.2s\n",
+			       id.sel_part, id.sel_part_option);
+		rc += snprintf(buff + rc, size - rc,
+			       "SELSerialNumber: %.15s\n", id.sel_sn);
+	}
+	rc += snprintf(buff + rc, size - rc,
+		       "Manufacturer: %.16s\n", id.name);
+	rc += snprintf(buff + rc, size - rc,
+		       "PartNumber: %.16s\n", id.part);
+	rc += snprintf(buff + rc, size - rc,
+		       "Version: %.4s\n", id.rev);
+	rc += snprintf(buff + rc, size - rc,
+		       "SerialNumber: %.16s\n", id.sernum);
+	rc += snprintf(buff + rc, size - rc,
+		       "DateCode: %.8s\n", id.datecode);
+	rc += snprintf(buff + rc, size - rc,
+		       "Wavelength: %u nm\n", id.wavelength);
+	rc += snprintf(buff + rc, size - rc,
+		       "LengthSingleMode: %u m\n", id.length_smf_km);
+	rc += snprintf(buff + rc, size - rc,
+		       "Length50umOM2: %u m\n", id.length_om2);
+	rc += snprintf(buff + rc, size - rc,
+		       "Length62p5umOM1: %u m\n", id.length_om1);
+	rc += snprintf(buff + rc, size - rc,
+		       "LengthCopper: %u m\n", id.length_copper);
+	rc += snprintf(buff + rc, size - rc,
+		       "Length50umOM3: %u m\n", id.length_om3);
+
+	return rc;
+}
+
+/**
+ * dump_sfp_diag() - Print the diag values for this ports SFP
+ *
+ * @mac:	SEL MAC device
+ * @buff:	Buffer to write diag values to
+ * @size:	The size of the buffer to write to
+ *
+ * @returns: Number of bytes written to buff
+ */
+static ssize_t dump_sfp_diag(struct sel_pci_mac *mac, char *buff, int size)
+{
+	struct sel_sfp_diag diag;
+	ssize_t rc = 0;
+
+	if (sfp_read_diag(mac, &diag) < 0)
+		return 0;
+
+	rc += snprintf(buff + rc, size - rc,
+		       "Temperature: %d C\n", diag.temp);
+	rc += snprintf(buff + rc, size - rc,
+		       "SupplyVoltage: %u uV\n", diag.vcc);
+	rc += snprintf(buff + rc, size - rc,
+		       "TxBiasCurrent: %u uA\n", diag.tx_bias);
+	rc += snprintf(buff + rc, size - rc,
+		       "TxPower: %u nW\n", diag.tx_power);
+	rc += snprintf(buff + rc, size - rc,
+		       "RxPower: %u nW\n", diag.rx_power);
+
+	return rc;
+}
+
+/**
+ * __show_attr() - Return data for a specific attribute
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer to store output
+ * @attribute_type: the type of attribute to return information for
+ *
+ * Return: number of bytes stored in the buffer
+ */
+static ssize_t __show_attr(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buff,
+			   enum sel_dev_attributes attribute_type)
+{
+	struct selpcimac_platform_private *priv = dev_get_drvdata(dev->parent);
+	struct sel_pci_mac *mac = priv->priv;
+	ssize_t bytes_written = 0;
+	int length = 0;
+
+	switch (attribute_type) {
+	case SFP_CONFIGURATION:
+		bytes_written =	sprintf(buff, "%d\n",
+					(u32)mac->sfp_configuration);
+		break;
+
+	case INTR_MOD_RATE:
+		bytes_written =	sprintf(buff, "%d\n",
+					(u8)mac->interrupt_moderation_rate);
+		break;
+
+	case INTR_RX_ABS:
+		bytes_written =	sprintf(buff, "%d\n",
+					ioread32(&mac->hw_mac->intr_moderation.rxabs));
+		break;
+
+	case INTR_RX_PACKET:
+		bytes_written =	sprintf(buff, "%d\n",
+					ioread32(&mac->hw_mac->intr_moderation.rxpacket));
+		break;
+
+	case INTR_TX_ABS:
+		bytes_written =	sprintf(buff, "%d\n",
+					ioread32(&mac->hw_mac->intr_moderation.txabs));
+		break;
+
+	case INTR_TX_PACKET:
+		bytes_written =	sprintf(buff, "%d\n",
+					ioread32(&mac->hw_mac->intr_moderation.txpacket));
+		break;
+
+	case INTR_THROTTLE:
+		bytes_written = sprintf(buff, "%d\n",
+					ioread32(&mac->hw_mac->intr_moderation.throttle));
+		break;
+
+	case ETH_REGISTERED:
+		length += snprintf(buff + length,
+				   PAGE_SIZE - length,
+				   "%s\n",
+				   mac->netdev->name);
+		bytes_written = length;
+		break;
+
+	case SFP_ID:
+		bytes_written = dump_sfp_id(mac, buff, PAGE_SIZE);
+		break;
+
+	case SFP_DIAG:
+		bytes_written = dump_sfp_diag(mac, buff, PAGE_SIZE);
+		break;
+
+	default:
+		break;
+	}
+
+	return bytes_written;
+}
+
+/**
+ * __store_attr() - Store data for a specific attribute
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ * @size:           the size of the data to write from the buffer
+ * @attribute_type: the type of attribute to return information for
+ *
+ * Return: number of bytes used from the buffer
+ */
+static ssize_t __store_attr(struct device *dev,
+			    struct device_attribute *attr,
+			    char const *buff,
+			    size_t size,
+			    enum sel_dev_attributes attribute_type)
+{
+	struct selpcimac_platform_private *priv = dev_get_drvdata(dev->parent);
+	struct sel_pci_mac *mac = priv->priv;
+	ssize_t bytes_written = size;
+	unsigned long temp_data = 0;
+	int rc;
+
+	/* Convert the string to an integer */
+	rc = kstrtoul(buff, 10, &temp_data);
+	if (rc)
+		return rc;
+
+	switch (attribute_type) {
+	case SFP_CONFIGURATION:
+		/* Valid inputs are defined by the sfp_configurations
+		 * enum found in pci_mac.h. temp_data is unsigned so no
+		 * need to check the lower bound
+		 */
+		if (temp_data <= SFP_BYPASS_1000_SGMII) {
+			mac->sfp_configuration = temp_data;
+			sfp_update(mac);
+		};
+		break;
+
+	case INTR_MOD_RATE:
+		if (temp_data > INTR_MOD_HIGH)
+			break;
+		mac->interrupt_moderation_rate = (enum INTR_MOD_RATE)temp_data;
+		sel_set_intr_mod_rate(mac->interrupt_moderation_rate,
+				      mac->hw_mac);
+		break;
+
+	case INTR_RX_ABS:
+		if (temp_data > INTR_MOD_MAX)
+			break;
+		iowrite32(temp_data, &mac->hw_mac->intr_moderation.rxabs);
+		break;
+
+	case INTR_RX_PACKET:
+		if (temp_data > INTR_MOD_MAX)
+			break;
+		iowrite32(temp_data, &mac->hw_mac->intr_moderation.rxpacket);
+		break;
+
+	case INTR_TX_ABS:
+		if (temp_data > INTR_MOD_MAX)
+			break;
+		iowrite32(temp_data, &mac->hw_mac->intr_moderation.txabs);
+		break;
+
+	case INTR_TX_PACKET:
+		if (temp_data > INTR_MOD_MAX)
+			break;
+		iowrite32(temp_data, &mac->hw_mac->intr_moderation.txpacket);
+		break;
+
+	case INTR_THROTTLE:
+		if (temp_data > INTR_MOD_MAX)
+			break;
+		iowrite32(temp_data, &mac->hw_mac->intr_moderation.throttle);
+		break;
+
+	default:
+		bytes_written = 0;
+		break;
+	}
+
+	return bytes_written;
+}
+
+/**
+ * sfp_configuration_show() - Show SFP configuration
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ *
+ * Values are:
+ * 0: auto
+ * 1: 100 Mbps SERDES
+ * 2: 1000 Mbps SERDES
+ * 3: 100 Mbps SGMII
+ * 4: 1000 Mbps SGMII
+ */
+static ssize_t sfp_configuration_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buff)
+{
+	return __show_attr(dev, attr, buff, SFP_CONFIGURATION);
+}
+
+/**
+ * sfp_configuration_store() - Store SFP configuration
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ * @count:          the number of bytes in the buffer
+ *
+ * Return: number of bytes used from the buffer
+ *
+ * Values are:
+ * 0: auto
+ * 1: 100 Mbps SERDES
+ * 2: 1000 Mbps SERDES
+ * 3: 100 Mbps SGMII
+ * 4: 1000 Mbps SGMII
+ */
+static ssize_t sfp_configuration_store(struct device *dev,
+				       struct device_attribute *attr,
+				       char const *buff,
+				       size_t count)
+{
+	return __store_attr(dev, attr, buff, count, SFP_CONFIGURATION);
+}
+static DEVICE_ATTR_RW(sfp_configuration);
+
+/**
+ * interrupt_moderation_rate_show() - Show interrupt moderation rate.
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ *
+ * Valid options are 0, 1, or 2.
+ *
+ * 0: Low, lower packet latency in exchange for higher CPU burden.
+ * 1: Medium, a balance between packet latency and CPU burden. This is
+ *    the default.
+ * 2: High, higher packet latency in exchange for lower CPU burden.
+ */
+static ssize_t interrupt_moderation_rate_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buff)
+{
+	return __show_attr(dev, attr, buff, INTR_MOD_RATE);
+}
+
+/**
+ * interrupt_moderation_rate_store() - Store interrupt moderation rate
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ * @count:          the number of bytes in the buffer
+ *
+ * Return: number of bytes used from the buffer
+ *
+ * Valid options are 0, 1, or 2.
+ *
+ * 0: Low, lower packet latency in exchange for higher CPU burden.
+ * 1: Medium, a balance between packet latency and CPU burden. This is
+ *    the default.
+ * 2: High, higher packet latency in exchange for lower CPU burden.
+ */
+static ssize_t interrupt_moderation_rate_store(struct device *dev,
+					       struct device_attribute *attr,
+					       char const *buff,
+					       size_t count)
+{
+	return __store_attr(dev, attr, buff, count, INTR_MOD_RATE);
+}
+static DEVICE_ATTR_RW(interrupt_moderation_rate);
+
+/**
+ * intr_rx_abs_show() - Show interrupt RX absolute timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ */
+static ssize_t intr_rx_abs_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buff)
+{
+	return __show_attr(dev, attr, buff, INTR_RX_ABS);
+}
+
+/**
+ * intr_rx_abs_store() - Store interrupt RX absolute timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ * @count:          the number of bytes in the buffer
+ *
+ * Return: number of bytes used from the buffer
+ */
+static ssize_t intr_rx_abs_store(struct device *dev,
+				 struct device_attribute *attr,
+				 char const *buff,
+				 size_t count)
+{
+	return __store_attr(dev, attr, buff, count, INTR_RX_ABS);
+}
+static DEVICE_ATTR_RW(intr_rx_abs);
+
+/**
+ * intr_rx_packet_show() - Show interrupt RX packet timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ */
+static ssize_t intr_rx_packet_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buff)
+{
+	return __show_attr(dev, attr, buff, INTR_RX_PACKET);
+}
+
+/**
+ * intr_rx_packet_store() - Store interrupt RX packet timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ * @count:          the number of bytes in the buffer
+ *
+ * Return: number of bytes used from the buffer
+ */
+static ssize_t intr_rx_packet_store(struct device *dev,
+				    struct device_attribute *attr,
+				    char const *buff,
+				    size_t count)
+{
+	return __store_attr(dev, attr, buff, count, INTR_RX_PACKET);
+}
+static DEVICE_ATTR_RW(intr_rx_packet);
+
+/**
+ * intr_rx_packet_show() - Show interrupt TX absolute timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ */
+static ssize_t intr_tx_abs_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buff)
+{
+	return __show_attr(dev, attr, buff, INTR_TX_ABS);
+}
+
+/**
+ * intr_tx_abs_store() - Store interrupt TX absolute timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ * @count:          the number of bytes in the buffer
+ *
+ * Return: number of bytes used from the buffer
+ */
+static ssize_t intr_tx_abs_store(struct device *dev,
+				 struct device_attribute *attr,
+				 char const *buff,
+				 size_t count)
+{
+	return __store_attr(dev, attr, buff, count, INTR_TX_ABS);
+}
+static DEVICE_ATTR_RW(intr_tx_abs);
+
+/**
+ * intr_tx_packet_show() - Show interrupt TX packet timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ */
+static ssize_t intr_tx_packet_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buff)
+{
+	return __show_attr(dev, attr, buff, INTR_TX_PACKET);
+}
+
+/**
+ * intr_tx_packet_store() - Store interrupt TX packet timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ * @count:          the number of bytes in the buffer
+ *
+ * Return: number of bytes used from the buffer
+ */
+static ssize_t intr_tx_packet_store(struct device *dev,
+				    struct device_attribute *attr,
+				    char const *buff,
+				    size_t count)
+{
+	return __store_attr(dev, attr, buff, count, INTR_TX_PACKET);
+}
+static DEVICE_ATTR_RW(intr_tx_packet);
+
+/**
+ * intr_throttle_show() - Show interrupt throttle timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ */
+static ssize_t intr_throttle_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buff)
+{
+	return __show_attr(dev, attr, buff, INTR_THROTTLE);
+}
+
+/**
+ * intr_throttle_store() - Store interrupt throttle timer
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ * @count:          the number of bytes in the buffer
+ *
+ * Return: number of bytes used from the buffer
+ */
+static ssize_t intr_throttle_store(struct device *dev,
+				   struct device_attribute *attr,
+				   char const *buff,
+				   size_t count)
+{
+	return __store_attr(dev, attr, buff, count, INTR_THROTTLE);
+}
+static DEVICE_ATTR_RW(intr_throttle);
+
+/**
+ * eth_registered_show() - Show ethernet device name for this port, such
+ * as "eth0"
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ */
+static ssize_t eth_registered_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buff)
+{
+	return __show_attr(dev, attr, buff, ETH_REGISTERED);
+}
+static DEVICE_ATTR_RO(eth_registered);
+
+/**
+ * sel_sfp_id_show() - Show SFP ID information, such as part number and
+ * serial number.
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ */
+static ssize_t sel_sfp_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buff)
+{
+	return __show_attr(dev, attr, buff, SFP_ID);
+}
+static DEVICE_ATTR_RO(sel_sfp_id);
+
+/**
+ * sel_sfp_diag_show() - Show SFP diagnostic information
+ *
+ * @dev:            device object
+ * @attr:           device attribute to show info for
+ * @buff:           buffer containing the data to store
+ *
+ * Return: number of bytes written to the buffer
+ */
+static ssize_t sel_sfp_diag_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buff)
+{
+	return __show_attr(dev, attr, buff, SFP_DIAG);
+}
+static DEVICE_ATTR_RO(sel_sfp_diag);
+
+/* Array of device attributes */
+static struct attribute *sel_attributes[] = {
+	&dev_attr_sfp_configuration.attr,
+	&dev_attr_interrupt_moderation_rate.attr,
+	&dev_attr_intr_rx_abs.attr,
+	&dev_attr_intr_rx_packet.attr,
+	&dev_attr_intr_tx_abs.attr,
+	&dev_attr_intr_tx_packet.attr,
+	&dev_attr_intr_throttle.attr,
+	&dev_attr_eth_registered.attr,
+	&dev_attr_sel_sfp_id.attr,
+	&dev_attr_sel_sfp_diag.attr,
+	NULL
+};
+
+/* Device attributes group */
+static const struct attribute_group sel_attribute_group = {
+	.name = "sel_port",
+	.attrs = sel_attributes,
+};
+
+/**
+ * sel_set_attributes_group() - initialize attributes group
+ *
+ * @netdev: net device object
+ */
+void sel_set_attributes(struct net_device *netdev)
+{
+	netdev->sysfs_groups[0] = &sel_attribute_group;
+}
diff --git a/drivers/net/ethernet/sel/pci_mac_sysfs.h b/drivers/net/ethernet/sel/pci_mac_sysfs.h
new file mode 100644
index 000000000000..34c66b2c6953
--- /dev/null
+++ b/drivers/net/ethernet/sel/pci_mac_sysfs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+#ifndef SEL_PCI_MAC_SYSFS_INCLUDED
+#define SEL_PCI_MAC_SYSFS_INCLUDED
+
+#include <linux/netdevice.h>
+
+void sel_set_attributes(struct net_device *netdev);
+
+#endif /* SEL_PCI_MAC_SYSFS_INCLUDED */
diff --git a/drivers/net/ethernet/sel/sel_pci_mac_ioctl.h b/drivers/net/ethernet/sel/sel_pci_mac_ioctl.h
new file mode 100644
index 000000000000..b4f91bddf7e3
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_pci_mac_ioctl.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef _SEL_PCI_MAC_IOCTL_H
+#define _SEL_PCI_MAC_IOCTL_H
+
+#include <linux/types.h>
+
+/* Structure definition for ethercat settings */
+struct sel_pci_mac_ethercat {
+	/* Ethercat enabled/disabled */
+	bool ethercat_enabled;
+
+	/* Timestamp adjustment offset */
+	__u32 offset;
+} __packed;
+
+#define SEL_PCI_MAC_ETHERCAT_GET 0x89F0
+#define SEL_PCI_MAC_ETHERCAT_SET 0x89F1
+
+#endif /* _SEL_PCI_MAC_IOCTL_H */
diff --git a/drivers/net/ethernet/sel/sel_phy.h b/drivers/net/ethernet/sel/sel_phy.h
new file mode 100644
index 000000000000..b422e639815a
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_phy.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_PHY_H_INCLUDED
+#define SEL_PHY_H_INCLUDED
+
+#include <linux/types.h>
+
+#include "pci_mac_hw_regs.h"
+
+struct sel_generic_phy {
+	/**
+	 * sel_phy_reset() - Reset the PHY to a known state
+	 *
+	 * @hw_mac:    MAC base address
+	 * @phy:       phy address
+	 *
+	 * The PHY required settings are reset here as well.
+	 *
+	 * Return: 0 if successful, otherwise negative error code
+	 */
+	int (*sel_phy_reset)(struct sel_pci_mac_registers *hw_mac, int phy);
+
+	/**
+	 * sel_phy_setup() - Set required settings in a PHY
+	 *
+	 * @hw_mac:          MAC base address
+	 * @phy:             phy address
+	 */
+	void (*sel_phy_setup)(struct sel_pci_mac_registers *hw_mac, int phy);
+
+	/**
+	 * sel_phy_clear_rgmii_100_base_fx_mode() - Set speed 1000 Base-X mode
+	 *
+	 * @hw_mac:    MAC base address
+	 * @phy:       phy address
+	 */
+	void (*sel_phy_clear_rgmii_100_base_fx_mode)(struct sel_pci_mac_registers *hw_mac,
+						     int phy);
+
+	/**
+	 * sel_phy_set_rgmii_100base_fx_mode() - Set speed 100Base-FX mode
+	 *
+	 * @hw_mac:    MAC base address
+	 * @phy:       phy address
+	 */
+	void (*sel_phy_set_rgmii_100_base_fx_mode)(struct sel_pci_mac_registers *hw_mac,
+						   int phy);
+
+	/**
+	 * sel_phy_set_sgmii() - Set sgmii mode
+	 *
+	 * @hw_mac:    MAC base address
+	 * @phy:       phy address
+	 */
+	void (*sel_phy_set_sgmii)(struct sel_pci_mac_registers *hw_mac,
+				  int phy);
+
+	/**
+	 * sel_phy_power_down() - Power down a PHY
+	 *
+	 * @hw_mac:    MAC base address
+	 * @phy:       phy address
+	 */
+	void (*sel_phy_power_down)(struct sel_pci_mac_registers *hw_mac,
+				   int phy);
+
+	/**
+	 * sel_phy_power_up() - Power up a PHY
+	 *
+	 * @hw_mac:    MAC base address
+	 * @phy:       phy address
+	 */
+	void (*sel_phy_power_up)(struct sel_pci_mac_registers *hw_mac,
+				 int phy);
+
+	/**
+	 * sel_linkdown_poll() - Poll event during link down
+	 *
+	 * @hw_mac:    MAC base address
+	 * @phy:       phy address
+	 */
+	void (*sel_phy_linkdown_poll)(struct sel_pci_mac_registers *hw_mac,
+				      int phy);
+};
+
+#endif /* SEL_PHY_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/sel_phy_broadcom.c b/drivers/net/ethernet/sel/sel_phy_broadcom.c
new file mode 100644
index 000000000000..fcb6e386cf0c
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_phy_broadcom.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/mii.h>
+#include <linux/types.h>
+
+#include "hw_interface.h"
+#include "mii_interface.h"
+#include "pci_mac_hw_regs.h"
+#include "sel_phy_broadcom.h"
+
+/* For expansion registers, the expansion value must be written to
+ * register 17h [11:8], and the register number written to the lower
+ * bits. Then the register can be read/written through reserved
+ * register 15h
+ */
+#define BROADCOM_PHY_EXTENDED_CONTROL_REGISTER		((u8)0x10)
+#define PHY_EXTENDED_CONTROL_HIGH_LATENCY		(0x01)
+#define BROADCOM_PHY_SERDES_CONTROL_REGISTER		((u8)0x50)
+
+/* This shadow register has selection bits in bits [2:0]. */
+#define BROADCOM_BASE_T_AUX_CONTROL_REGISTER		((u8)0x18)
+
+#define SHADOW_VALUE_BASE_T_AUX_CONTROL			((u16)0x0000)
+#define AUX_CONTROL_REQUIRED_SETTINGS			((u16)0x4000)
+
+#define SHADOW_VALUE_BASE_T_MISC_CONTROL		((u16)0x7000)
+#define MISC_CONTROL_REQUIRED_SETTINGS			((u16)0x03D7)
+
+/* This shadow register has selection bits in bits [14:10] */
+#define BROADCOM_BASE_T_SHADOW_REGISTER			((u8)0x1C)
+
+#define SHADOW_VALUE_100BASE_FX_CONTROL			((u16)0x4C00)
+#define PHY_ENABLE_100BASE_FX				((u16)0xB)
+
+#define SHADOW_VALUE_SPARE_CTRL_THREE			((u16)0x1400)
+#define PHY_CLK_REQUIRED_SETTINGS			((u16)0x151C)
+
+#define SHADOW_VALUE_SGMII_SLAVE			((u16)0x5400)
+#define SGMII_SLAVE_REQUIRED_SETTINGS			((u16)0xD489)
+
+#define SHADOW_VALUE_MODE_CONTROL			((u16)0x7C00)
+#define PHY_MODE_SELECT_MASK				((u16)0x06)
+#define PHY_FIBER_MODE					((u16)1 << 1)
+
+#define BROADCOM_SHADOW_GLOBAL_WRITE_BIT		((u16)1 << 15)
+#define BROADCOM_EXPANSION_SECONDARY_SERDES_REGISTER	((u16)0x0017)
+#define BROADCOM_PHY_EXPANSION_REGISTER_VALUE		((u16)0x0F00)
+#define BROADCOM_RESERVED_ONE_REGISTER			((u16)0x0015)
+
+/**
+ * sel_mii_write_shadow_register() - Writes a shadow register
+ *
+ * @hw_mac:          MAC base address
+ * @phy:             phy address
+ * @shadow_register: the shadow register to access
+ * @shadow_value:    the shadow value selection bits
+ * @data:            the data to write to the register
+ */
+static void sel_mii_write_shadow_register(struct sel_pci_mac_registers *hw_mac,
+					  int phy,
+					  u8 shadow_register,
+					  u16 shadow_value,
+					  u16 data)
+{
+	u16 data_to_write;
+
+	/* set data to write to phy */
+	data_to_write =
+		(data | shadow_value | BROADCOM_SHADOW_GLOBAL_WRITE_BIT);
+
+	/* Write the data to the register */
+	sel_mii_write(hw_mac, phy, shadow_register, data_to_write);
+}
+
+/**
+ * sel_mii_write_expansion_register() - write a PHY expansion register
+ *
+ * @hw_mac:             MAC base address
+ * @phy:                phy address
+ * @expansion_register: the PHY expansion register to access
+ * @data:               the data to write to the register
+ */
+static void sel_mii_write_expansion_register(struct sel_pci_mac_registers *hw_mac,
+					     int phy,
+					     u8 expansion_register,
+					     u16 data)
+{
+	/* Set the expansion register we wish to write to */
+	sel_mii_write(hw_mac,
+		      phy,
+		      BROADCOM_EXPANSION_SECONDARY_SERDES_REGISTER,
+		      BROADCOM_PHY_EXPANSION_REGISTER_VALUE + expansion_register);
+
+	/* Write the actual data */
+	sel_mii_write(hw_mac, phy, BROADCOM_RESERVED_ONE_REGISTER, data);
+}
+
+/**
+ * sel_phy_broadcom_reset() - Reset the PHY to a known state
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ *
+ * The PHY required settings are reset here as well.
+ *
+ * Return: 0 if successful, otherwise negative error code
+ */
+static int sel_phy_broadcom_reset(struct sel_pci_mac_registers *hw_mac,
+				  int phy)
+{
+	u8 timeout = 0;
+	int err = 0;
+
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, BMCR_RESET, 0);
+
+	while ((sel_mii_read(hw_mac, phy, MII_BMCR) & BMCR_RESET) != 0) {
+		if (timeout >= SEL_RESET_WAIT_RETRIES) {
+			err = -EIO;
+			break;
+		}
+
+		timeout++;
+
+		udelay(10);
+	};
+
+	return err;
+}
+
+/**
+ * sel_phy_broadcom_setup() - Set required settings in a PHY
+ *
+ * @hw_mac:          MAC base address
+ * @phy:             phy address
+ *
+ */
+static void sel_phy_broadcom_setup(struct sel_pci_mac_registers *hw_mac,
+				   int phy)
+{
+	/* Enable out-of-band status */
+	sel_mii_write_shadow_register(hw_mac,
+				      phy,
+				      BROADCOM_BASE_T_AUX_CONTROL_REGISTER,
+				      SHADOW_VALUE_BASE_T_MISC_CONTROL,
+				      MISC_CONTROL_REQUIRED_SETTINGS);
+
+	/* Set required PHY CLK125 settings */
+	sel_mii_write_shadow_register(hw_mac,
+				      phy,
+				      BROADCOM_BASE_T_SHADOW_REGISTER,
+				      SHADOW_VALUE_SPARE_CTRL_THREE,
+				      PHY_CLK_REQUIRED_SETTINGS);
+
+	/* Set required SGMII settings */
+	sel_mii_write_shadow_register(hw_mac,
+				      phy,
+				      BROADCOM_BASE_T_SHADOW_REGISTER,
+				      SHADOW_VALUE_SGMII_SLAVE,
+				      SGMII_SLAVE_REQUIRED_SETTINGS);
+
+	/* We don't support 1Gbps Half Duplex, so don't advertise it */
+	sel_mii_read_mod_write(hw_mac,
+			       phy,
+			       MII_CTRL1000,
+			       0,
+			       ADVERTISE_1000HALF);
+
+	/* Enable large packets */
+	sel_mii_write_shadow_register(hw_mac,
+				      phy,
+				      BROADCOM_BASE_T_SHADOW_REGISTER,
+				      SHADOW_VALUE_BASE_T_AUX_CONTROL,
+				      AUX_CONTROL_REQUIRED_SETTINGS);
+	sel_mii_read_mod_write(hw_mac,
+			       phy,
+			       BROADCOM_PHY_EXTENDED_CONTROL_REGISTER,
+			       PHY_EXTENDED_CONTROL_HIGH_LATENCY,
+			       0);
+}
+
+/**
+ * sel_phy_broadcom_clear_rgmii_100base_fx_mode() - Clear RGMII-100Base-FX mode
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_broadcom_clear_rgmii_100base_fx_mode(struct sel_pci_mac_registers *hw_mac,
+							 int phy)
+{
+	/* 1. Clear 100Base-FX Mode */
+	sel_mii_write_shadow_register(hw_mac,
+				      phy,
+				      BROADCOM_BASE_T_SHADOW_REGISTER,
+				      SHADOW_VALUE_100BASE_FX_CONTROL,
+				      0);
+
+	/* 2. Reset PHY */
+	(void)sel_phy_broadcom_reset(hw_mac, phy);
+
+	/* 3. Set PHY required settings */
+	sel_phy_broadcom_setup(hw_mac, phy);
+}
+
+/**
+ * sel_phy_broadcom_set_rgmii_100base_fx_mode() - Set RGMII-100Base-FX mode
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_broadcom_set_rgmii_100base_fx_mode(struct sel_pci_mac_registers *hw_mac,
+						       int phy)
+{
+	/* The following steps are defined on page 75 of the
+	 * Broadcom BCM5482SA2IFBG_0 specficiation
+	 *
+	 * 1. Place the device in RGMII-fiber mode
+	 * This is done in hardware....
+	 */
+
+	/* 2. Set Loopback */
+	sel_mii_write(hw_mac, phy, MII_BMCR, BMCR_LOOPBACK);
+
+	/* 3. Set 100Base-FX Mode */
+	sel_mii_write_shadow_register(hw_mac,
+				      phy,
+				      BROADCOM_BASE_T_SHADOW_REGISTER,
+				      SHADOW_VALUE_100BASE_FX_CONTROL,
+				      PHY_ENABLE_100BASE_FX);
+
+	/* 4. Pwr Down SerDes Rx Path
+	 * 0x0C3B is defined in Broadcom spec
+	 */
+	sel_mii_write_expansion_register(hw_mac,
+					 phy,
+					 BROADCOM_PHY_SERDES_CONTROL_REGISTER,
+					 0x0C3Bu);
+
+	/* 5. Power-up and reset SerDes Rx Path
+	 * 0x0C3A is defined in Broadcom spec
+	 */
+	sel_mii_write_expansion_register(hw_mac,
+					 phy,
+					 BROADCOM_PHY_SERDES_CONTROL_REGISTER,
+					 0x0C3Au);
+
+	/* 6. reset loopback to switch clock back to SerDes Rx clock */
+	sel_mii_write(hw_mac, phy, MII_BMCR, 0);
+
+	/* 7. Set LED settings */
+	sel_phy_broadcom_setup(hw_mac, phy);
+}
+
+/**
+ * sel_phy_broadcom_set_sgmii_mode() - Sets the mode to sgmii
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_broadcom_set_sgmii_mode(struct sel_pci_mac_registers *hw_mac,
+					    int phy)
+{
+}
+
+/**
+ * sel_phy_broadcom_power_down() - Power down a PHY
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_broadcom_power_down(struct sel_pci_mac_registers *hw_mac,
+					int phy)
+{
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, BMCR_PDOWN, 0);
+}
+
+/**
+ * sel_phy_broadcom_power_up() - Power up a PHY
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_broadcom_power_up(struct sel_pci_mac_registers *hw_mac,
+				      int phy)
+{
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, 0, BMCR_PDOWN);
+}
+
+static struct sel_generic_phy broadcom_generic_phy = {
+	.sel_phy_reset = sel_phy_broadcom_reset,
+	.sel_phy_setup = sel_phy_broadcom_setup,
+	.sel_phy_set_rgmii_100_base_fx_mode =
+		sel_phy_broadcom_set_rgmii_100base_fx_mode,
+	.sel_phy_clear_rgmii_100_base_fx_mode =
+		sel_phy_broadcom_clear_rgmii_100base_fx_mode,
+	.sel_phy_set_sgmii = sel_phy_broadcom_set_sgmii_mode,
+	.sel_phy_power_down = sel_phy_broadcom_power_down,
+	.sel_phy_power_up = sel_phy_broadcom_power_up,
+	.sel_phy_linkdown_poll = NULL,
+};
+
+/**
+ * sel_get_broadcom_phy_def() - Retrieve broadcom phy definition
+ *
+ * Return: Pointer to broadcom_phy definitions struct
+ */
+struct sel_generic_phy *sel_get_broadcom_phy_def(void)
+{
+	return &broadcom_generic_phy;
+}
diff --git a/drivers/net/ethernet/sel/sel_phy_broadcom.h b/drivers/net/ethernet/sel/sel_phy_broadcom.h
new file mode 100644
index 000000000000..6c1fc3deb67e
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_phy_broadcom.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_PHY_BROADCOM_H_INCLUDED
+#define SEL_PHY_BROADCOM_H_INCLUDED
+
+#include "sel_phy.h"
+
+struct sel_generic_phy *sel_get_broadcom_phy_def(void);
+
+#endif /* SEL_PHY_BROADCOM_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/sel_phy_marvell.c b/drivers/net/ethernet/sel/sel_phy_marvell.c
new file mode 100644
index 000000000000..97fc7af275a4
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_phy_marvell.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/mii.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "hw_interface.h"
+#include "mii_interface.h"
+#include "pci_mac_hw_regs.h"
+#include "sel_phy_marvell.h"
+
+#define MARVELL_PAGE_ADDRESS				((u8)0x16)
+
+#define MARVELL_COPPER_PAGE				0
+#define COPPER_CONTROL_REG3				26
+#define FAST_LINK_DOWN_DETECT				(BIT(9))
+#define FAST_LINK_DOWN_DELAY_MASK			((u16)0xC00)
+
+#define MARVELL_FIBER_PAGE				1
+#define FIBER_SPECIFIC_CONTROL_REG2			26
+#define SGMII_OUT_AMPLITUDE_VAL				((u16)0x3)
+#define FEFI_ENABLE					(BIT(9))
+#define NOISE_FILTER					(BIT(14))
+#define MARVELL_IEEE_REMOTE_FAULT_IND_ENABLE		(BIT(4))
+
+#define MARVELL_MAC_SETTINGS_PAGE			2
+#define MARVELL_SPECIFIC_CONTROL_REGISTER		((u8)0x10)
+#define MARVELL_125MHZ_CLK_DISABLE_MASK			(BIT(1))
+#define MARVELL_CLK_REQUIRED_SETTINGS_MASK		(BIT(9))
+
+#define MARVELL_LED_FUNCTION_CONTROL_PAGE		3
+#define MARVELL_LED_FCA_REGISTER			15
+#define MARVELL_LED_FCS_TX_SFD_ENABLE			(BIT(0))
+#define MARVELL_LED_FCS_RX_SFD_ENABLE			(BIT(1))
+
+#define REDLIGHT_FIX_PAGE				254
+#define REDLIGHT_FIX_REG				19
+#define SIGNAL_DETECT_SETTING				(BIT(7))
+
+#define MARVELL_GENERAL_CONTROL_PAGE		0x12
+#define MARVELL_GENERAL_CONTROL_REGISTER	0x14
+#define MARVELL_GENERAL_CONTROL_RESET_MASK	0x8000
+#define MARVELL_GENERAL_CONTROL_MODE_BITS	0x0007
+#define MARVELL_GENERAL_CONTROL_1000_BASE_X	0x0002
+#define MARVELL_GENERAL_CONTROL_100_BASE_FX	0x0003
+#define MARVELL_GENERAL_CONTROL_SGMII		0x0006
+
+#define SEL_RESET_WAIT_RETRIES			8
+
+/**
+ * marvell_change_page() - change the page of the phy
+ *
+ * @hw_mac: Mac base address
+ * @phy: The phy address to write to
+ * @page: The page to change the phy to
+ */
+static void marvell_change_page(struct sel_pci_mac_registers *hw_mac,
+				int phy,
+				u8 page)
+{
+	sel_mii_write(hw_mac, phy, MARVELL_PAGE_ADDRESS, page);
+}
+
+/**
+ * marvell_read_mod_write() - performs mii read mod write with page change
+ *
+ * @hw_mac: Mac base address
+ * @phy: The phy address to write to
+ * @page: The page to change the phy to
+ * @reg: The register to modify
+ * @set_bits: The bits to set in the register
+ * @clear_bits: The bits to clear in the register
+ */
+static void marvell_read_mod_write(struct sel_pci_mac_registers *hw_mac,
+				   int phy,
+				   u8 page,
+				   u8 reg,
+				   u16 set_bits,
+				   u16 clear_bits)
+{
+	/* change the page and set/clear the bits */
+	marvell_change_page(hw_mac, phy, page);
+	sel_mii_read_mod_write(hw_mac, phy, reg, set_bits, clear_bits);
+}
+
+/**
+ * sel_phy_marvell_sfp_present() - Checks if sfp is present
+ *
+ * @hw_mac:    MAC base address
+ *
+ * Return: true if sfp detected, otherwise 0
+ */
+static bool sel_phy_marvell_sfp_present(struct sel_pci_mac_registers *hw_mac)
+{
+	u32 macstat = ioread32(&hw_mac->mac.macstat);
+
+	return ((macstat & MACSTAT_SFP_DETECT) != 0) ? true : false;
+}
+
+/**
+ * sel_phy_marvell_reset() - Reset the PHY to a known state
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ *
+ * The PHY required settings are reset here as well.
+ *
+ * Return: 0 if successful, otherwise negative error code
+ */
+static int sel_phy_marvell_reset(struct sel_pci_mac_registers *hw_mac,
+				 int phy)
+{
+	u16 data = 0x0000;
+	u8 timeout = 0;
+	int err = 0;
+
+	/* write reset bit, then loop until reset is complete */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       sel_phy_marvell_sfp_present(hw_mac) ?
+					MARVELL_FIBER_PAGE : MARVELL_COPPER_PAGE,
+			       MII_BMCR,
+			       BMCR_RESET,
+			       0);
+
+	do {
+		data = sel_mii_read(hw_mac, phy, MII_BMCR);
+		if (timeout >= SEL_RESET_WAIT_RETRIES) {
+			err = -EIO;
+			break;
+		}
+		timeout++;
+		udelay(10);
+	} while ((data & BMCR_RESET) != 0);
+
+	return err;
+}
+
+/**
+ * sel_phy_marvell_general_reset() - Reset the general PHY regs to a known state
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ *
+ * Return: 0 if successful, otherwise negative error code
+ */
+static int sel_phy_marvell_general_reset(struct sel_pci_mac_registers *hw_mac,
+					 int phy)
+{
+	u16 data = 0x0000;
+	u8 timeout = 0;
+	int err = 0;
+
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_GENERAL_CONTROL_PAGE,
+			       MARVELL_GENERAL_CONTROL_REGISTER,
+			       MARVELL_GENERAL_CONTROL_RESET_MASK, /* set */
+			       0); /* clear */
+
+	do {
+		data = sel_mii_read(hw_mac,
+				    phy,
+				    MARVELL_GENERAL_CONTROL_REGISTER);
+
+		if (timeout >= SEL_RESET_WAIT_RETRIES) {
+			err = -EIO;
+			break;
+		}
+		timeout++;
+		udelay(10);
+
+	} while ((data & MARVELL_GENERAL_CONTROL_RESET_MASK) != 0);
+
+	return err;
+}
+
+/**
+ * sel_phy_marvell_setup() - Set required settings in a PHY
+ *
+ * @hw_mac:          MAC base address
+ * @phy:             phy address
+ *
+ */
+static void sel_phy_marvell_setup(struct sel_pci_mac_registers *hw_mac,
+				  int phy)
+{
+	/* Enable RX SFP Detect Pulse */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_LED_FUNCTION_CONTROL_PAGE, /* page */
+			       MARVELL_LED_FCA_REGISTER, /* register */
+			       MARVELL_LED_FCS_RX_SFD_ENABLE, /* set */
+			       0); /* clear */
+
+	/* Enable TX SFP Detect Pulse */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_LED_FUNCTION_CONTROL_PAGE, /* page */
+			       MARVELL_LED_FCA_REGISTER, /* register */
+			       MARVELL_LED_FCS_TX_SFD_ENABLE, /* set */
+			       0); /* clear */
+
+	/* Remove 1000BASE-T Half duplex from advertisement */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_COPPER_PAGE, /* page */
+			       MII_CTRL1000, /* register */
+			       0, /* set */
+			       ADVERTISE_1000HALF); /* clear */
+
+	/* Enable fast link down indication enable to 1 */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_COPPER_PAGE, /* page */
+			       COPPER_CONTROL_REG3, /* register */
+			       FAST_LINK_DOWN_DETECT, /* set */
+			       0); /* clear */
+
+	/* Set fast link down indication delay to 0 */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_COPPER_PAGE, /* page */
+			       COPPER_CONTROL_REG3, /* register */
+			       0, /* set */
+			       FAST_LINK_DOWN_DELAY_MASK); /* clear */
+
+	/* 1000Base-X Noise Filtering */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_FIBER_PAGE, /* page */
+			       FIBER_SPECIFIC_CONTROL_REG2, /* register */
+			       NOISE_FILTER, /* set */
+			       0); /* clear */
+
+	/* Enable Far End Fault Detection (FEFI) */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_FIBER_PAGE, /* page */
+			       FIBER_SPECIFIC_CONTROL_REG2, /* register */
+			       FEFI_ENABLE, /* set */
+			       0); /* clear */
+
+	/* Set SGMII Output Amplitude to a 3 (308mV) */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_FIBER_PAGE, /* page */
+			       FIBER_SPECIFIC_CONTROL_REG2, /* register */
+			       SGMII_OUT_AMPLITUDE_VAL, /* set */
+			       0); /* clear */
+
+	/* Set signal detect for Redlight 2295 fix */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       REDLIGHT_FIX_PAGE, /* page */
+			       REDLIGHT_FIX_REG, /* register */
+			       SIGNAL_DETECT_SETTING, /* set */
+			       0); /* clear */
+
+	/* Hardware requested that we disable the 125 MHz clock pin output
+	 * in order to pass emissions testing, the code below does that
+	 */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_MAC_SETTINGS_PAGE, /* page */
+			       MARVELL_SPECIFIC_CONTROL_REGISTER, /* register */
+			       MARVELL_125MHZ_CLK_DISABLE_MASK, /* set */
+			       0); /* clear */
+
+	/* The Remote Fault indication is a fiber specific protocol to
+	 * make sure transmission is happening both directions before
+	 * declaring a successful link.
+	 */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_FIBER_PAGE, /* page */
+			       MARVELL_SPECIFIC_CONTROL_REGISTER, /* register */
+			       MARVELL_IEEE_REMOTE_FAULT_IND_ENABLE, /* set */
+			       0); /* clear */
+
+	sel_phy_marvell_reset(hw_mac, phy);
+}
+
+/**
+ * sel_phy_marvell_set_speed_1000() - Set 1000Base-X mode
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_marvell_set_speed_1000(struct sel_pci_mac_registers *hw_mac,
+					   int phy)
+{
+	/* Clear the bottom 3 mode bits */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_GENERAL_CONTROL_PAGE,
+			       MARVELL_GENERAL_CONTROL_REGISTER,
+			       0, /* set */
+			       MARVELL_GENERAL_CONTROL_MODE_BITS); /* clear */
+
+	/* Set 1000 base x mode */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_GENERAL_CONTROL_PAGE,
+			       MARVELL_GENERAL_CONTROL_REGISTER,
+			       MARVELL_GENERAL_CONTROL_1000_BASE_X, /* set */
+			       0); /* clear */
+
+	/* Enable Fiber Auto-Negotiation */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_FIBER_PAGE, /* page */
+			       MII_BMCR, /* register */
+			       BMCR_ANENABLE, /* set */
+			       0); /* clear */
+
+	sel_phy_marvell_general_reset(hw_mac, phy);
+	sel_phy_marvell_setup(hw_mac, phy);
+}
+
+/**
+ * sel_phy_marvell_set_speed_100() - Set RGMII-100Base-FX mode
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_marvell_set_speed_100(struct sel_pci_mac_registers *hw_mac,
+					  int phy)
+{
+	/* Clear the bottom 3 mode bits */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_GENERAL_CONTROL_PAGE,
+			       MARVELL_GENERAL_CONTROL_REGISTER,
+			       0, /* set */
+			       MARVELL_GENERAL_CONTROL_MODE_BITS); /* clear */
+
+	/* Set 100 base fx mode */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_GENERAL_CONTROL_PAGE,
+			       MARVELL_GENERAL_CONTROL_REGISTER,
+			       MARVELL_GENERAL_CONTROL_100_BASE_FX, /* set */
+			       0); /* clear */
+
+	/* Enable Fiber Auto-Negotiation
+	 * Note: This bit is ignored in 100BASE-FX mode so this is more
+	 * an informational line of code.
+	 */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_FIBER_PAGE, /* page */
+			       MII_BMCR, /* register */
+			       BMCR_ANENABLE, /* set */
+			       0); /* clear */
+
+	sel_phy_marvell_general_reset(hw_mac, phy);
+	sel_phy_marvell_setup(hw_mac, phy);
+}
+
+/**
+ * sel_phy_marvell_set_sgmii_mode() - Sets the mode to sgmii
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_marvell_set_sgmii_mode(struct sel_pci_mac_registers *hw_mac,
+					   int phy)
+{
+	/* Clear the bottom 3 mode bits */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_GENERAL_CONTROL_PAGE,
+			       MARVELL_GENERAL_CONTROL_REGISTER,
+			       0, /* set */
+			       MARVELL_GENERAL_CONTROL_MODE_BITS); /* clear */
+
+	/* Set SGMII mode */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_GENERAL_CONTROL_PAGE,
+			       MARVELL_GENERAL_CONTROL_REGISTER,
+			       MARVELL_GENERAL_CONTROL_SGMII, /* set */
+			       0); /* clear */
+
+	/* Enable Auto-Negotiation in SGMII mode to get link from remote end */
+	marvell_read_mod_write(hw_mac,
+			       phy,
+			       MARVELL_FIBER_PAGE, /* page */
+			       MII_BMCR, /* register */
+			       BMCR_ANENABLE, /* set */
+			       0); /* clear */
+
+	sel_phy_marvell_general_reset(hw_mac, phy);
+	sel_phy_marvell_setup(hw_mac, phy);
+}
+
+/**
+ * sel_phy_marvell_power_down() - Power down a PHY
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_marvell_power_down(struct sel_pci_mac_registers *hw_mac,
+				       int phy)
+{
+	u8 page = MARVELL_COPPER_PAGE;
+
+	if (sel_phy_marvell_sfp_present(hw_mac))
+		page = MARVELL_FIBER_PAGE;
+
+	marvell_read_mod_write(hw_mac, phy, page, MII_BMCR, BMCR_PDOWN, 0);
+}
+
+/**
+ * sel_phy_marvell_power_up() - Power up a PHY
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_marvell_power_up(struct sel_pci_mac_registers *hw_mac,
+				     int phy)
+{
+	u8 page = MARVELL_COPPER_PAGE;
+
+	if (sel_phy_marvell_sfp_present(hw_mac))
+		page = MARVELL_FIBER_PAGE;
+
+	marvell_read_mod_write(hw_mac, phy, page, MII_BMCR, 0, BMCR_PDOWN);
+}
+
+static struct sel_generic_phy marvell_generic_phy = {
+	.sel_phy_reset = sel_phy_marvell_reset,
+	.sel_phy_setup = sel_phy_marvell_setup,
+	.sel_phy_clear_rgmii_100_base_fx_mode =	sel_phy_marvell_set_speed_1000,
+	.sel_phy_set_rgmii_100_base_fx_mode = sel_phy_marvell_set_speed_100,
+	.sel_phy_set_sgmii = sel_phy_marvell_set_sgmii_mode,
+	.sel_phy_power_down = sel_phy_marvell_power_down,
+	.sel_phy_power_up = sel_phy_marvell_power_up,
+	.sel_phy_linkdown_poll = NULL,
+};
+
+/**
+ * sel_get_marvell_phy_def() - Retrieve phy definition
+ *
+ * Return: Pointer to marvell_phy definitions struct
+ */
+struct sel_generic_phy *sel_get_marvell_phy_def(void)
+{
+	return &marvell_generic_phy;
+}
diff --git a/drivers/net/ethernet/sel/sel_phy_marvell.h b/drivers/net/ethernet/sel/sel_phy_marvell.h
new file mode 100644
index 000000000000..aa9cb3420760
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_phy_marvell.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_PHY_MARVELL_H_INCLUDED
+#define SEL_PHY_MARVELL_H_INCLUDED
+
+#include "sel_phy.h"
+
+struct sel_generic_phy *sel_get_marvell_phy_def(void);
+
+#endif /* SEL_PHY_MARVELL_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/sel_phy_ti.c b/drivers/net/ethernet/sel/sel_phy_ti.c
new file mode 100644
index 000000000000..da4acdc1e063
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_phy_ti.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2023 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/mii.h>
+#include <linux/types.h>
+
+#include "hw_interface.h"
+#include "mii_interface.h"
+#include "pci_mac_hw_regs.h"
+#include "sel_phy_ti.h"
+
+/* Advertisement Control Register (04h) bit definitions */
+#define SELECT_802_3	BIT(0)
+
+/* PHY_CONTROL Register and bit definitions */
+#define TI_PHY_CONTROL_REGISTER				0x10
+#define PHY_CONTROL_DEFAULT 0x5048
+
+/* GEN_CFG4 Register and bit definitions */
+#define TI_PHY_GEN_CFG4_REGISTER			0x1E
+#define INT_OE	BIT(7)
+
+/* GEN_CTRL Register and bit definitions */
+#define TI_PHY_GEN_CTRL_REGISTER			0x1F
+#define SW_RESTART	BIT(14)
+
+/* RXF_CFG Register and bit definitions */
+#define TI_PHY_RXF_CFG_REGISTER 0x134
+#define ENHANCED_MAC_SUPPORT BIT(7)
+
+/* IO_MUX_CFG Register and bit definitions */
+#define TI_PHY_IO_MUX_CFG_REGISTER 0x170
+#define MAC_IMPEDANCE_CTRL 0x08
+
+/* OPERATION_MODE Register and bit definitions */
+#define TI_PHY_OP_MODE_DECODE_REGISTER		0x1DF
+#define SGMII_TO_RGMII	BIT(6)
+#define RGMII_TO_COPPER	0x0
+#define RGMII_TO_1000FX	0x1
+#define RGMII_TO_100FX	0x2
+#define RGMII_TO_SGMII	0x3
+
+/* GPIO_MUX_CTRL Register and bit definitions */
+#define TI_PHY_GPIO_MUX_CTRL_REGISTER		0x1E0
+#define GPIO_1_CTRL_OFFSET	4
+#define GPIO_0_CTRL_OFFSET	0
+#define TX_SFD_OUTPUT	0x5
+#define RX_SFD_OUTPUT	0x6
+
+/* FX_CTRL Register and bit definitions */
+#define TI_PHY_FX_CTRL_REGISTER				0xC00
+#define CTRL0_SPEED_SEL_100		BIT(13)
+#define CTRL0_ANEG_EN			BIT(12)
+#define CTRL0_RESTART_AN		BIT(9)
+#define CTRL0_DUPLEX_FULL		BIT(8)
+#define CTRL0_SPEED_SEL_1000	BIT(6)
+
+/* FX_INT_EN Register and bit definitions */
+#define TI_PHY_FX_INT_EN_REGISTER			0xC18
+#define FEF_FAULT_EN	BIT(9)
+
+/* ------------------------------------------
+ * For extended address space access use the REGCR (Dh) and ADDAR (Eh)
+ * registers. See section 9.4.9.1 of the TI DP83869HM spec sheet
+ * for more complete details.
+ *
+ * ex:
+ * Read Operation Using Indirect Register Access
+ * Read 170h
+ * 1. Write value 0x1F to register Dh
+ * 2. Write value 0x170 to register Eh
+ * 3. Write value 0x401F to register Dh
+ * 4. Read register Eh
+ * Expected result: default value 0xC10
+ *
+ * Write Operation Using Indirect Register Access
+ * Write value 0x0C50 to register 170h
+ * 1. Write value 0x1F to register Dh
+ * 2. Write value 0x170 to register Eh
+ * 3. Write value 0x401F to register Dh
+ * 4. Write value 0xC50 to Eh
+ * Expected result: Disables the output clock on the CLK_OUT pin
+ */
+
+/**
+ * sel_mii_read_extended_register() - Reads an extended register
+ *
+ * @hw_mac:          MAC base address
+ * @phy:             phy address
+ * @reg: the register to access
+ */
+static u16 sel_mii_read_extended_register(struct sel_pci_mac_registers *hw_mac,
+					  int phy,
+					  u16 reg)
+{
+	u16 val;
+
+	/* Indicate operation in extended range */
+	sel_mii_write(hw_mac, phy, MII_MMD_CTRL, MII_MMD_CTRL_DEVAD_MASK);
+
+	/* Write extended address */
+	sel_mii_write(hw_mac, phy, MII_MMD_DATA, reg);
+
+	/* Choose to read without an increment */
+	sel_mii_write(hw_mac,
+		      phy,
+		      MII_MMD_CTRL,
+		      MII_MMD_CTRL_NOINCR | MII_MMD_CTRL_DEVAD_MASK);
+
+	/* Read the value */
+	val = sel_mii_read(hw_mac, phy, MII_MMD_DATA);
+
+	return val;
+}
+
+/**
+ * sel_mii_write_extended_register() - Writes an extended register
+ *
+ * @hw_mac:          MAC base address
+ * @phy:             phy address
+ * @reg: the register to access
+ * @value:    the value to write
+ */
+static void sel_mii_write_extended_register(struct sel_pci_mac_registers *hw_mac,
+					    int phy,
+					    u16 reg,
+					    u16 value)
+{
+	/* Indicate operation in extended range */
+	sel_mii_write(hw_mac, phy, MII_MMD_CTRL, MII_MMD_CTRL_DEVAD_MASK);
+
+	/* Write extended address */
+	sel_mii_write(hw_mac, phy, MII_MMD_DATA, reg);
+
+	/* Choose to write without an increment */
+	sel_mii_write(hw_mac,
+		      phy,
+		      MII_MMD_CTRL,
+		      MII_MMD_CTRL_NOINCR | MII_MMD_CTRL_DEVAD_MASK);
+
+	/* Write the value */
+	sel_mii_write(hw_mac, phy, MII_MMD_DATA, value);
+}
+
+/**
+ * sel_phy_ti_reset() - Reset the PHY to a known state
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ *
+ * The PHY required settings are reset here as well.
+ *
+ * Return: 0 if successful, otherwise negative error code
+ */
+static int sel_phy_ti_reset(struct sel_pci_mac_registers *hw_mac, int phy)
+{
+	u8 timeout = 0;
+	int err = 0;
+
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, BMCR_RESET, 0);
+
+	while ((sel_mii_read(hw_mac, phy, MII_BMCR) & BMCR_RESET) != 0) {
+		if (timeout >= SEL_RESET_WAIT_RETRIES) {
+			err = -EIO;
+			break;
+		}
+
+		timeout++;
+
+		udelay(10);
+	};
+
+	return err;
+}
+
+/**
+ * sel_phy_ti_setup() - Set required settings in a PHY
+ *
+ * @hw_mac:          MAC base address
+ * @phy:             phy address
+ *
+ */
+static void sel_phy_ti_setup(struct sel_pci_mac_registers *hw_mac, int phy)
+{
+	/* Enable Tx and Rx SFD Outputs */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_GPIO_MUX_CTRL_REGISTER,
+					(TX_SFD_OUTPUT << GPIO_1_CTRL_OFFSET) |
+						(RX_SFD_OUTPUT << GPIO_0_CTRL_OFFSET));
+
+	/* Enable Enhanced RX capabilities to allow output of the SFD */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_RXF_CFG_REGISTER,
+					MAC_IMPEDANCE_CTRL);
+
+	/* Enable FEF Interrupt only */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_FX_INT_EN_REGISTER,
+					FEF_FAULT_EN);
+
+	/* Enable Interrupt Output pin */
+	sel_mii_read_mod_write(hw_mac,
+			       phy,
+			       TI_PHY_GEN_CFG4_REGISTER,
+			       INT_OE,
+			       0);
+
+	/* Change RGMII impedance for signal integrity */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_IO_MUX_CFG_REGISTER,
+					MAC_IMPEDANCE_CTRL);
+
+	/* We don't support 1Gbps Half Duplex, so don't advertise it */
+	sel_mii_read_mod_write(hw_mac,
+			       phy,
+			       MII_CTRL1000,
+			       0,
+			       ADVERTISE_1000HALF); /* clear */
+
+	 /* Set Operation Mode as RGMII to copper by default */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_OP_MODE_DECODE_REGISTER,
+					SGMII_TO_RGMII);
+
+	/* Default BMCR */
+	sel_mii_write(hw_mac,
+		      phy,
+		      MII_BMCR,
+		      (BMCR_ANENABLE | BMCR_FULLDPLX | BMCR_SPEED1000));
+
+	/* Advertise 100Base-TX and 10Base-T */
+	sel_mii_write(hw_mac,
+		      phy,
+		      MII_ADVERTISE,
+		      ADVERTISE_ALL | SELECT_802_3);
+
+	/* Advertise 1000Base-T Full Duplex */
+	sel_mii_write(hw_mac,
+		      phy,
+		      MII_CTRL1000,
+		      ADVERTISE_1000FULL);
+
+	/* Auto-MDIX */
+	sel_mii_write(hw_mac,
+		      phy,
+		      TI_PHY_CONTROL_REGISTER,
+		      PHY_CONTROL_DEFAULT);
+
+	/* Software Reset */
+	sel_mii_write(hw_mac,
+		      phy,
+		      TI_PHY_GEN_CTRL_REGISTER,
+		      SW_RESTART);
+}
+
+/**
+ * sel_phy_ti_set_speed_100()
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_ti_set_speed_100(struct sel_pci_mac_registers *hw_mac,
+				     int phy)
+{
+	/* Set Operation Mode as RGMII to 100Base-FX */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_OP_MODE_DECODE_REGISTER,
+					SGMII_TO_RGMII | RGMII_TO_100FX);
+
+	/* Set speed to 100Mbps */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_FX_CTRL_REGISTER,
+					CTRL0_SPEED_SEL_100 | CTRL0_DUPLEX_FULL);
+
+	/* Software Reset */
+	sel_mii_write(hw_mac, phy, TI_PHY_GEN_CTRL_REGISTER, SW_RESTART);
+}
+
+/**
+ * sel_phy_ti_set_speed_1000()
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_ti_set_speed_1000(struct sel_pci_mac_registers *hw_mac,
+				      int phy)
+{
+	/* Set Operation Mode as RGMII to 1000Base-FX */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_OP_MODE_DECODE_REGISTER,
+					SGMII_TO_RGMII | RGMII_TO_1000FX);
+
+	/* Reset FX_CTRL */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_FX_CTRL_REGISTER,
+					CTRL0_SPEED_SEL_1000 | CTRL0_DUPLEX_FULL);
+
+	/* Software Reset */
+	sel_mii_write(hw_mac,
+		      phy,
+		      TI_PHY_GEN_CTRL_REGISTER,
+		      SW_RESTART);
+}
+
+/**
+ * sel_phy_ti_set_sgmii_mode() - Sets the mode to sgmii
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_ti_set_sgmii_mode(struct sel_pci_mac_registers *hw_mac,
+				      int phy)
+{
+	/* Set Operation Mode as RGMII to SGMII */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_OP_MODE_DECODE_REGISTER,
+					SGMII_TO_RGMII | RGMII_TO_SGMII);
+
+	/* Reset FX_CTRL */
+	sel_mii_write_extended_register(hw_mac,
+					phy,
+					TI_PHY_FX_CTRL_REGISTER,
+					CTRL0_SPEED_SEL_1000 | CTRL0_DUPLEX_FULL | CTRL0_ANEG_EN);
+
+	/* Software Reset */
+	sel_mii_write(hw_mac, phy, TI_PHY_GEN_CTRL_REGISTER, SW_RESTART);
+}
+
+/**
+ * sel_phy_ti_power_down() - Power down a PHY
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_ti_power_down(struct sel_pci_mac_registers *hw_mac,
+				  int phy)
+{
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, BMCR_PDOWN, 0);
+}
+
+/**
+ * sel_phy_ti_power_up() - Power up a PHY
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_ti_power_up(struct sel_pci_mac_registers *hw_mac,
+				int phy)
+{
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, 0, BMCR_PDOWN);
+}
+
+/**
+ * sel_phy_ti_linkdown_poll() - poll during linkdown
+ *
+ * There is an errata for the device that mentions a case in
+ * 1000BASE-X mode where a restart of autonegotiation may
+ * need to happen to get a link event.
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_phy_ti_linkdown_poll(struct sel_pci_mac_registers *hw_mac,
+				     int phy)
+{
+	u16 val;
+
+	val = sel_mii_read_extended_register(hw_mac,
+					     phy,
+					     TI_PHY_OP_MODE_DECODE_REGISTER);
+
+	/* If we are in 1000Base-X mode, poke restart ANEG */
+	if (val & RGMII_TO_1000FX) {
+		sel_mii_write_extended_register(hw_mac,
+						phy,
+						TI_PHY_FX_CTRL_REGISTER,
+						CTRL0_SPEED_SEL_1000 |
+							CTRL0_DUPLEX_FULL |
+							CTRL0_ANEG_EN |
+							CTRL0_RESTART_AN);
+	}
+}
+
+static struct sel_generic_phy ti_generic_phy = {
+	.sel_phy_reset = sel_phy_ti_reset,
+	.sel_phy_setup = sel_phy_ti_setup,
+	.sel_phy_set_rgmii_100_base_fx_mode = sel_phy_ti_set_speed_100,
+	.sel_phy_clear_rgmii_100_base_fx_mode = sel_phy_ti_set_speed_1000,
+	.sel_phy_set_sgmii = sel_phy_ti_set_sgmii_mode,
+	.sel_phy_power_down = sel_phy_ti_power_down,
+	.sel_phy_power_up = sel_phy_ti_power_up,
+	.sel_phy_linkdown_poll = sel_phy_ti_linkdown_poll,
+};
+
+/**
+ * sel_get_ti_phy_def() - Retrieve TI phy definition
+ *
+ * Return: Pointer to ti_phy definitions struct
+ */
+struct sel_generic_phy *sel_get_ti_phy_def(void)
+{
+	return &ti_generic_phy;
+}
diff --git a/drivers/net/ethernet/sel/sel_phy_ti.h b/drivers/net/ethernet/sel/sel_phy_ti.h
new file mode 100644
index 000000000000..73357b52c608
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_phy_ti.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2023 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+#ifndef SEL_PHY_TI_H_INCLUDED
+#define SEL_PHY_TI_H_INCLUDED
+
+#include "sel_phy.h"
+
+struct sel_generic_phy *sel_get_ti_phy_def(void);
+
+#endif /* SEL_PHY_TI_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/sel_soft_phy.c b/drivers/net/ethernet/sel/sel_soft_phy.c
new file mode 100644
index 000000000000..4e4b94de2d18
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_soft_phy.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2023 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include "hw_interface.h"
+#include "mii_interface.h"
+#include "pci_mac_hw_regs.h"
+#include "sel_soft_phy.h"
+
+/**
+ * sel_noop_no_return() - Ignore a phy request without a return
+ */
+static void sel_noop_no_return(struct sel_pci_mac_registers *hw_mac, int phy)
+{
+	(void)hw_mac;
+	(void)phy;
+}
+
+/**
+ * sel_soft_phy_reset() - Reset the PHY to a known state
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ *
+ * The PHY required settings are reset here as well.
+ *
+ * Return: 0 if successful, otherwise negative error code
+ */
+static int sel_soft_phy_reset(struct sel_pci_mac_registers *hw_mac, int phy)
+{
+	u8 timeout = 0;
+	int err = 0;
+
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, BMCR_RESET, 0);
+
+	while ((sel_mii_read(hw_mac, phy, MII_BMCR) & BMCR_RESET) != 0) {
+		if (timeout >= SEL_RESET_WAIT_RETRIES) {
+			err = -EIO;
+			break;
+		}
+
+		timeout++;
+
+		udelay(10);
+	};
+
+	return err;
+}
+
+/**
+ * sel_soft_phy_power_down() - Power down a PHY
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_soft_phy_power_down(struct sel_pci_mac_registers *hw_mac,
+				    int phy)
+{
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, BMCR_PDOWN, 0);
+}
+
+/**
+ * sel_soft_phy_power_up() - Power up a PHY
+ *
+ * @hw_mac:    MAC base address
+ * @phy:       phy address
+ */
+static void sel_soft_phy_power_up(struct sel_pci_mac_registers *hw_mac,
+				  int phy)
+{
+	sel_mii_read_mod_write(hw_mac, phy, MII_BMCR, 0, BMCR_PDOWN);
+}
+
+struct sel_generic_phy sel_soft_phy = {
+	.sel_phy_reset = sel_soft_phy_reset,
+	.sel_phy_setup = sel_noop_no_return,
+	.sel_phy_set_rgmii_100_base_fx_mode = sel_noop_no_return,
+	.sel_phy_clear_rgmii_100_base_fx_mode = sel_noop_no_return,
+	.sel_phy_set_sgmii = sel_noop_no_return,
+	.sel_phy_power_down = sel_soft_phy_power_down,
+	.sel_phy_power_up = sel_soft_phy_power_up,
+};
+
+/**
+ * sel_get_soft_phy_def() - Retrieve the sel soft phy definition
+ *
+ * Return: Pointer to sel_soft_phy definitions struct
+ */
+struct sel_generic_phy *sel_get_soft_phy_def(void)
+{
+	return &sel_soft_phy;
+}
diff --git a/drivers/net/ethernet/sel/sel_soft_phy.h b/drivers/net/ethernet/sel/sel_soft_phy.h
new file mode 100644
index 000000000000..e63f971fd211
--- /dev/null
+++ b/drivers/net/ethernet/sel/sel_soft_phy.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only */
+/*
+ * Copyright 2023 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_SOFT_PHY_H_INCLUDED
+#define SEL_SOFT_PHY_H_INCLUDED
+
+#include "sel_phy.h"
+
+struct sel_generic_phy *sel_get_soft_phy_def(void);
+
+#endif /* SEL_SOFT_PHY_H_INCLUDED */
diff --git a/drivers/net/ethernet/sel/semaphore.h b/drivers/net/ethernet/sel/semaphore.h
new file mode 100644
index 000000000000..f5573b4a1e38
--- /dev/null
+++ b/drivers/net/ethernet/sel/semaphore.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2014 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef _SEL_SEMAPHORE_H_
+#define _SEL_SEMAPHORE_H_
+
+/**
+ * sel_semaphore_acquire() - Acquires the requested resource's hw semaphore
+ *
+ * @hw_mac: Mac base address
+ * @resource: enum value of the resource to arbitrate
+ */
+static inline void sel_semaphore_acquire(struct sel_pci_mac_registers *hw_mac,
+					 enum ARB_RESOURCE resource)
+{
+	u32 arb_val;
+	u32 resource_set_mask = 0;
+	u32 resource_grant_mask = 0;
+
+	switch (resource) {
+	case SMI:
+		resource_set_mask = SMI_REQ_SET;
+		resource_grant_mask = SMI_REQ_GRANTED;
+		break;
+	case I2C:
+		resource_set_mask =  I2C_REQ_SET;
+		resource_grant_mask = I2C_REQ_GRANTED;
+		break;
+	case ARB_REQ_2:
+		resource_set_mask =  ARB_REQ_2_SET;
+		resource_grant_mask = ARB_REQ_2_GRANTED;
+		break;
+	case ARB_REQ_3:
+		resource_set_mask =  ARB_REQ_3_SET;
+		resource_grant_mask = ARB_REQ_3_GRANTED;
+		break;
+	default:
+		resource_set_mask =  ARB_REQ_3_SET;
+		resource_grant_mask = ARB_REQ_3_GRANTED;
+		break;
+	}
+
+	iowrite32(resource_set_mask, &hw_mac->mac.arbitration);
+	do {
+		arb_val = ioread32(&hw_mac->mac.arbitration);
+	} while (0 == (arb_val & resource_grant_mask));
+}
+
+/**
+ * sel_semaphore_release() - Releases the semaphore of the requested resource
+ *
+ * @hw_mac: Mac base address
+ * @resource: enum value of the resource to arbitrate
+ */
+static inline void sel_semaphore_release(struct sel_pci_mac_registers *hw_mac,
+					 enum ARB_RESOURCE resource)
+{
+	u32 resource_clear_mask = 0;
+
+	switch (resource) {
+	case SMI:
+		resource_clear_mask = SMI_REQ_CLEAR;
+		break;
+	case I2C:
+		resource_clear_mask = I2C_REQ_CLEAR;
+		break;
+	case ARB_REQ_2:
+		resource_clear_mask = ARB_REQ_2_CLEAR;
+		break;
+	case ARB_REQ_3:
+		resource_clear_mask = ARB_REQ_3_CLEAR;
+		break;
+	default:
+		resource_clear_mask = ARB_REQ_3_CLEAR;
+		break;
+	}
+
+	iowrite32(resource_clear_mask, &hw_mac->mac.arbitration);
+}
+
+#endif /* _SEL_SEMAPHORE_H_ */
diff --git a/drivers/net/ethernet/sel/sfp.c b/drivers/net/ethernet/sel/sfp.c
new file mode 100644
index 000000000000..9ab587e9f550
--- /dev/null
+++ b/drivers/net/ethernet/sel/sfp.c
@@ -0,0 +1,615 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/types.h>
+
+#include "sel_phy.h"
+#include "sfp.h"
+#include "semaphore.h"
+
+#define SEL_SFP_ID		0x3138u
+#define SEL_SFP_ID_MASK		0xFFFFu
+#define SEL_SFP_TYPE_MASK	0xFFu
+
+#define SFP_I2C_SLAVE_ADDRESS_BASE 0x50
+
+#define SFP_ID_LENGTH_SMF_KM  0x0E
+#define SFP_ID_LENGTH_SMF_M  0x0F
+#define SFP_ID_LENGTH_OM2  0x10
+#define SFP_ID_LENGTH_OM1  0x11
+#define SFP_ID_LENGTH_COPPER  0x12
+#define SFP_ID_LENGTH_OM3  0x13
+#define SFP_ID_VENDOR_NAME  0x14
+#define SFP_ID_PART_NUM  0x28
+#define SFP_ID_REV_NUM  0x38
+#define SFP_ID_WAVELENGTH  0x3C
+#define SFP_ID_SER_NUM  0x44
+#define SFP_ID_DATECODE  0x54
+#define SFP_ID_DIAG_MONITORING  0x5C
+#define SFP_ID_DIAG_IMPLEMENTED  0x40
+#define SFP_ID_DIAG_EXT_CAL  0x10
+
+#define SFP_ID_DIAG_CALIBRATION  0x38
+#define SFP_ID_SEL_PART_NUM  0x80
+#define SFP_ID_SEL_PART_OPTION  0x85
+#define SFP_ID_SEL_SER_NUM  0x91
+
+/**
+ * sfp_read_i2c() - Read an I2C address on the attached SFP.
+ *
+ * @mac: SEL MAC device structure
+ * @chip: Which chip to read from (0 or 1)
+ * @reg: Which chip address to read from (0 - 255)
+ * @size: How many bytes to read (1 - 4)
+ *
+ * This function should not be called with the HW semaphore granted.
+ *
+ * @returns: -EINVAL if one of the input parameters are out of range, else 0.
+ *   The returned data is stored in the supplied buffer.  The buffer must
+ *   be allocated by the caller.
+ */
+static int sfp_read_i2c(struct sel_pci_mac *mac,
+			u8 chip,
+			u8 reg,
+			u8 size,
+			void *buf)
+{
+	u32 i2c_ctrl;
+	u32 i2c_data;
+	int rc = 0;
+
+	if (chip > 1)
+		return -EINVAL;
+	if (size == 0 || size > 4)
+		return -EINVAL;
+	if (!buf)
+		return -EINVAL;
+
+	i2c_ctrl = (SFP_I2C_SLAVE_ADDRESS_BASE + chip)
+		<< SEL_I2C_SLV_ADDR_SHIFT;
+	i2c_ctrl |= reg << SEL_I2C_REG_ADDR_SHIFT;
+	i2c_ctrl |= size << SEL_I2C_TRANS_LEN_SHIFT;
+	i2c_ctrl |= SEL_I2C_DIRECTION_READ;
+	i2c_ctrl |= SEL_I2C_START;
+
+	sel_semaphore_acquire(mac->hw_mac, I2C);
+	iowrite32(i2c_ctrl, &mac->hw_mac->i2c.i2c_control);
+
+	/* Device is busy with the transaction until START clears. A
+	 * read of all 1's indicates a PCI error.
+	 */
+	do {
+		i2c_ctrl = ioread32(&mac->hw_mac->i2c.i2c_control);
+		if (i2c_ctrl == (0xFFFFFFFF)) {
+			rc = -ENODEV;
+			goto exit;
+		}
+	} while ((i2c_ctrl & SEL_I2C_START) != 0);
+
+	if ((i2c_ctrl & SEL_I2C_CTRL_ERR) != 0) {
+		rc = -EIO;
+		goto exit;
+	}
+
+	i2c_data = ioread32(&mac->hw_mac->i2c.i2c_rd_data);
+	memcpy(buf, &i2c_data, size);
+
+exit:
+	sel_semaphore_release(mac->hw_mac, I2C);
+	return rc;
+}
+
+/**
+ * sfp_read_string() - read a sequence of bytes from the SFP
+ *
+ * @mac: SEL MAC device
+ * @buff: Buffer to fill with data
+ * @len: Number of bytes to read
+ * @chip: Chip number to read from
+ * @offset: Register offset to read
+ *
+ * @returns: 0 if id reads were successful, otherwise an appropriate error.
+ */
+static int sfp_read_string(struct sel_pci_mac *mac,
+			   void *buff,
+			   int len,
+			   u8 chip,
+			   u8 offset)
+{
+	u8 *iter = (u8 *)buff;
+	int rc = 0;
+	int i;
+
+	for (i = 0; (rc == 0) && (i < len); i += 4) {
+		rc = sfp_read_i2c(mac,
+				  chip,
+				  offset + i,
+				  len - i < 4 ? len - i : 4,
+				  iter + i);
+	}
+
+	return rc;
+}
+
+/**
+ * sfp_read_diag() - Read the SFP diagnostics
+ *
+ * @mac: SEL MAC device
+ * @diag: Pointer to a caller allocated diagnostic structure to fill
+ *
+ * @returns: 0 if id reads were successful, otherwise an appropriate error.
+ */
+int sfp_read_diag(struct sel_pci_mac *mac, struct sel_sfp_diag *diag)
+{
+	struct {
+		u32 rx_pwr4;
+		u32 rx_pwr3;
+		u32 rx_pwr2;
+		u32 rx_pwr1;
+		u32 rx_pwr0;
+		u16 tx_i_slope;
+		s16 tx_i_offset;
+		u16 tx_pwr_slope;
+		s16 tx_pwr_offset;
+		u16 t_slope;
+		s16 t_offset;
+		u16 v_slope;
+		s16 v_offset;
+		u32 reserved;
+		s16 temp;
+		u16 vcc;
+		u16 tx_bias;
+		u16 tx_power;
+		u16 rx_power;
+	} __packed sfp_diags;
+	u16 rxpwr_old;
+	u16 temp;
+	u8 caps;
+	int rc;
+
+	/* diagnostics are only available if indicated */
+	rc = sfp_read_i2c(mac, 0, SFP_ID_DIAG_MONITORING, sizeof(caps), &caps);
+	if (rc != 0 || ((caps & SFP_ID_DIAG_IMPLEMENTED) == 0))
+		return -ENODEV;
+
+	rc = sfp_read_string(mac,
+			     &sfp_diags,
+			     sizeof(sfp_diags),
+			     1,
+			     SFP_ID_DIAG_CALIBRATION);
+	if (rc != 0)
+		return -EIO;
+
+	/* everything is big-endian in the eeprom */
+	sfp_diags.rx_pwr4 = be32_to_cpu(sfp_diags.rx_pwr4);
+	sfp_diags.rx_pwr3 = be32_to_cpu(sfp_diags.rx_pwr3);
+	sfp_diags.rx_pwr2 = be32_to_cpu(sfp_diags.rx_pwr2);
+	sfp_diags.rx_pwr1 = be32_to_cpu(sfp_diags.rx_pwr1);
+	sfp_diags.rx_pwr0 = be32_to_cpu(sfp_diags.rx_pwr0);
+	sfp_diags.tx_i_slope = be16_to_cpu(sfp_diags.tx_i_slope);
+	sfp_diags.tx_i_offset = be16_to_cpu(sfp_diags.tx_i_offset);
+	sfp_diags.tx_pwr_slope = be16_to_cpu(sfp_diags.tx_pwr_slope);
+	sfp_diags.tx_pwr_offset = be16_to_cpu(sfp_diags.tx_pwr_offset);
+	sfp_diags.t_slope = be16_to_cpu(sfp_diags.t_slope);
+	sfp_diags.t_offset = be16_to_cpu(sfp_diags.t_offset);
+	sfp_diags.v_slope = be16_to_cpu(sfp_diags.v_slope);
+	sfp_diags.v_offset = be16_to_cpu(sfp_diags.v_offset);
+	sfp_diags.temp = be16_to_cpu(sfp_diags.temp);
+	sfp_diags.vcc = be16_to_cpu(sfp_diags.vcc);
+	sfp_diags.tx_bias = be16_to_cpu(sfp_diags.tx_bias);
+	sfp_diags.tx_power = be16_to_cpu(sfp_diags.tx_power);
+	sfp_diags.rx_power = be16_to_cpu(sfp_diags.rx_power);
+
+	/* calibrate only if the part says to */
+	if ((caps & SFP_ID_DIAG_EXT_CAL) != 0) {
+		sfp_diags.temp = sfp_diags.t_slope * sfp_diags.temp
+			+ sfp_diags.t_offset;
+		sfp_diags.vcc = sfp_diags.v_slope * sfp_diags.vcc
+			+ sfp_diags.v_offset;
+		sfp_diags.tx_bias = sfp_diags.tx_i_slope * sfp_diags.tx_bias
+			+ sfp_diags.tx_i_offset;
+		sfp_diags.tx_power =
+			sfp_diags.tx_pwr_slope * sfp_diags.tx_power
+				+ sfp_diags.tx_pwr_offset;
+
+		/* rx power is more complicated.
+		 * Each multiplication below must be truncated to 16-bits
+		 * before addition.
+		 *
+		 * rx_pwr4 * rx_power^4 +
+		 *    rx_pwr3 * rx_power^3 +
+		 *    rx_pwr2 * rx_power^2 +
+		 *    rx_pwr1 * rx_power +
+		 *    rx_pwr0
+		 */
+		rxpwr_old = sfp_diags.rx_power;
+
+		sfp_diags.rx_power = sfp_diags.rx_pwr0;
+
+		temp = rxpwr_old;
+		sfp_diags.rx_power += (u16)(sfp_diags.rx_pwr1 * temp);
+		temp *= rxpwr_old;
+		sfp_diags.rx_power += (u16)(sfp_diags.rx_pwr2 * temp);
+		temp *= rxpwr_old;
+		sfp_diags.rx_power += (u16)(sfp_diags.rx_pwr3 * temp);
+		temp *= rxpwr_old;
+		sfp_diags.rx_power += (u16)(sfp_diags.rx_pwr4 * temp);
+	}
+
+	/* scale before returning */
+	diag->temp = (s32)sfp_diags.temp / 256; /* deg C */
+	diag->vcc = sfp_diags.vcc * 100; /* uV */
+	diag->tx_bias = sfp_diags.tx_bias * 2; /* uA */
+	diag->tx_power = sfp_diags.tx_power * 100; /* nW */
+	diag->rx_power = sfp_diags.rx_power * 100; /* nW */
+
+	return 0;
+}
+
+/**
+ * sfp_read_id() - Read the ID strings
+ *
+ * @mac: SEL MAC device
+ * @id: Pointer to a caller allocated ID structure to fill
+ *
+ * @returns: 0 if id reads were successful, otherwise an appropriate error.
+ */
+int sfp_read_id(struct sel_pci_mac *mac, struct sel_sfp_id *id)
+{
+	int rc = 0;
+
+	memset(id, 0, sizeof(*id));
+
+	rc = sfp_read_string(mac,
+			     id->name,
+			     sizeof(id->name),
+			     0,
+			     SFP_ID_VENDOR_NAME);
+
+	if (rc == 0) {
+		rc = sfp_read_string(mac,
+				     id->part,
+				     sizeof(id->part),
+				     0,
+				     SFP_ID_PART_NUM);
+	}
+	if (rc == 0) {
+		rc = sfp_read_string(mac,
+				     id->rev,
+				     sizeof(id->rev),
+				     0,
+				     SFP_ID_REV_NUM);
+	}
+	if (rc == 0) {
+		rc = sfp_read_string(mac,
+				     id->sernum,
+				     sizeof(id->sernum),
+				     0,
+				     SFP_ID_SER_NUM);
+	}
+	if (rc == 0) {
+		rc = sfp_read_string(mac,
+				     id->datecode,
+				     sizeof(id->datecode),
+				     0,
+				     SFP_ID_DATECODE);
+	}
+	if (rc == 0) {
+		rc = sfp_read_i2c(mac,
+				  0,
+				  SFP_ID_WAVELENGTH,
+				  sizeof(id->wavelength),
+				  &id->wavelength);
+		id->wavelength = be16_to_cpu(id->wavelength);
+	}
+
+	/* Lengths are represented as single byte in the part with
+	 * various units. We want to normalize everything to meters.
+	 */
+	if (rc == 0) {
+		rc = sfp_read_i2c(mac,
+				  0,
+				  SFP_ID_LENGTH_SMF_KM,
+				  1,
+				  &id->length_smf_km);
+		id->length_smf_km *= 1000; /* Original units are km */
+	}
+	if (rc == 0) {
+		rc = sfp_read_i2c(mac,
+				  0,
+				  SFP_ID_LENGTH_SMF_M,
+				  1,
+				  &id->length_smf_m);
+		id->length_smf_m *= 100; /* Original units are 100 meters */
+	}
+	if (rc == 0) {
+		rc = sfp_read_i2c(mac,
+				  0,
+				  SFP_ID_LENGTH_OM2,
+				  1,
+				  &id->length_om2);
+		id->length_om2 *= 10; /* Original units are 10 meters */
+	}
+	if (rc == 0) {
+		rc = sfp_read_i2c(mac,
+				  0,
+				  SFP_ID_LENGTH_OM1,
+				  1,
+				  &id->length_om1);
+		id->length_om1 *= 10; /* Original units are 10 meters */
+	}
+	if (rc == 0) {
+		rc = sfp_read_i2c(mac,
+				  0,
+				  SFP_ID_LENGTH_COPPER,
+				  1,
+				  &id->length_copper);
+	}
+	if (rc == 0) {
+		rc = sfp_read_i2c(mac,
+				  0,
+				  SFP_ID_LENGTH_OM3,
+				  1,
+				  &id->length_om3);
+		id->length_om3 *= 10; /* Original units are 10 meters */
+	}
+
+	/* SEL parts have "81" as the start of the part number */
+	if (rc == 0) {
+		rc = sfp_read_string(mac,
+				     id->sel_part,
+				     sizeof(id->sel_part),
+				     1,
+				     SFP_ID_SEL_PART_NUM);
+	}
+	if ((id->sel_part[0] == '8') && (id->sel_part[1] == '1')) {
+		if (rc == 0) {
+			rc = sfp_read_string(mac,
+					     id->sel_part_option,
+					     sizeof(id->sel_part_option),
+					     1,
+					     SFP_ID_SEL_PART_OPTION);
+		}
+		if (rc == 0) {
+			rc = sfp_read_string(mac,
+					     id->sel_sn,
+					     sizeof(id->sel_sn),
+					     1,
+					     SFP_ID_SEL_SER_NUM);
+		}
+	} else {
+		/* Not an SEL part so remove the ID we read*/
+		memset(&id->sel_part, 0, sizeof(id->sel_part));
+	}
+
+	return rc;
+}
+
+/**
+ * sfp_enable() - Enable an attached SFP
+ *
+ * @mac: MAC instance to enable
+ */
+static void sfp_enable(struct sel_pci_mac *mac)
+{
+	/* The phy will autodetect sgmii and serdes modes */
+	mac->generic_phy->sel_phy_power_up(mac->hw_mac, mac->mii_if.phy_id);
+	switch (mac->sfp_type & 0xFF) {
+	case E1000_SERDES:
+		mac->generic_phy->sel_phy_clear_rgmii_100_base_fx_mode(mac->hw_mac,
+								       mac->mii_if.phy_id);
+		netdev_info(mac->netdev, "Port: %d SFP initialized to E1000\n",
+			    mac->port_num);
+		break;
+
+	case E100_SERDES:
+		mac->generic_phy->sel_phy_set_rgmii_100_base_fx_mode(mac->hw_mac,
+								     mac->mii_if.phy_id);
+		netdev_info(mac->netdev, "Port: %d SFP initialized to E100\n",
+			    mac->port_num);
+		break;
+
+	case E100_SGMII:
+	case E1000_SGMII:
+		mac->generic_phy->sel_phy_set_sgmii(mac->hw_mac, mac->mii_if.phy_id);
+		netdev_info(mac->netdev, "Port: %d SFP initialized to SGMII\n",
+			    mac->port_num);
+		break;
+	default:
+		netdev_info(mac->netdev, "Port: %d - Unexpected SFP type\n",
+			    mac->port_num);
+		break;
+	}
+
+	/* Normally we would do a read/modify/write here, but since all
+	 * of the non reset bits are read only, we can just write a 1 to
+	 * the SFP_ENABLE bit.
+	 */
+	iowrite32(MACSTAT_SFP_ENABLE, &mac->hw_mac->mac.macstat);
+}
+
+/**
+ * sfp_disable() - Disable an attached SFP
+ *
+ * @mac: MAC instance to disable.
+ */
+static void sfp_disable(struct sel_pci_mac *mac)
+{
+	mac->generic_phy->sel_phy_power_down(mac->hw_mac,
+					     mac->mii_if.phy_id);
+	/* Normally we would do a read/modify/write here, but since all
+	 * of the non reset bits are read only, we can just write a 0 to
+	 * a 0 to the SFP_ENABLE bit.
+	 */
+	iowrite32(0, &mac->hw_mac->mac.macstat);
+}
+
+/**
+ * is_sel_sfp() - Determines if the SFP came from SEL
+ *
+ * @mac: MAC instance to disable.
+ *
+ * @returns: True if SFP is from SEL, false if not, or error
+ */
+static bool is_sel_sfp(struct sel_pci_mac *mac)
+{
+	unsigned long const max_attempts = 15;
+	unsigned long wait_more = 0;
+	unsigned long attempts = 0;
+	bool is_sel_sfp = false;
+	u32 part_num = 0;
+	int rc;
+
+	while (sfp_present(mac) && !is_sel_sfp && (attempts < max_attempts)) {
+		rc = sfp_read_i2c(mac, 1, 0x80, sizeof(part_num), &part_num);
+		if (rc == 0 && ((part_num & SEL_SFP_ID_MASK) == SEL_SFP_ID))
+			is_sel_sfp = true;
+
+		wait_more = attempts * 10000;
+		usleep_range(wait_more, wait_more + 10000);
+		attempts++;
+	}
+
+	if (!is_sel_sfp) {
+		netdev_info(mac->netdev, "Port: %d - Invalid SFP Part: 0x%x\n",
+			    mac->port_num, (part_num & SEL_SFP_ID_MASK));
+	}
+
+	return is_sel_sfp;
+}
+
+/**
+ * get_sfp_type() - Queries the type filed from the SFP eeprom
+ *
+ * @mac: MAC instance to disable.
+ *
+ * @returns: The numeric type of the SFP inserted, 0 on error
+ */
+static u8 get_sfp_type(struct sel_pci_mac *mac)
+{
+	u32 type_field = 0;
+	int rc;
+
+	rc = sfp_read_i2c(mac, 1, 0x84, sizeof(type_field), &type_field);
+	if (rc != 0) {
+		netdev_info(mac->netdev, "Port: %d - Cannot read SFP part type!\n",
+			    mac->port_num);
+		return 0;
+	}
+
+	return type_field & SEL_SFP_TYPE_MASK;
+}
+
+/**
+ * _sfp_update() - Update the current state of any connected SFP.
+ *
+ * @work: work queue struct to use for grabbing private data
+ *        for earlier kernels
+ * @data: private data for this driver
+ *
+ * This function takes the hardware semaphore because the SFP registers
+ * are shared with all ports on the device. This can take some time to
+ * acquire so we can't do that in any interrupt context.
+ */
+static void _sfp_update(struct work_struct *work)
+{
+	struct sel_pci_mac *mac = container_of(work,
+					       struct sel_pci_mac,
+					       sfp_task);
+	bool enable = false;
+
+	/* no work to do if no sfp is present */
+	if (!sfp_present(mac)) {
+		netdev_info(mac->netdev, "Port: %d No SFP present\n", mac->port_num);
+		return;
+	}
+
+	switch (mac->sfp_configuration) {
+	case SFP_AUTO:
+		/* In auto mode, only enable the SFP for SEL part numbers */
+		mac->sfp_type = 0xFF;
+		if (is_sel_sfp(mac)) {
+			/* All SFP's have a type field which corresponds
+			 * to an interface type and speed. Get that here
+			 * and save to use in sfp_enable.
+			 */
+			mac->sfp_type = get_sfp_type(mac);
+			switch (mac->sfp_type) {
+			case E1000_SERDES:
+			case E100_SERDES:
+			case E100_SGMII:
+			case E1000_SGMII:
+				enable = true;
+				break;
+			default:
+				break;
+			}
+		}
+		break;
+	case SFP_BYPASS_100_SERDES:
+		enable = true;
+		mac->sfp_type = E100_SERDES;
+		break;
+	case SFP_BYPASS_1000_SERDES:
+		enable = true;
+		mac->sfp_type = E1000_SERDES;
+		break;
+	case SFP_BYPASS_100_SGMII:
+		enable = true;
+		mac->sfp_type = E100_SGMII;
+		break;
+	case SFP_BYPASS_1000_SGMII:
+		enable = true;
+		mac->sfp_type = E1000_SGMII;
+		break;
+	default:
+		break;
+	}
+
+	if (enable)
+		sfp_enable(mac);
+	else
+		sfp_disable(mac);
+}
+
+/**
+ * sfp_update() - Start a work item to update the SFP state for this port
+ *
+ * @mac: sel_pci_mac device to update
+ */
+void sfp_update(struct sel_pci_mac *mac)
+{
+	/* Only configure sfp if it is enabled */
+	if (mac->sfp_enabled)
+		schedule_work(&mac->sfp_task);
+}
+
+/**
+ * sfp_init() - Initialize the SFP subsystem
+ *
+ * @mac: sel_pci_mac device to initialize
+ */
+void sfp_init(struct sel_pci_mac *mac)
+{
+	INIT_WORK(&mac->sfp_task, _sfp_update);
+	mac->sfp_enabled = true;
+}
+
+/**
+ * sfp_exit() - Disable the SFP device and cleanup any resources it used
+ *
+ * @mac: sel_pci_mac device to cleanup
+ */
+void sfp_exit(struct sel_pci_mac *mac)
+{
+	if (mac->sfp_enabled) {
+		mac->sfp_enabled = false;
+		cancel_work_sync(&mac->sfp_task);
+		sfp_disable(mac);
+	}
+}
diff --git a/drivers/net/ethernet/sel/sfp.h b/drivers/net/ethernet/sel/sfp.h
new file mode 100644
index 000000000000..e056eb265a9d
--- /dev/null
+++ b/drivers/net/ethernet/sel/sfp.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2019 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef SEL_SFP_H_INCLUDED
+#define SEL_SFP_H_INCLUDED
+
+#include "pci_mac.h"
+#include "pci_mac_hw_regs.h"
+
+struct sel_sfp_id {
+	char name[16];
+	char part[16];
+	char rev[4];
+	char sernum[16];
+	char datecode[8];
+	u16 wavelength;
+	u32 length_smf_km;
+	u32 length_smf_m;
+	u32 length_om2;
+	u32 length_om1;
+	u32 length_copper;
+	u32 length_om3;
+
+	char sel_part[4];
+	char sel_part_option[2];
+	char sel_sn[15];
+};
+
+struct sel_sfp_diag {
+	s32 temp;
+	u32 vcc;
+	u32 tx_bias;
+	u32 tx_power;
+	u32 rx_power;
+};
+
+int sfp_read_diag(struct sel_pci_mac *mac, struct sel_sfp_diag *diag);
+int sfp_read_id(struct sel_pci_mac *mac, struct sel_sfp_id *id);
+void sfp_update(struct sel_pci_mac *mac);
+void sfp_init(struct sel_pci_mac *mac);
+void sfp_exit(struct sel_pci_mac *mac);
+
+/**
+ * sfp_present() - Start a work item to update the SFP state for this port
+ *
+ * @mac: MAC instance to check for sfp.
+ *
+ * @returns: True if SFP is inserted, false if not.
+ */
+static inline bool sfp_present(struct sel_pci_mac *mac)
+{
+	u32 macstat = ioread32(&mac->hw_mac->mac.macstat);
+
+	return ((macstat & MACSTAT_SFP_DETECT) != 0) ? true : false;
+}
+
+#endif /* SEL_SFP_H_INCLUDED */
-- 
2.45.2


