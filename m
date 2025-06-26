Return-Path: <netdev+bounces-201424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308BAAE96C2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE571C2366A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF712264C5;
	Thu, 26 Jun 2025 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rumMGgak"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE11C5F14
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923168; cv=fail; b=t9Q1NgRxfeJ7Gaawti41DyWzcmiIzW3Bu2QddZ3AcvDG273d5/DvEUrRgC2M1t33NXjt5AT0rXx40a0XLE+VhlK3IKN7zNV+wo16+PldLHQHapY54jsEBERQVLnHlRHmKiK8AGhAJ5SFdjdxGDieuxTdU9RhsagdLz5SjaGg/7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923168; c=relaxed/simple;
	bh=nO4VcQRIqr+1rQ+MvFevnOZbTBKtuv/4i2AQUTtmTrU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EQOA5PQl+4VX6O19X6WmCv9LrIqvWrzOE9wMnIPlYrq3VhfBcCg6L37fb5uRlXK6lKvm0ifJL3IldntsDNooASOoDiaQhoJKIHLQqclpbkuMVud5HRbqBL24E4d3CvBLlFopi5ERfKXfJfqYny1z7mGGnGEpsGwI+p/GITMM6uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rumMGgak; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx6zNEzeeyTTQNojOiuTYNxW7M50ZG/lnXSk/xk6JPBx+mkgxUZidfXiqzcoIfTu5dHHuZDUk7rlc9gzihTGLKdrOMhGTO5wFETiJXct0FC+u1ZCBS1Y2XBmBSn14hZt9Umqf1zUJJVqt+SBZaC7mORbS0OcpgkvLIYiKPu8opgGpq4r+91zGH/CFccUKe9w3BRDx0/YuCSLqkWneFyDZzXjnIBBzLrYSxX+xB1UgS96s6ZrHc5l4quDUceZNomxjJ7pi3J3VifQKYmBnWKGsecfEZIJ0Q/3PyglYBUXNxszvVatpYhjf8w8UV87FUFMVSM0UYjdsnjfzr+fCNdElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey4azSgM/tuBzbja3QlVi7CK4swW5+ArHsS5lZydwWM=;
 b=wb0k9Z/19CsH97dFy1PlXXujJfBGHgoInxhbIqCl7l5ZpvDoV8FleAk/44Wh9/6vsLHMDJqjtAEQeN4Qoeyqski5I/BZDzZTEc4qEo402DWR3U6xIClQvaNOvbbjXJRe4chYuYzB4b0Q/cWBr/SPJ1cufIDghjAKmWGdm+5I9nC0r3lzQd2Nm4wlobUpWwbPZjukGgOOwork1XPgovZ3sh/kaiwqLTPl3XVfMiSN0eTHf4MRHsNVjVHJgfntfr6uecwLzaD9x46wUtx0JKYUlnzjAjzGtvbaNwXNXzboRPoFKnAO/h6JDPocw+SfiZsCk/CM/2PP9GzoXIM9YO5QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey4azSgM/tuBzbja3QlVi7CK4swW5+ArHsS5lZydwWM=;
 b=rumMGgaki9BDW5k6TTmLgJwd2jcUVNRPIfzjmuWNaifVSJQWLtRKwTXkUARxE4dj+51TNAQ1BM7xSqmnPiYtF5Rfb+nMyZuZIU12h8L8PdvlqBuVU/JyIB7w/ygI8/Hzn1p1juzPR5nltl/TzN6GEICGmDICJxkFNFBEdVJZL49lLuwLyOsLfAXeFTPayw4VEGhvMK2GJ/nNj4csWifTSxj3ZcRUcWK33NuZ5RTia2WtsaC4YTVn/U5JVN9fwcXftwlOXVNJkjWnEASbwBhepakKUxPyQTARmB8xZZZsOZwdmMHiQ/K606p1TkX8kb7dhb+8DuJCTXWA96lJ/fVxog==
Received: from BN0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:408:141::34)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 07:32:43 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::ab) by BN0PR07CA0012.outlook.office365.com
 (2603:10b6:408:141::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 07:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 07:32:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 00:32:31 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 00:31:41 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <daniel@iogearbox.net>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next v2 0/2] Add support for externally validated neighbor entries
Date: Thu, 26 Jun 2025 10:31:09 +0300
Message-ID: <20250626073111.244534-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: c90acd5a-fdd6-4085-7ba5-08ddb483a345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uMJl2nEj3KpmNRNdq0K1aHcX4u3pby4G+sW4crwMBAAUg7CmTZJ9dR04/qiu?=
 =?us-ascii?Q?Q0AiATmm3gyrGr2wjtELg9KRS1VN9KoNirqPpznA8j2gy4Z5H9APXAopo+uO?=
 =?us-ascii?Q?rl45NzH+8kF9RFOngzYIUffOuLhOru+rUkc+fhBXJ8PY3P0YMQrdaVftQ3JZ?=
 =?us-ascii?Q?R2j865bNSe93SUyogu5sBWuT0YsdCIWx6+tlTF8I2tiREBwEphh6sNlR14ZJ?=
 =?us-ascii?Q?CQf9Z/RI8RJJPs4lZAYIRGdg8ECsJKDoZKo4T6eb2IPrp4zBg1ogHZLvEM2j?=
 =?us-ascii?Q?bUSzLEvK/tVIgbTQWoP1MH1w5raIOoY5tNTbXpQtXmvAJeNUvbHgrYy4Z0ll?=
 =?us-ascii?Q?ZeNGgxq55ZahNnjJQKWMwNBlaQpvzEDH+Hp/QFH/UP88FYocsIMowisWBoED?=
 =?us-ascii?Q?RwFCXSUoQ8ASrrYk7Jwo36sqYM0Ial1Ub41bLGkNqCFrFtCtdQIiGofbKeUU?=
 =?us-ascii?Q?By5BVqlyAZp2kFPKI6z0i2xTPg/NfAzgkdi676kVLfSjhSvzegJaQ4NrQl8X?=
 =?us-ascii?Q?R94GFb3SWve6zbC/OcG4++N1hlWtu/GK968uINbxgAL521Jdd0CDb1zwa8JT?=
 =?us-ascii?Q?iMPczDbFYGYgTOBXG+5Q1+rTAHMX9n20Cwkb+Bk/vC+e3Lthqnp2XqwmWjFx?=
 =?us-ascii?Q?djQEVF38OjXF/r/Wp1CDcLTWqXq39HCuyhqg3+sAoXvK4xn6oL+t8eC13jVN?=
 =?us-ascii?Q?Kb/DEsjeJi1uBJOTPnKDzzu+O8XLv3tnpvJclF3f9khvci9YmT/rkDpif0K+?=
 =?us-ascii?Q?nPG5hHYlLoTLmSrBH47vSvb5v7A1iYtrtiVcyLwdkQ5Caw8fqnyTd+/OgP2W?=
 =?us-ascii?Q?FzZ2CFMyyrkmVrQ8d//vdYShHXsQFJ2gd1qwpYOvEeMaFaPR5qNnEJnkZboW?=
 =?us-ascii?Q?GNmktKCygU4lgepV8PhZ1wP4YYgOOLQkdeJtK7pJMWqoxm95gTUz9qwRVaRR?=
 =?us-ascii?Q?LWsT+emCk5rpZzRGyYCe/6tpUnoCbX7g+/bcfLFqOSbBido6P7a7BW8gPXkc?=
 =?us-ascii?Q?qVKWcEBEov7dSs3gq7p8HIiE30CuM3vP+t76aJZri+inJFwfIMyvKoD+G1hd?=
 =?us-ascii?Q?pVVI5GgJRjy3LEYWI90rOy2zeaKwKHTZsWoNpgX3hHDy/VxxiGpg5mUQ6uQk?=
 =?us-ascii?Q?PWjIf+16zt7WkyWcrzJyJOBkJnzqeshQQdi+LswYbBVfkQwPbfRnxEaw8Y26?=
 =?us-ascii?Q?9qYWVxSXPGXgi7z4J9Ml/G9LJhPaqsXz01NgrjROlxhPO4eQyOKW6pve/kYg?=
 =?us-ascii?Q?w12NuOja68MIAX8MRXqUVTSsoAe+6sFlYox33268BtjSdfZ105Rx5WLSa/oC?=
 =?us-ascii?Q?jhiU5PyErETpfVYvKnAw76b3vYkadQ2SPK+JUqN6C6OpYolx+/WRQEfIS9sP?=
 =?us-ascii?Q?p0459E6Hx7M/7oPfylHsTB5ziT7tXlkIqMGYb8kSFJoTmgk8bEW7L3/pJrKX?=
 =?us-ascii?Q?3USeZZyjvE5illROaVQs1Cl4jgbE/RXpZj+KVBrx/sxtR+DcVDFU7yD9CnB7?=
 =?us-ascii?Q?xCnlHaF1RC48PhFkUFSCsPhGzX/eK4UZOT5E?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:32:42.7492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c90acd5a-fdd6-4085-7ba5-08ddb483a345
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462

Patch #1 adds a new neighbor flag ("extern_valid") that prevents the
kernel from invalidating or removing a neighbor entry, while allowing
the kernel to notify user space when the entry becomes reachable. See
motivation and implementation details in the commit message.

Patch #2 adds a selftest.

Changes since v1 [1]:

* Patch #1: s/neigbor/neighbor/ in comment.
* Patch #1: Do not flush "extern_valid" entries upon carrier down.
* Patch #1: Reword some parts of the commit message.
* Patch #2: Fix various shellcheck warnings.
* Patch #2: Add tests for interface and carrier down.

[1] https://lore.kernel.org/netdev/20250611141551.462569-1-idosch@nvidia.com/

Ido Schimmel (2):
  neighbor: Add NTF_EXT_VALIDATED flag for externally validated entries
  selftests: net: Add a selftest for externally validated neighbor
    entries

 Documentation/netlink/specs/rt-neigh.yaml |   1 +
 include/net/neighbour.h                   |   4 +-
 include/uapi/linux/neighbour.h            |   5 +
 net/core/neighbour.c                      |  79 ++++-
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/test_neigh.sh | 366 ++++++++++++++++++++++
 6 files changed, 445 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/test_neigh.sh

-- 
2.49.0


