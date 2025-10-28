Return-Path: <netdev+bounces-233455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A33C13960
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88538467114
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC02236FA;
	Tue, 28 Oct 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C530310Y"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87E15DBC1
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641075; cv=fail; b=MLVQuuOZmgHtSRjvVS2F9DaqzEz6Pw/ck3jBEOz7s97XXQo8VqqRvkuShps5CjMiey3xjOlisIbizTu8DylzSr1RrNcfP3b1r7FNX23da9EvTBB4qUUZsZz0/nHOzA5tMHJDJ+m1zNNcKQoEsoia2Czjqq5GAfqEgGveXnfE6LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641075; c=relaxed/simple;
	bh=xP7+2FAFX5rGh6vWdPoiv69iLDEi5nD46gFg4BV3+Nc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKGTWuD4IxzQpQ5n/fSlZelpqxIVpzorPKMBqDSKcrq5iset7N0Iu44hv3uuCORNh8t3yAywL2iwtjItHp57OxjpGZZlRpZRXC12SUeAuWIgWGHEzs4iTQVhXRXI6Q+fDgCmQHJ9qDUwDFz5TRfF35OE5Gk/9IFFZnDGN+DZGGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C530310Y; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhB6Wy4gz7iJa9AmrIIK+V+2w/E9SKIs//w4PRBJglp/OeZ5mLqNXGoBZJ/68KGvbTGM9BP4zFOLFZ+Q0rE10na0qGfPmzTSUbjjLriCR0pzyP8dB2CZEMGO7Z1lNY35nGinVs6j5marVikUiBJpxZl3zAaNBvGRJScmHSKl+8yxtAy2LnIkCUGxC6Rqa0K789DznBFB2lQ1U+TzvTpM7l8A1RpTjWpjKQR2xGtRi/vQGblr56HMVpm5brbZWXXc4MYg52h5eSRH7olwz8Iyt5fAQp9xTEaiqbd0gsbkxRMPsIhb35mOAnh0SNNXOn2IVFA6Do7rh7OhZCVaHnXEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8g6tIbYz+ZW3wnX4SXOsJnDxKT1Pca03qCgNadKH6Y=;
 b=sEBq0xmJOKfcWTHSutKY08ThQASzBzoMnzaCDqtlG1cVPbTI4h64bz3yNRTy3H+7YKzM9h5li6VIEZY+VeuRENRqKi/RinQHBTbyOXmZ4EUDtVIy170JfjqH9XkJWouzpGP+ib3rfq36CAnz5iRQVUHaMbZbL21pvwiYFbEBQdcVKLKWgWHh09YDC8GOBL18PSgN3kJdQ/hXEE6UOT0PJUQXqesBvnwj6fNw5wGLiEuJIqOMXid8I3foi+mNdnlL+LOcqCjTJXJ/GRb6pYvJFSYwPi7pAPrwdXSo01fbEPmMInXUB1f7DvxtEhAZ9ISey/d/4KzZzMKI1BbnYETJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8g6tIbYz+ZW3wnX4SXOsJnDxKT1Pca03qCgNadKH6Y=;
 b=C530310Yf/QChjtbAqEP/aDRMDhjMqHCWLH1lW1EHKcAp+u8Iide+vIA80GlxM4WbmENsHH67YuzfJ5hulU9gxZNgVRzsvuenq7LSw+ucK1RSEVXPkVlMr7pX3HlHs4qvizQNQUKqyXnSN0ZhS8mFA20lp+BMGjHw7lnXqqTHqE=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 08:44:30 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::6c) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Tue,
 28 Oct 2025 08:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 08:44:30 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 01:44:26 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v4 0/5] amd-xgbe: introduce support for ethtool selftests
Date: Tue, 28 Oct 2025 14:14:04 +0530
Message-ID: <20251028084404.1046722-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 218e795f-3b42-456e-f3fd-08de15fe35cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R1MKBJXdO00ueANaazrZHRxsajT9DqdV0y+Dc9nHMCj/cr/G7tv5DihD3F0+?=
 =?us-ascii?Q?B2Llz5M1mUZXEsZRo0vhU1yCh87xBR8INICLqCQVqLwOb4myfSKpuo2RH3BB?=
 =?us-ascii?Q?U6kZQEWQ5iEzvlyunqq+Ok6Ov+16wiKkKijSNnJYMQQHzTbgu8R595r2oiUH?=
 =?us-ascii?Q?OsvoV7c7IlXrVHccs+3G42TLqom0iD2hMTruUhblNHwMETnjl7yKlesgMdA8?=
 =?us-ascii?Q?o8SDCcG4BNerqUDEsD11L27KiO6jO4QPnY4GQ4wg0Y6Z8eh8/6p7kqriWOjy?=
 =?us-ascii?Q?HArLldMzAPNU17z+WHKpH+A/ZH/8iiKXfsuUj8cehN+Rm7Qla5mx6lWtvtBj?=
 =?us-ascii?Q?sTYVLQmlROI/p5LvAnPnwWvic3Chk6DcozgKyDbP6LL6Bkhqy15DwbelbHRf?=
 =?us-ascii?Q?3M6Y2o4NfLIWkOnDyYPIyfjYNx0szAyTI7Y5fa+hUFIX7hEdKNvMluLbpC25?=
 =?us-ascii?Q?9Go0X4hLKGix3Pcd/k7iwQbYddBJm0y071AIo+bVN+gFhTf1Zl5mZr0jZPPw?=
 =?us-ascii?Q?wFQmxesNb54zHDEDWiGticBLizB0cgoXYGRaM/JGUrihYejP94HayUkbLGav?=
 =?us-ascii?Q?DRr1zhU4B6K29aIfNaz+Ccz5AIMV+IahfBWnNry9wawF3LJbr+NnPoUceTmo?=
 =?us-ascii?Q?cB8n0Dqz75wapL8OcEMYMgUBc7Ko74yajayqLA5q2VY3axOPS4Z/7Y/t9om0?=
 =?us-ascii?Q?YpwpAReLXU/HqXM7vXcQrj24BPi411EB6WsX+ACGwBFs2v+AHH2DNHviiNst?=
 =?us-ascii?Q?RRRgmhegZIqSRe0lXjIYMQUfQyZqf+DJ14VhnZQOxEvtkYWtWnwyZxW4U9eX?=
 =?us-ascii?Q?ZLnDOOp6opUN42W5I8NFparP4yf+KLVEU06bBctyVsP6+Zl+VIY1RYmlihmw?=
 =?us-ascii?Q?FmOjzvPb46oZE++XpKiNUMkecE0GDF5TuVRO5EyJD6o3yl1I9qjJqx7ksFOY?=
 =?us-ascii?Q?VK+pfpIfcel0F/FiaZV0s4FnCB9pxX44lWtw0WtCVykgp6+d3on9yMMBE1Ue?=
 =?us-ascii?Q?qhaq70UjZe1eXK+QV/QTaE5EfHVtoD4RDuW3rZCATJh54dPVbXgQr2O8AP8e?=
 =?us-ascii?Q?h60mvaJs8UJjxuGE+z5jRYL0uavqtcxNFQv8nvqMDiQVq238psMOYmPvhjEh?=
 =?us-ascii?Q?JYXpmSWPW702QCPZHYqX2NsvOIrCkO6qRuCnLwMDXbn5OBwV+DgKMKl4LQCF?=
 =?us-ascii?Q?0EawAmNG3GSpSwc5q3UHYryJfwZQmGRArOaLm2OVGxCf89AH5SDl5Q6aDLfz?=
 =?us-ascii?Q?reif+EvQqzCvCENbNmMlhGQ7DvJCUT2OJribUX+UwwAZb5JP2lX+uJXrF6WX?=
 =?us-ascii?Q?73ps1Cg2nr451DJALtEVcn2cWRYeSb6uaxqjIWmznaKbu7xdsT2I0WPZ2IQf?=
 =?us-ascii?Q?/uhFC4Ee31NRa5Lae7+PqKuiIFCMVZIGE8LhfbZOHRJiHbRy+ViGYhiek0m+?=
 =?us-ascii?Q?OhSRALKBT/MObl6DA+XQPLlysEjxUU2pE1jPxxIyUPTVcaYAJOlKi09nj573?=
 =?us-ascii?Q?R85vHQ6umh4QaNS1lu+JGtsJzuuGf5/fMEppJnAUpPAam9YPpuskKH3hLk7p?=
 =?us-ascii?Q?ffH6DbEWjaU5TYlM3gI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:44:30.0256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218e795f-3b42-456e-f3fd-08de15fe35cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

This patch series introduces support for ethtool selftests,
which helps in finding the misconfiguration of HW. Makes use of network
 selftest packet creation infrastructure.

Supports the following tests:

 - MAC loopback selftest
 - PHY loopback selftest
 - Split header selftest
 - Jubmo frame selftest

Changes since v3:
 - add new patch to export packet creation helpers for driver use
Changes since v2:
 - fix build warnings for xtensa and alpha arch Changes since v1:
 - fix build warnings for s390 arch reported by kernel test robot

Raju Rangoju (5):
  net: selftests: export packet creation helpers for driver use
  amd-xgbe: introduce support ethtool selftest
  amd-xgbe: add ethtool phy selftest
  amd-xgbe: add ethtool split header selftest
  amd-xgbe: add ethtool jumbo frame selftest

 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 353 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   6 +
 include/net/selftests.h                       |  44 +++
 net/core/selftests.c                          |  48 +--
 8 files changed, 421 insertions(+), 42 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

-- 
2.34.1


