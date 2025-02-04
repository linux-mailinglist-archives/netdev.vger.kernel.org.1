Return-Path: <netdev+bounces-162549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3314A27382
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA9E1884D6D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0F4215F74;
	Tue,  4 Feb 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L2i9O6vE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878D214A8C
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676443; cv=fail; b=ND6vtztij2E4CjEzH5cXPnEH5ZtlkHeUFPFp5ywbZ8t/73987e/wXvX14BFoS55XLo+eSBzcj1eKY+Qz4MLYS/ZhgQ48nRJw28b64MtSsCn81mceYYDKRrdfDFGLDA11Uktxm0Na3Mh0HyTsaPxl+pcjaAILDjlZQyKbLf2aFyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676443; c=relaxed/simple;
	bh=kltT/mT2l9fM4IuWAaW9TNG/TgQPpqkl8AbehIlyncI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sAcnc3cnBK9nx4tAAf79eyWLWwpcl8x2x1AEHG6GVSf9PiD13E2scDyThi4eUldh3fC3fa21ifnLvKAnrzwQT+mira7bwMLMtIxDfef42osKxB/5X+9QOdBU2ahDV5ApXQQVCdURAi04s3Yl2jui3dkSw2bVd6uIx/vv9p9W+vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L2i9O6vE; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8M+PtgtiKhmp6kGOtO61j9TiKT3wFA28MWFstDngXy37aQINYnMmmRTD1xtghNbS09uUZBxekyNx2ZQe3zn8XAF0rMoCKtdI4u8jDi9cNUmKxIRfI9aH42a+RGOrZQZ7rY13wOkV9KszVAbh764/cQDFZbcv+pPZJIaoWqpJvyHPkP21hiDmtCfR212UY4fn5G4OL7A1pOqlxWysoIdOH7yyCuXIDQK2++HWoxr0Euy/P3RpJKRQBq/aYuRCovAezAG8FHKmP2KV8MIHC8V8+rsXjHO8mV4gKAkNT9CWv7/PJ3SE6ykRRxk/x/C01r4tXSMnoiNBh2OZaGHzj1XLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT3Oh733g8pWKFJpSc8uW8GSQa+Vw3uwCXEy7GtvP5U=;
 b=q4tTBcuJVWaU/1Dmb0WICEPClSYiOfPUkuVOw2LXMgnLFxvnppjJWqYSPnVIr8ME4VZFBK4MgIuN2KFbkWmgSwyny6WJVJfuuZYx/wzUqs2fZ7JY1rGNyDer3IblfZINZ+rwKkU3T14NbT8I0mXBTWlZCkiuL2byFxlAbHPlC/bPCbPqdyBsE7searkv65D9X48ugzVu0S4OloaKzH5CWTUddFh+69jEy47YoMiEdERqbPnwEqV2wCxaXq+vVg+p1B0coQ0RA9jDtr4CHzZJF8gaVGVLaqYzuxT0HZgf/+6J7d+y7Pa0JnvfVU/cz+uG9T1/GntQKM0pmjkBdc95Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT3Oh733g8pWKFJpSc8uW8GSQa+Vw3uwCXEy7GtvP5U=;
 b=L2i9O6vEBq5dSVhimZUKn5HmzrZSFfg87fmmyVsYiXL1D60qJkKOb9zjvjqAnd0AMAWQq93hkhfl6Hg30jC0MagxlKcwDUT9etU9H0K2yKZaT8M3Ytxjm1kobgG64YJ4yTFf1e3Vr1NvEl9HDXI/DDCPqwbWf9qkWAstRYVdgjwYJKo28myjt28JRfawxTq0Z8drECvwKXfubx1aFnTkRmnpN/6rcT9KZW+25WOAY6EyNA8VvUyHa9llWJpLz+gBZ6s2c/a+bDmzTW/Uh0+jOXJFrlp2RyZqEfQBH/yfATTckHSkp/uSlJY7D5H2c2Zm4f5c5NtLWRGyqQpZFdGNMA==
Received: from MN0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:52c::34)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 13:40:38 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::b) by MN0PR05CA0020.outlook.office365.com
 (2603:10b6:208:52c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 13:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:13 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:11 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 00/16] Add JSON output to --module-info
Date: Tue, 4 Feb 2025 15:39:41 +0200
Message-ID: <20250204133957.1140677-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 700dd5ed-e64a-4a84-6ae8-08dd452182ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m5H6UyRzYyto8jrzeF/6id38r3Az6zAz74bWuGPuXP1ABZnfKRGCd47KYIEc?=
 =?us-ascii?Q?K/Ea21JCrg3nq4PeRrCu5nsXVu1vvrQMRSrlAqng2OFg2dkHbqx6trmpdQnE?=
 =?us-ascii?Q?ZpjOWU+2wO3ZEhoa4n0Ox+0ocr6klD/u5JU6o/H3PqeDrOWtTIeszBRChZD3?=
 =?us-ascii?Q?Cqtie+EXNjHUJ2uOQMhUTRzojFgFgLRgMaJxNqjdJkoNdVD2nx7X9nl1kcoA?=
 =?us-ascii?Q?8zonurSH6v8TfS6S6Pd+IVTbApXpGkAoisLBUPrvz8hVGs+hESJroV0MULRh?=
 =?us-ascii?Q?kajSQ1i8lz/LqgS5IBA80n0SvqIMRqIqhIdZCM9aK9YaR6vuaxDdfa7ck3EG?=
 =?us-ascii?Q?UwXQV58o6wvSdu8bcLvtHpDxQH9MDjjVNyS8bD6/Og6wFRsHTZ0m7qdQ/n9g?=
 =?us-ascii?Q?blljDzWuty/7FQ6pb2zgw8OjrNDKdm/xfkHjwdmegjRNzWHdmmCMvAQ5od3C?=
 =?us-ascii?Q?sOigiBVMomNOx5SJjTYeIHN4PDP4RqirCNtctYbIGWSCpU/Lexb4Viq0w0QR?=
 =?us-ascii?Q?DhLrhraTej6YIk6s5pXnp2cAokABSRvm0jJVGOkouHEmUCOjEvguyGyDhk34?=
 =?us-ascii?Q?F9iNGgzVzoZlgY3S2CuhEZ38L9QexdVnjf1PvYEKEYKw9kr+9Dp3tbmHsy3a?=
 =?us-ascii?Q?N/pKEhw4ykCDW0PjzkH/XbGU41VcVcj+n2Wt1i2iU9LLsiIvQUX4Y7JlKPNP?=
 =?us-ascii?Q?W8d0KbKq77cFVPC7XfLvxCll2Ui1KXhz+EfXI2IFvabMJrQJNolsKQHKszAx?=
 =?us-ascii?Q?A6b8uJHEcCeLjODghGI/DVitBnhW1K8vqf4qg2eINnl027fdKRIeHNvIa9Er?=
 =?us-ascii?Q?ibrFqhd88LA3JLcFXwXvZL+2QIS9NK0mqzElh/dk1y1pssirjpepOZlvlBBW?=
 =?us-ascii?Q?arFQPLyCYXDnubJMmVE7tcdOsh2t9p8ZGA5Qhs8TmXmAJWvnKt5XjliYFYik?=
 =?us-ascii?Q?pzl/FXvalyE8ihp0AkOUAxaJwHwAlfYkxzhd3iNCnrLjTXbr5XvXZQG3oiQN?=
 =?us-ascii?Q?uocvYrpld3X7vICNqDKIDEWaMwFSiaZrzpSs98Q6njNXSSq/tCdb4Q51oTGi?=
 =?us-ascii?Q?sn5RDeNJktqR6XWUgYrybK/t9MJCEj1sSfFcBooXAXY4C7aTWUISZSRzYs5G?=
 =?us-ascii?Q?7nfYk192KjQM8X+k1GwL3rBMGQlW1FKFFQtEpOI6HSXE1Ruk5lLVwQyw11SQ?=
 =?us-ascii?Q?2tYnwtE2EBhTNCk9dRReGD7kVoO37RWcUh/+Ujpc9b/PPCmYK+q/ZYBydE6l?=
 =?us-ascii?Q?zfBWEn3r5NOPTqyi2pp4zlgpVHBCxb/2MuRATwCaQhhcc2z3revzyncpON0A?=
 =?us-ascii?Q?75vI2Pz2/TsSL2Qtow0rjqBg6Nr/WbDx9Dgxt/CBWoFtt2Rghg55J+4RCfHM?=
 =?us-ascii?Q?BUnc1Tub5sjdoGSu8Qc0rZdXDFVMlzUS5nTwel9j1+KE6ElZ6xMZRX8w01x0?=
 =?us-ascii?Q?HRx9r7Xt3qrYQJnna1eDCpdUMwj5DZwZN670o4UnNgl8lAvR/1e8ukZ/THoy?=
 =?us-ascii?Q?PFQhyPSnNXa7trY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:38.3022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700dd5ed-e64a-4a84-6ae8-08dd452182ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

Add JSON output for 'ethtool -m' / --module-info, following the
guideline below:

1. Fields with description, will have a separate description field.
2. Units will be documented in a separate module-info.json file.
3. ASCII fields will be presented as strings.
4. On/Off is rendered as true/false.
5. Yes/no is rendered as true/false.
6. Per-channel fields will be presented as array, when each element
   represents a channel.
7. Fields that hold version, will be split to major and minor sub
   fields.

This patchset suppose to extend [1] to cover all types of modules.

Patchset overview:
Patches #1-#7: Preparations.
Patches #8-#9: Add JSON output support for CMIS compliant modules.
Patches #10-#11: Add JSON output support for SFF8636 modules.
Patches #12-#14: Add JSON output support for SFF8079 and SFF8472 modules.
Patch #15: Add a new schema JSON file for units documentation.
Patches #16: Add '-j' support to ethtool

[1] https://lore.kernel.org/all/20220704054114.22582-2-matt@traverse.com.au/

v3:
	* Remove unit fields from JSON output.
	* Reword commit messages.
	* Add patch #2 and #15.
	* Enable properly JSON output support for SFF8079.
	* Remove printings from fields that might be empty strings.
	* Fix JSON output in sff8636_show_dom_mod_lvl_flags().

v2:
	* In rx_power JSON field, add a type field to let the user know
	  what type is printed in "value".
	* Use uint instead of hexa fields in JSON context.
	* Simplify sff8636_show_dom().
	* Use "false" in module_show_lane_status() instead of "None" in
	  JSON context.

Danielle Ratson (16):
  module_common: Add a new file to all the common code for all module
    types
  ethtool: Standardize Link Length field names across module types
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
  module_info: Add a new JSON file for units documentation
  ethtool: Add '-j' support to ethtool

 Makefile.am             |   7 +-
 cmis.c                  | 493 +++++++++++-----------
 cmis.h                  |  62 ---
 ethtool.c               |  10 +-
 module-common.c         | 662 +++++++++++++++++++++++++++++
 module-common.h         | 287 +++++++++++++
 module_info.json        | 191 +++++++++
 netlink/module-eeprom.c |  26 +-
 qsfp.c                  | 892 +++++++++++++++++++++-------------------
 qsfp.h                  | 108 -----
 sff-common.c            | 348 ++++------------
 sff-common.h            | 119 ++----
 sfpdiag.c               |  52 ++-
 sfpid.c                 | 446 +++++++++++---------
 14 files changed, 2248 insertions(+), 1455 deletions(-)
 create mode 100644 module-common.c
 create mode 100644 module-common.h
 create mode 100644 module_info.json

-- 
2.47.0


