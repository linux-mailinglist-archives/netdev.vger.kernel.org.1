Return-Path: <netdev+bounces-130801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D050498B9CD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EB282EB2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8B1A08BD;
	Tue,  1 Oct 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LW3xmteD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AC19CC08
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779073; cv=fail; b=by/756u5GlHL61YQi4sTRYIUJV67fxUQtqWdoag/NYftoZ0wDqk5kiWU0wWdsU6Rtok5oVu6S2n3fHl14Gwgb35CBrc9R3F9Nxu4VGL5JyqPCX9SJv8GJt/qR5SmfRrQSBLuDTAAYJMeF2wZ+1dwkKvJix6F51gBzS9vfqyMVv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779073; c=relaxed/simple;
	bh=4tOVKL7RvKe+DYhMNxAdv2c31rPc6euHL2XDxpS/oCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WSqXPjnhHsQLwDQ3LwaJ8JcIR+/Zi2lmiIwnBiazkmf8FWprXivPCMhRCLVe75xlOFJdiD2lK4fjfX2GG0WuRNKVzJLloZ9Xk90yItrS1nwz8d7iYnE12bAVToRbzRrsNz0wSwYvJHXZioKITOCFYQxqdmW5Le6a/hAp0ryPj2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LW3xmteD; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOafRLyk8r9o1mGyVXzdWFJnGVzG5bjRJmhVoqL0T6dl330+CZd5N/37b1mHAwGaf41W8skNIgMdLuOluUPCfRJComWt73LW2N7p+eOrg823Rh+/7L4Rmw2mVmTicjIcJdKQ1ms3SBA+nLzJWJ6kKIMaNxO8pYLb+RJy/U8F63vt1+8nj9DIxDpD7CUFMNqnE0ljWBGCt8JQJeOxkcBD4eaoJ0Qr9WJXFo0CUL+8UPCHxOtAHVWDrz0Dyw5IoG+9tuNDHHWSh7hiXnL14z/a5uoySCO0r7KiAZ+87BGXi6oWM/3l33AcfeaoJryzsosV/XP0w2wZ12uklUMyuYrlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z9GwT/qJGjf586ttfJYhH30lEq42Ms8d61Vcrt0VJ0=;
 b=WgiT5b8RPa/UQFAMWUAeEiK/MxLFegP20fUPJ2H/BGK4npjojAYQvthF+YDyiKa+QOH4Ge6uk2VPSecz6/CarpqIeefWFygHJKADzIOZw00l4kmhmDrxeMHBLYd/DcFbIaVjUzQnk4zKAb5myC8BCUQ2nmFV6lb0JvXOr46U3hET6hpC6aqzm1OCYpOwBBdKmAxt+xqAYGqaFNGXPzVf2ij0zili8hY0QIdawYidTFt77vhMK3Dv2ngfkw9YwICpJsVmnteWPkMHshA+61jbNvZgaCFsUdL5jtZLJDJuAoxjUgkQFp79CssHYW/6BMmiCJEKuIAE9Rn7N9hfeV6EKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z9GwT/qJGjf586ttfJYhH30lEq42Ms8d61Vcrt0VJ0=;
 b=LW3xmteDwaOQEQ/RqRyq0w0QSoryysNuAZLQgPW/DgKoV45UEVBHyc4Pl8jG90uCLk0h/fvULYi9Um3wwZTlXBocM4/bO20gpfE6P8ltblTyuTPGhNWmwUojWe5xibqClFOIfjJ02p3Ku8+Tl1NXSI/Hqr9pW0LOQt4v9OwsMU/qOZmGg0CxJXNR1awkEhfrzUCk7YKcXmBkc2P6yqOWYrTJmzaFmK+g3BuIsF2THR/oxFBRWYUpZUjHW9ZrsKH7QI50V/Mwte6Bfh498cza5EOfbDWLP+H8Wbx+9P7f3B9Q5c7QXLBKF0kSRwj9I0FXdXdF3uR5+14JJAlUmJANqw==
Received: from SJ0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:a03:331::16)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 10:37:48 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::58) by SJ0PR03CA0071.outlook.office365.com
 (2603:10b6:a03:331::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 10:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 10:37:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 03:37:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 03:37:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 03:37:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 0/6] net/mlx5: hw counters refactor
Date: Tue, 1 Oct 2024 13:37:03 +0300
Message-ID: <20241001103709.58127-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: e8814528-11bd-498c-925d-08dce2051748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yq/rgZZ4kXBjq2ZvKQxiAl+xKUxb1opJtb236E2//MadU15KISAo/nfTedYQ?=
 =?us-ascii?Q?etA+MWx02s9TJWEx0T3INkI6xnTOi9yZJiXxGZh79Ap6tkRAp+LpLlJ2XqXg?=
 =?us-ascii?Q?8pMOB1U5RVpj7sfOTs0s+YG4r4Eh04rmxM7u9mGxbhOgvRsahvySfOHnAcYX?=
 =?us-ascii?Q?aqBW/1C5gQppE1d8LeqI0AtRynQgxTBW3KI8AtiiY0AB9BSzeZPp5POWrky0?=
 =?us-ascii?Q?q7gMBcokq9jKc/Zw0NLatyLPC03xy8pBXK6q3YArKCMB7/1KVlhO0AFzQkt7?=
 =?us-ascii?Q?39rRegVj3YqsQ80EyrtWkl8X2FVOLN7ftKA60YL34UWGb1KYBdw/+GaDTRpk?=
 =?us-ascii?Q?/zCnQtrpHqJvOhwn/kRtBuvZIkaAC5tQExv09HadnuoRfV4c4wYlf/k+h07c?=
 =?us-ascii?Q?J4i/PsFr9/JzC3hTEQ0cKA7VJJnl+olfgsIx2MoNGuo4Z15hcELNnUoEgOgu?=
 =?us-ascii?Q?GZ1Ue+pdD5apRmfuy48DPm13DPsdhoQKJIT1+goBQ/DafvHcUhOcl9qe5O3R?=
 =?us-ascii?Q?e6DKjTbDLT4YNfjI1Ac63hhrMC7pf6Y0nv/x/6RKmyZfcarNOjjvvddrcn9U?=
 =?us-ascii?Q?OkNTic3NyuVh4ihrACobMoe6KUD4RLSKm1bo4labHkG55UmVrVKfhw+TpXbs?=
 =?us-ascii?Q?hi0QZN2jJ6CdsZ6CRHCu09Vc8aR+ecHf7KKlDTT6kCQ76Ha32tf+n3yh56vN?=
 =?us-ascii?Q?RrglPRLaudLG5eutBz75pVhfMeNVecViLaffj/oQU2kAyWj0TzHNlRtqL5A5?=
 =?us-ascii?Q?IiIZ3sZFQaNAXDkdmS/pSxy8ekXKiGslu74jwtsfrFWYthqefPcp3JKfve7+?=
 =?us-ascii?Q?nXpebbBWbmeSe+uck98bjLxg9x0v4EybHEisFrZ9K/53GGlcu+wVU4UodnZn?=
 =?us-ascii?Q?YEP9Z74P13VCK7jr0+LDOMWrZwVDX2gO7AHZxwy7/pJejDhhJnoxuuXNRfJp?=
 =?us-ascii?Q?P2Bafxv3GAzsWd4h7weTgPLlvj+i3OE6RhmzaHxU06qTZ1h+IXKylBD/l7FY?=
 =?us-ascii?Q?h4VukqQl1747y6g87wNK+gNqXYXawlvTWRaiadYxNg4BIWRcn/1tnXCavGmP?=
 =?us-ascii?Q?TRk/HF17bsGtj59tR4BbRkX0i2Ub81uzX2uJbVweJOK3hOfgvwSdSLs0hXj5?=
 =?us-ascii?Q?8tTF5jTZGP+8D+dMM8TB1poEIdKCpjd+P0jqdQrfX/GDS9bpWJTZGJg/S/BL?=
 =?us-ascii?Q?H7WREKYuRkxGxndl6OxtroUmoIa0fc4O3HBNtKQ/Sx5SHx6u5HvZdIw0A7Pp?=
 =?us-ascii?Q?kn9J3WZVsXiCtvL6LT9hykoW5GSzWOFOVK4ZS1gZKbGlzWfTkpSTXHemr14+?=
 =?us-ascii?Q?pk08m2e33NoqzhcH/MqGj2diMjDYXpOzy8/FN+y0SsCCQJKG0fIPHbl1QhaT?=
 =?us-ascii?Q?Op4VGBlePsR4peg3Sa9iDku+7HVqjPncvRm++k6zONjxs+PPBbv9w1FVB8w2?=
 =?us-ascii?Q?G8cdX2gITRmgy0XEghaKBYPr+dABvsJF?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:37:47.2801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8814528-11bd-498c-925d-08dce2051748
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192

This is a patchset re-post, see:
https://lore.kernel.org/netdev/20240815054656.2210494-7-tariqt@nvidia.com/T/

In this patchset, Cosmin refactors hw counters and solves perf scaling
issue. 

Series generated against:
commit c824deb1a897 ("cxgb4: clip_tbl: Fix spelling mistake "wont" -> "won't"")

HW counters are central to mlx5 driver operations. They are hardware
objects created and used alongside most steering operations, and queried
from a variety of places. Most counters are queried in bulk from a
periodic task in fs_counters.c.

Counter performance is important and as such, a variety of improvements
have been done over the years. Currently, counters are allocated from
pools, which are bulk allocated to amortize the cost of firmware
commands. Counters are managed through an IDR, a doubly linked list and
two atomic single linked lists. Adding/removing counters is a complex
dance between user contexts requesting it and the mlx5_fc_stats_work
task which does most of the work.

Under high load (e.g. from connection tracking flow insertion/deletion),
the counter code becomes a bottleneck, as seen on flame graphs. Whenever
a counter is deleted, it gets added to a list and the wq task is
scheduled to run immediately to actually delete it. This is done via
mod_delayed_work which uses an internal spinlock. In some tests, waiting
for this spinlock took up to 66% of all samples.

This series refactors the counter code to use a more straight-forward
approach, avoiding the mod_delayed_work problem and making the code
easier to understand. For that:

- patch #1 moves counters data structs to a more appropriate place.
- patch #2 simplifies the bulk query allocation scheme by using vmalloc.
- patch #3 replaces the IDR+3 lists with an xarray. This is the main
  patch of the series, solving the spinlock congestion issue.
- patch #4 removes an unnecessary cacheline alignment causing a lot of
  memory to be wasted.
- patches #5 and #6 are small cleanups enabled by the refactoring.

Regards,
Tariq

V2:
- no changes, re-posting.

Cosmin Ratiu (6):
  net/mlx5: hw counters: Make fc_stats & fc_pool private
  net/mlx5: hw counters: Use kvmalloc for bulk query buffer
  net/mlx5: hw counters: Replace IDR+lists with xarray
  net/mlx5: hw counters: Drop unneeded cacheline alignment
  net/mlx5: hw counters: Don't maintain a counter count
  net/mlx5: hw counters: Remove mlx5_fc_create_ex

 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |   2 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 387 +++++++-----------
 include/linux/mlx5/driver.h                   |  33 +-
 include/linux/mlx5/fs.h                       |   3 -
 4 files changed, 147 insertions(+), 278 deletions(-)

-- 
2.44.0


