Return-Path: <netdev+bounces-160965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8341A1C793
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492D93A644B
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD713AA3E;
	Sun, 26 Jan 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EyzoQAql"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0986358
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892625; cv=fail; b=Ihc5Z9YZYKeCdxhDLH04TfTUnfVSXmPx+R+06E0Xc1Fxh7UW5XLVYXK4y/QhKuRGIO6SwrFemnEDOR8ectHGueRLT/u3TY7ROAfPnD9hKXYyTlRiMXlem4RqXJ7noRFFtcoMfGdCU64+3d10n1k3U9HfCtc3+IpNHpljqmF3JKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892625; c=relaxed/simple;
	bh=FrZopSgqq2J/RuQQhqj1dmboretKaY5+234RS+Qq4Do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMja0jKMjlFrK61WRRM+MZnpx5EtyUZZz+1KFTenY5PZ5h8EwYNT8EzIUmABkS4eLX9ms1bojWRWYJ+COjd5ibtM37BsYGPHTgZMxdT5WP8aIDPTvBgLrTM009cXVSxwc83waBMcLO5PdJvaPk8TG1//yzwgQ7ptoxLsAj7bGKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EyzoQAql; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqUp9MxMJVH7Rtx3IgRUDAcWTKic1W1efNuSH/g9Gu3Rq2Tbs5+QzY3SR04+yyZiZW0voFBB57yjB8avUt2uHM2TWDENgOwOEDlhTlcvpYwkn7vpODln4x5wFi5NV1IZCC2HlRCkzklqpybgVlXn0jWPoUoh3gAWoYFLw3sqDpLVKd9QC74Yf52s58CZQkwU1WPeRkGGurqH9bHM8TzDp+ca8e8PHtTxnEyNebd9d09THeu7CyGshuqWb/8q6+GrXGfg6spxooGl5Eda+Hy6NNbCWro7kXUx6o1EG/xQjXDdroRZCrTWG/PZz5mUUNTKrbwPfjv3mVZoh1p/zkXYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+2Jqa1LqzirbBg/aVAiHfP7wwDY+rPgug7XBUSgau4=;
 b=cGzuhoIFpgVOnUYj6m63/Fmb4+8FFZaVQg0iseRtMrWbdwqU8B0q6vLFb+k8dxb4R3lUZU+KhCxkYXgcsgBy3Ek9OuHOi6AJvDsqRF+6YNA22claGfHp96AZZs1NK1glBQzVIVy0R++DPHgFDIGCp845Yv96N9M3Qi3lOmd7o0EmKD5KV2QbBq+HMooUfT9/Ig1zbFHLAXtxx6WqpBgiqkfohlWa9qHhrfh41r4E+wn4EKXyvqiHS1e2RtKVtnuEH0zrYwhM/Cl8MuXXmbiOTnsqvYW7QIuLKEbGWZ+EuivjNyDmC8o/rd0VUBWDuWv/7nomJLgwpDQiijp1bDDqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+2Jqa1LqzirbBg/aVAiHfP7wwDY+rPgug7XBUSgau4=;
 b=EyzoQAqlfS2xfgHK6Y44pzz3mYbFcP1nnUxVSVOSfQlHeqymq8KDBGCvuwwjcpEYG1++TQAmNvPq8UAyP4qNOk2zDcb1pqWEdcbtYL+dVHjse0egf3pq47Ua990/uRk/WyyEPDY2JtNh66eNAybPq8FOSN3OAv0Pioj0XXn3jIc2qkWnnvUZx/2kP87fKsCX+TJWIeP2Ol7sKBjNpGUezbdmrSyBpCw/SeE2yIA9eiytjbVxZOKlRCQW2tph/6PJebeAx3ereEZn8cB6tucbjwwoqJAI0NmgpteUYumjbWDfcZDt9dqOeRuw+7tsXoJRb/4PqU68c8BeUXmwWTPJVg==
Received: from PH8PR20CA0015.namprd20.prod.outlook.com (2603:10b6:510:23c::8)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 11:57:00 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::11) by PH8PR20CA0015.outlook.office365.com
 (2603:10b6:510:23c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 11:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:56:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:56:50 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:56:48 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 00/14] Add JSON output to --module-info
Date: Sun, 26 Jan 2025 13:56:21 +0200
Message-ID: <20250126115635.801935-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8e52f1-a319-4f6d-daee-08dd3e008a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nKUob+9bSMhQ+PpsH+ARrtgXT/J1jkfHAlFk7siyRpphBioYPIuAiWHbb8Tm?=
 =?us-ascii?Q?kPu/6lsDWZNKcypP8ga/IQEd3rCOryU8Zo8XSzGxwXRE8Ra+CucCiOsjSmuP?=
 =?us-ascii?Q?Srniz4uNYhuthzgO6icx9jVQbOQTNi7jR1y5GYZD0fSHgqz0h9HiewlVZTn+?=
 =?us-ascii?Q?mxlKwWP7CHbg0Tef3MNjEvxtBuV0EkG6odineFhRKGliMZGWveo2EjsXTNCR?=
 =?us-ascii?Q?aN9iLcHOS6JpGNYSyKdF8XCl5NzUtl1X2uLulnramIPvuD9zCe+9duPBj1kD?=
 =?us-ascii?Q?Cjas5Ig0Lzz4wNafVwuIZ13mL6CHm/fKdddyQolmwAQ1r3VnyraEtV5Vs8gL?=
 =?us-ascii?Q?UB/KWw2WNFcpX2y+FXXP1gpSNCz3Atz3j4Jtsi64WQ4Rgzp1b2iKca4QMYJy?=
 =?us-ascii?Q?h2/KoZyly32LGJE38NNmUXhXX7BrMeNAok1onEPhgLjr/wryK0e4Z/5Qto5C?=
 =?us-ascii?Q?U+5NWy+FyLmg9tAT78zKOY8UYjU6BgY2mTeF/kITEMc+Td7xTMn0VxbXMI37?=
 =?us-ascii?Q?v9WS2JbpAjZUpl85g5xKcMa2Z4qBAYtsnqFO+GDFVO7zkTRLYttbqsfnjhHz?=
 =?us-ascii?Q?N3ck/YqnCj0J80gzc3HX+wnh4UsBplAV4cI5jGbVtFKTqrast6G+2uRg+h+t?=
 =?us-ascii?Q?i7r9wJC920oIpJu50nZeOHeZzT3Qij79R51Xuufvuemk54KcU6TMrWl0maxV?=
 =?us-ascii?Q?z9wClLS1vrK+T/CPst9DPAKWi3VOqAIzP+SECUY39B7b1sCB50UWVXUY0CqW?=
 =?us-ascii?Q?WO5csk0NrhXnkVit4uq4ZbphZco0fVUgi5TzPzM3QMZjP7nbCnegfaTa0NLl?=
 =?us-ascii?Q?E8+NQuuXXpB5Ce/edNNT2JYHVP7i8FkLkpFvvVIzOhAu1/a5nJRQS18zfsEG?=
 =?us-ascii?Q?jn0wyDV4wedPyuRNnHDuf4U3ZUkoZ4Wk4gl6sv7Bl5rfF++g4WK4d2bUkzpX?=
 =?us-ascii?Q?e8bTVPRbtaDxLjQhyg3qddMQzao13MhiXzRqjFCFplDwJUSQI0f/074541w1?=
 =?us-ascii?Q?FMTw83odtGSIO0BayjuLIEsfeSAezlNmzgQoQOOwJ8LRxSazCNBVWcVqqH+I?=
 =?us-ascii?Q?P4JaY90COk46kcQ7afU+Jpigs0j3uEO4dokcd1ozM/Efi4zxh6YG+SFJ66ka?=
 =?us-ascii?Q?GDQ//mweWSjTRCwZwQ7DUFy63WywFTIPiT9G2rLNE7a6LR5FANyaO28Gbhdz?=
 =?us-ascii?Q?YYbAtv82op+SOanXKS2jX7ZwTAaRLvyt3HcpRdtWIftZmPkScHQui9P/N5TC?=
 =?us-ascii?Q?pD1slkJRqlFsGU62p5g50samLqzN8brd1NmVQjUroqo+JQHO0ziLHt6xhfzE?=
 =?us-ascii?Q?XbkUswcvNGvjhW8HmlF3zpoi7D4UPv88zRAwu+ajWCjMaKpmek9F8qWmWfes?=
 =?us-ascii?Q?LJG/Ra3XZHzf6bI9T8SYM5Jidk3z5GxE/9u5FkV73Zm6Z3MeFJ099gbeAXyr?=
 =?us-ascii?Q?FdyHxADnnNQFbSm3saXfURw1k5LFQBffG4lO8r93pEcoRnFH4OQ07wE1cMum?=
 =?us-ascii?Q?UHMJWHTmH0nLqPg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:56:59.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8e52f1-a319-4f6d-daee-08dd3e008a4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737

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
 cmis.c                  | 500 +++++++++++-----------
 cmis.h                  |  62 ---
 ethtool.c               |  10 +-
 module-common.c         | 689 ++++++++++++++++++++++++++++++
 module-common.h         | 288 +++++++++++++
 netlink/module-eeprom.c |  26 +-
 qsfp.c                  | 907 +++++++++++++++++++++-------------------
 qsfp.h                  | 108 -----
 sff-common.c            | 353 ++++------------
 sff-common.h            | 119 ++----
 sfpdiag.c               |  47 ++-
 sfpid.c                 | 420 ++++++++++---------
 13 files changed, 2091 insertions(+), 1445 deletions(-)
 create mode 100644 module-common.c
 create mode 100644 module-common.h

-- 
2.47.0


