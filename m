Return-Path: <netdev+bounces-161494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E065A21DB2
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823E91679AE
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE888BA50;
	Wed, 29 Jan 2025 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jNnDsx7o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6EBB661
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156583; cv=fail; b=fpgfgv9RHSEVcnd3jj4kbk1XXNWa9AkUgEi954i61di0U3jeZmsz0tYNWHzER0f8gGTacLr03tdCvTut+IDyPiJLCu6SgHbHmP4bst+UHi2f6I4WELyLn0hxYCNH9VUGlGwuQMvmCB2eUDMrxcxzXGRAY3r9dqsMVa1yU8I/dWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156583; c=relaxed/simple;
	bh=FpjXBavkn/rQynJ5GmaUWmgV/8PyPFqDwI1BFKaRd3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jt/IrXnMqLecV5nW08OK4AWoNjtFweCeV1EjwHaA1A8fYQwD5ywJWvoDkEmL831nXiUAaZl4UvUuPhT/4yK5J+nzjm1gEpCOZ0aAOv0R5Lwnf9I0CtSULwrsPtPl4M5rrBUqPkmwT0ZspfQbew1wB743F3/CdjHHYXNC7OK/WYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jNnDsx7o; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXPKC4OSn9OZCYpYtp3XhWsszka0X994LqnHUD4aYlswJQu1DhbOqMdAuXiEY23t6M/drl4nMIBK+NXSKgIcOgLeZLua3+jjd8osuv/7sl8QKywivXtAvZtBxLOnuWEEUryeNjn0wcObze9QH1xn59ElVuLS5GoVTJKnlsnEBL3m0JsQyHlz/mTWWv4SUi9XvelLpc6Ihy/yCixVPSEmaJjbkQba2IKmY8h4PTgbZoiojwwaWzRA3K+ynxNZ/jMMUO60pekyz++/X/YTej7G/GvDtXFt4rB+XXhXIbYPzgxp7b2UCHx9o+jTYR9g8qdyfg9I4WU4koumKlY0DmKTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hLES8Zl/c6cfu+Ehp1n4jFtuq7FJEZW+XNYc7jxdgY=;
 b=CYU1tKGk4bBqi8l4WHUu8jnT0rrwyUXRB9XYMl2M2T3cJMiPvMRdO6X7kKyd/i8Jo9M0yFASjCI+/HnxoST1lOcWdrb9ih3iw31c2HKM/Ytsq6zEzAuqJadT1ze5bj6PAyD0hmIs5QGCVYsgxkWs/4dH7FBTV6/rcGKH9GZzgzozXdWVXxDjEdqStaBA737eANWXYCwHEoicbnQoZ5aNCnG8ub1WAi119ESb0nmdwDpFrHhCU0x+ZNlSIV7N25b4WjpqDluCAbrqGi7MOQnOx1xnxQ/pJQG9B31ZPRiFd/oLL3Af+M87y99qD21ra6M83vuWcc5fG3Oh65lPi2nrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hLES8Zl/c6cfu+Ehp1n4jFtuq7FJEZW+XNYc7jxdgY=;
 b=jNnDsx7ooNflamiiqCBeYdY/TbWo854TawcjUx25GY4pneNHPgaNTGjMwN4TusYnAL2wZ3pTxHu3MNjswzh5nrLiEkatzuIrxPYrIQA651sVuJWLRvCWEEIffdH/N6s+Fqq+iFnWJnfBf2Ra6C9hBQZkKKQMNS+NC4aS8UO1ZG0tr7ba9B9CQ03yGOc4d5gifa9ZHMVohLFmRdXDbXlZ2wA3B8Tx/8Xk1Nk7tnl9LdniWIbT7S1/PzgvU2SPYMYJVzzGGMrWHTXzDQwzCEMCkDpJSOUYrq3TatoZiWz+/4XILsPBUJ4ZSzx6FJ0lsu6xCY/eSiP0scGACp9Q8asR2g==
Received: from SN6PR05CA0004.namprd05.prod.outlook.com (2603:10b6:805:de::17)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 13:16:18 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::ee) by SN6PR05CA0004.outlook.office365.com
 (2603:10b6:805:de::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 13:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:02 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:00 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 00/14] Add JSON output to --module-info
Date: Wed, 29 Jan 2025 15:15:33 +0200
Message-ID: <20250129131547.964711-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 766e39aa-bcf7-4e0d-fb3f-08dd40671d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q6jX1/4yd1E4bDF0PF/O2OdQGQwnbg6I7w0CK87mIIHBi5MPfT9pG8u6fVEe?=
 =?us-ascii?Q?Wh08EO5S2wcli+GrNmW2PK6n0aeN7hhpXi9e/P5gc75G9X0dM2z7pbch1x6a?=
 =?us-ascii?Q?/AYz8g72A6FU7xBLX3tsRmMr16xK3FGejYsFRlDbzsxGsQbmjmVPSLu4smtv?=
 =?us-ascii?Q?kQN0gpdmH63MUkvI3aN/5Rw6xZ5JYusW3C/0Cb8ZLQ83skpJfley4WbJVHbW?=
 =?us-ascii?Q?P0y1wcKfOsrFrnw/W/fe0Dy1oneWi63BkChXgdyEeh+Pbtnh/6eaOkzzE9+S?=
 =?us-ascii?Q?GLwzy1yZIssltD2uAey3PUzYDhZwE4R4sqgcj8ehCW67OiElCzhJfRSfDKgv?=
 =?us-ascii?Q?la/AAJAMnuhgJWnMIm+g/GRCeqtAhYI9zcrWJuYuimzkuBDIcL/lgfna/Tnr?=
 =?us-ascii?Q?jUGLKQSWyhaPBm0ECQiuQia3faEMlb6j/9grvtsD7F6+uG2kDq7clIr0i/rB?=
 =?us-ascii?Q?ZzVZKrAIINbTFcrR4Nszb1pLbZnlLgjg5MX/EgxQ60uaPX+hZSHaRm/QNhx7?=
 =?us-ascii?Q?UQBmtzIv1KeCy8RV7HIBTbvk8ICIrxfTHBYaBcaSdzyKKxR9QnYvgy2xoVvh?=
 =?us-ascii?Q?KHgs7cI61Fqs19ecLaht+rdZs1Viaixox3NPWkku/Y0I5ioV/H3wLah4fLEd?=
 =?us-ascii?Q?RVxFezq4dLVNt1ydT1ZOhlIdWTWVpWaUmtYku8BUAhnFFpONMmcuukh3zppv?=
 =?us-ascii?Q?sKPiMkctT0bOXJ3O5byVuAhFrqtHWym2wulm58eD74OJIFomU7TaIjqjl+ob?=
 =?us-ascii?Q?bxYG6i5+J7IY3VQm4XHwaNikCTH/Nd0Z16hNj1oNpCzGWuRW3aHjzmiavn2H?=
 =?us-ascii?Q?bl5ococeMSZBfSAqtWc/89vqGLOM4rwpfLsGXcEyXDRcWbeJnmmAjN5VChXV?=
 =?us-ascii?Q?t+Ztl7kKxrs+DyaXDbZUEZsbAK3s8Sd2YTng2J/5vvcWfNIFnY7ioCbIl37V?=
 =?us-ascii?Q?wBOV1nzfkd9kiPcNxBYoIyvs9iToDcMEhjYdn68N0jxbUj4FCpv2hbqyFCKY?=
 =?us-ascii?Q?n00Mdw9J1su/E9fndHEhD6M2rmjO21ACm+vqH7rw18s8F57DGiVN6lGIOfRc?=
 =?us-ascii?Q?7EQslnloijxvE3bDe7mhlPvHc+bP10YazOGUMvDez0Z1zuXCeOkBUkwdvekq?=
 =?us-ascii?Q?Q8c1D0F2pPrhQXeow+O4g98PFQejarskMwkq5IZkGSCv3a5EsY1C2IoWm2Vf?=
 =?us-ascii?Q?KAFijHEmLHvu03tovhkbkxdTGOUpi+ROxxd8Uj0yWosJlrand2Raz+y7HIdO?=
 =?us-ascii?Q?SjDv6z2kheqdyHxCX/1raacoF6riXfDEYFGDzBXD2u6fjj9fQWiAyHqx09Qw?=
 =?us-ascii?Q?nwc+LqcAeMuigum7pe+qRNp/mV5cr3KxQdQzEw3F2496dMEvLMpFi+B7+T6v?=
 =?us-ascii?Q?fK2VejrDRuVyUSwAzjamMUKRdRJZkx7PAcSJJNqV1LkWYw6az9YJ3WnBGH7T?=
 =?us-ascii?Q?Xsq5fowsmMw/0MXB1jmYYqSswN1y4jcCMQbuf81YaHY89i3KyAtD7dqXkwot?=
 =?us-ascii?Q?A+uZYiNx2n1EuIo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:17.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766e39aa-bcf7-4e0d-fb3f-08dd40671d8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905

Add JSON output for 'ethtool -m' / --module-info, following the
guideline below:

1. Fields with description, will have a separate description field.
2. Fields with units, will have a separate unit field.
3. ASCII fields will be presented as strings.
4. On/Off is rendered as true/false.
5. Yes/no is rendered as true/false.
6. Per-channel fields will be presented as array, when each element
   represents a channel.
7. Fields that hold version, will be split to major and minor sub
   fields.

This patchset suppose to extend [1] to cover all types of modules.

Patchset overview:
Patches #1-#6: Preparations.
Patches #7-#8: Add JSON output support for CMIS compliant modules.
Patches #9-#10: Add JSON output support for SFF8636 modules.
Patches #11-#13: Add JSON output support for SFF8079 and SFF8472 modules.
Patches #14: Add '-j' support to ethtool

[1] https://lore.kernel.org/all/20220704054114.22582-2-matt@traverse.com.au/

v2:
	* In rx_power JSON field, add a type field to let the user know
	  what type is printed in "value".
	* Use uint instead of hexa fields in JSON context.
	* Simplify sff8636_show_dom().
	* Use "false" in module_show_lane_status() instead of "None" in
	  JSON context.

Danielle Ratson (14):
  module_common: Add a new file to all the common code for all module
    types
  sff_common: Move sff_show_revision_compliance() to qsfp.c
  cmis: Change loop order in cmis_show_dom_chan_lvl_flags()
  qsfp: Reorder the channel-level flags list for SFF8636 module type
  qsfp: Refactor sff8636_show_dom() by moving code into separate
    functions
  module_common: Add helpers to support JSON printing for common value
    types
  cmis: Add JSON output handling to --module-info in CMIS modules
  cmis: Enable JSON output support in CMIS modules
  qsfp: Add JSON output handling to --module-info in SFF8636 modules
  qsfp: Enable JSON output support for SFF8636 modules
  sfpid: Add JSON output handling to --module-info in SFF8079 modules
  sfpdiag: Add JSON output handling to --module-info in SFF8472 modules
  ethtool: Enable JSON output support for SFF8079 and SFF8472 modules
  ethtool: Add '-j' support to ethtool

 Makefile.am             |   7 +-
 cmis.c                  | 499 +++++++++++-----------
 cmis.h                  |  62 ---
 ethtool.c               |  10 +-
 module-common.c         | 689 ++++++++++++++++++++++++++++++
 module-common.h         | 288 +++++++++++++
 netlink/module-eeprom.c |  26 +-
 qsfp.c                  | 909 +++++++++++++++++++++-------------------
 qsfp.h                  | 108 -----
 sff-common.c            | 353 ++++------------
 sff-common.h            | 119 ++----
 sfpdiag.c               |  54 ++-
 sfpid.c                 | 439 ++++++++++---------
 13 files changed, 2110 insertions(+), 1453 deletions(-)
 create mode 100644 module-common.c
 create mode 100644 module-common.h

-- 
2.47.0


