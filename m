Return-Path: <netdev+bounces-145914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6449D14EB
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B570284602
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78B1BD007;
	Mon, 18 Nov 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MrMRIDQ2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD881BAEDC
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945705; cv=fail; b=gebBj77KhJrhKVgmuzHtJQ6K20DFfB1Bd/FuSJnUaUne+KEy3f3VFG7aMZKNjPJzbuRxfis59l7Ynj9+OYWFYQ68d2R4AwspOrsHtGxhXRBGJXTpVqzV6gpWsBpW2c10xYG6pLc1cDIzxxZtPSdNe1VymC4G3u/gyq6CgN4jIEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945705; c=relaxed/simple;
	bh=v5dh6n8tSrK7IqmS0ChbfPrtnmLSdiXqdnDR9sA+FzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNfe4UFRuukkUCjGawT79tZYa3MfU6T9XkOANN81T2HhGSjMYPiIYJ3wbzUVK2yB/CMdCTetz7AN0/z9sEpyYSSI+vanRo+pOjyuwxiHj+bR2oDV7Xq++Lw5uDaEBUuD5DSxjOSRP8TIkLnTzbqHWdoseowvc0Iv0Fd3QJm8Drs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MrMRIDQ2; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8RwXbG/TDRGP5kJ+cEW8IHoezqrYsC4nmbpcJMvHQ1YZ8tvatlrf90obHmw/V4j4ZT1/OuXle5kPIZccUYfsxWSmBFtQQ644VlBmlMjAEEDdQe2x1zwlwwezbmy1iQSfC45x9sjAzJA7obBimMxecEG2QThN3vrzB9c0YQxEKGxCYsKs8IwjfAaN0a3ehN+MiwnAJ+jDwT+TCMe3Abywk3ObfOlhqPQ8bCFCy/jgTFa4EzQiutGf5wCfwl+u1H398I19j4kl7Dqfj0D7QWxM+L8a8H5KTQ1dC3n69fLKeFnOBxjVH5BDl3y/cwnlgxSEh7kAcJbPjUYYV0R8rOtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwfegF3UC+T+bpOT7+GRGxrg+bejeXKZoDmsAW6TZDU=;
 b=YXzAfu3Sf01e7pX70EEWQSg5gN8smgRmZ3nrAcVTK/VdMWfuC0AaE37Z0vqSRo+Wo9eORXA5x+fCrGhK6H/Rx5VIUzdou20F18POREfiG9xj4UF4WtY+gWzCPbVEX5UFZQSl07GMOzNGw0CQTjEvZ4P9/F7gnMwwJCJBKPE/YMWKGjJys3IkvDxoM8zoU13TmX8cCHujg8SakrWfzwmM07IrgRydaj7iSTtY4jBZBqRGEoLKx8joF9hQ2Thc3Z5ViQPfFLcWOFe/jHtLyWkj1xNThRJ1GRm/Vgj581KmMYo6X5D5ZRDa40j91/hEsjEJ6MuEiRbAjSQyrj+AU741tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwfegF3UC+T+bpOT7+GRGxrg+bejeXKZoDmsAW6TZDU=;
 b=MrMRIDQ2BsuIu9VlV7BaiHDGtNTaEF6sByvBFoHT2kSFDNTjrTj4hgWhOoJd2EvZGJ9z1i2PDs73gAAthz1yKVlzbswbNXBDmVRU1kAMHv2Zf3yvb1dKV9sPBD2M7NmGbfqrZCAq741mT+Da8ibUhM32XT/aojKTow9Qbgg6hvO5S2xZE1a0RHCH59MDxseP2BQg0SqO1v9KW12T52nb1O+J3MaPQk7dG1d/SHSVVgPiKTBugI4HPjr1q2/k2+KRdnHgz2tSyzH1H1UNcFK/miDUm1R0FD/mOGIlbn/KvkAYnsptWL7UoQY6M/l25Jb6pwRbhSzUJJK/qFMN04YZ1w==
Received: from CH0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:610:e4::9)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 16:01:31 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::11) by CH0PR03CA0184.outlook.office365.com
 (2603:10b6:610:e4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:01:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:02 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:00:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [RFC PATCH net-next 00/11] vxlan: Support user-defined reserved bits
Date: Mon, 18 Nov 2024 17:43:06 +0100
Message-ID: <cover.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 860ace4f-6a86-4505-7ee0-08dd07ea44b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+DiAPdtTl4sfVrKfM18Fv0pT8BkBBudVBt5L7IAD62N6jHaYL7Ow5MAf3kAv?=
 =?us-ascii?Q?arW9V/YVqlIc1SBYLLLnQtayBA0Ehq46naSaz/zPenJ2GXZeg9FCa++DzJRJ?=
 =?us-ascii?Q?mcm/tLqjYPczYrKeNxB05g+3A9slm4pLUntzb7QhFm8t4yVuuYAKL9p8DbEA?=
 =?us-ascii?Q?QbvBf7TH2WRNZeGIkw0ZSkJkCtYC02RdHfcQwv014KUD5KwUe6RP994Xd2oC?=
 =?us-ascii?Q?50gJYS67itA1ZVxteOYHUNq4yJYoIxBAiiZmMUnPD8HhP2ZSrlBWkJh3NX4f?=
 =?us-ascii?Q?3xAjVkBfI7QpKrw2v6Pwbn4WxsnLvWaSlcFt1NlSbQjaQ1uaBtp81qz38fRM?=
 =?us-ascii?Q?ibJWq+LoHmUoRE6ci5NHoGotecDX4cjoCpmp0K0lS1mYGN6t1caKF6LzDtBm?=
 =?us-ascii?Q?4AjBtNwuteN93jZKVqcG/ZttJsQuGfDUkyBolwRTRO6USCye32COK6P5ZIr8?=
 =?us-ascii?Q?NaZHrFkGmZpDFtLcbUjTeuO05Quy6j2rpCF1qQ6Txy/UTwp46FclV0Ckd6Mm?=
 =?us-ascii?Q?2UpuHvQ/vZos95mALw5T1dqt7CWypIuUqANJez0bESeFIvef+YfdpWP8qV4j?=
 =?us-ascii?Q?sGRMDTkfGl0BtLopJFV4JrHHJbfdW1lC7zfGIEVQC0wtnI+3/VQuKEJ6yB8U?=
 =?us-ascii?Q?a0jeWMWenU7JMdzBA8NJdLUhIMaFs2VsMxJp1EAQtzmuR5cjwzeVjqKaCsth?=
 =?us-ascii?Q?VJiFMjPvyUoGiH30thJJuCRYHbFDl/TADbKzmkdNogyqLgpBhghRlLGmWFOj?=
 =?us-ascii?Q?OtnOXLwEsVnLfL9iBebCYF3VTFkeEOJDxFB/z7rnuOhmgPInESQ9+VyI6NIt?=
 =?us-ascii?Q?LHRJ4xgmJe0EzOcUJ4djsq8vEmdl4WQNpNh6OFx69wdFRDG2LRw98LWSspER?=
 =?us-ascii?Q?qqJE8nDymey9h9pnzkuzIdHMCGNM91ML7W1TSf3LKX0AjCN/A0XIrt8YpCwc?=
 =?us-ascii?Q?rvB2+Cfo4HO/riu8TlbitQO1XspcFhyCvzLGZa/eHu1xVDqmcL5dVdNpAzdn?=
 =?us-ascii?Q?ka46XVKTDWjvwDEN7sgIbgQ+vLmifJsWqTThlZPoSjsGWXqC2Qtj6USJ0Frr?=
 =?us-ascii?Q?tLBJcKqCC9gvsfmFn0GIZcl/eEq3BfmEXCemG+iHHc1ZkIup1ROfSNHxeYq+?=
 =?us-ascii?Q?gjj9gfHgU8LR7TzUI8cRd4p+IUSXpOTwumKnt0VV4IcYfm4gJUIUzt67gLdE?=
 =?us-ascii?Q?DCVUzn2jNPrVxcuXV4Rfp+OiiGwNaGDLCknE4Al6GY4abLTUvlJ0nc+2Glt3?=
 =?us-ascii?Q?aUMD71EoIWkAdDKZdJ7qyzVmcBldOtLiTNo+5PuaP9Pw/hndjfgmDtHsviGP?=
 =?us-ascii?Q?WOtRjY/N5l6sDhWjejJKOW0GnHHhrDCfB13yf7+TT0p1Xmd89OCQlQeOiTeU?=
 =?us-ascii?Q?e6nq94qZ8kmKTAxFLPFjf2zMbEROOf8C9NSZmTc8IYoDtFx1TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:01:31.1377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860ace4f-6a86-4505-7ee0-08dd07ea44b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928

Currently the VXLAN header validation works by vxlan_rcv() going feature
by feature, each feature clearing the bits that it consumes. If anything
is left unparsed at the end, the packet is rejected.

Unfortunately there are machines out there that send VXLAN packets with
reserved bits set, even if they are configured to not use the
corresponding features. One such report is here[1], and we have heard
similar complaints from our customers as well.

This patchset adds an attribute that makes it configurable which bits
the user wishes to tolerate and which they consider reserved. This was
recommended in [1] as well.

A knob like that inevitably allows users to set as reserved bits that
are in fact required for the features enabled by the netdevice, such as
GPE. This is detected, and such configurations are rejected.

In patches #1..#7, the reserved bits validation code is gradually moved
away from the unparsed approach described above, to one where a given
set of valid bits is precomputed and then the packet is validated
against that.

In patch #8, this precomputed set is made configurable through a new
attribute IFLA_VXLAN_RESERVED_BITS.

Patches #9 and #10 massage the testsuite a bit, so that patch #11 can
introduce a selftest for the resreved bits feature.

The corresponding iproute2 support is available in [2].

[1] https://lore.kernel.org/netdev/db8b9e19-ad75-44d3-bfb2-46590d426ff5@proxmox.com/
[2] https://github.com/pmachata/iproute2/commits/vxlan_reserved_bits/

Petr Machata (11):
  vxlan: In vxlan_rcv(), access flags through the vxlan netdevice
  vxlan: vxlan_rcv() callees: Move clearing of unparsed flags out
  vxlan: vxlan_rcv() callees: Drop the unparsed argument
  vxlan: vxlan_rcv(): Extract vxlan_hdr(skb) to a named variable
  vxlan: Track reserved bits explicitly as part of the configuration
  vxlan: Bump error counters for header mismatches
  vxlan: vxlan_rcv(): Drop unparsed
  vxlan: Add an attribute to make VXLAN header validation configurable
  selftests: net: lib: Rename ip_link_master() to ip_link_set_master()
  selftests: net: lib: Add several autodefer helpers
  selftests: forwarding: Add a selftest for the new reserved_bits UAPI

 drivers/net/vxlan/vxlan_core.c                | 150 +++++---
 include/net/vxlan.h                           |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 tools/testing/selftests/net/fdb_notify.sh     |   6 +-
 tools/testing/selftests/net/forwarding/lib.sh |   7 -
 .../net/forwarding/vxlan_reserved.sh          | 352 ++++++++++++++++++
 tools/testing/selftests/net/lib.sh            |  41 +-
 7 files changed, 496 insertions(+), 62 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_reserved.sh

-- 
2.47.0


