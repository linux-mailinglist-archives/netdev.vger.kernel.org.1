Return-Path: <netdev+bounces-115073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9114F945075
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B558B1C23DD7
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A7F1B3F0A;
	Thu,  1 Aug 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXtRt8mv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB61B1428
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529501; cv=fail; b=Xi3CpYXhD5iOcthqC3+KFghjbPTLyQjGjy1s8mnefIJtXvOvwRP2PX6NKhu9FoixUnR9bsWn2ylx38Hiatur0IXgFc+2aTMhgrr5CDOI8TUwliipBwONny/1gZJvMXD4EUNLdQHAJgAMfSmh7kLEtm0BmccuVvWW+gaJ19APovQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529501; c=relaxed/simple;
	bh=8iPjdvWBckiSU1qLSWpfpxr5n+hp94SwGM1HHBfmjBQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QS1L3adV+gsJpOgmAkyEU1QMgqAZKcHFqM5kzxgWx+bFD4hayNj+oNI92lgcpZ35CWPThIy9q51Z215DGNLO5T2RNVuEe1T+gfU3tKo7WoZft/nOIKyvzoqwY+FMCNckNL0Iegc6YVtag+zvP7yWGVi3filZsr3d1+KTd2I57Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXtRt8mv; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9uCUEN5tSkAwAOuLQ5Q09ycAaXxxF9gIxJefbbawSRIqyVF3h4yKbKsaEB/od+pAVPCEbMx2yfpXR/VcdOi4g1zOFjkp1PyF2FRUgTPoUoq6DUufXZxyAXGufKN2yCqqMoRyfnUOv796tkshmhcSJlTFLfyfkXX7kJKVmd01sHUIvvEaaYpeBM7EBgwiv7xsi/OGgkiFfk3xGCUaQC7lnzcyd0aZrdIIL7a5bG1UpT389WEraCDC0G035Wby/EQqrX0a6HFcseuaghrzWCInqMbmGUqgQ35dmeG8x9ZvI7ew4+T8GrWUZ5Rs5auKlVAddCAIe3u7qsH7jCWizIJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6Vvn13tCjZGjrxxEw54PeZXqvlXOoFm2d2htfk4ilE=;
 b=OrPkLU3gmLIzYApBs26q6Ip/KJGhNNQbbwUVsl1HagraIk+mIE7zfq0a0jUuRwXISeZZISklsiw7XKw7UcfdToY/dO6I+CzrOdrd3Dl4j99BwSIk5B4jvkB9ERduB3bhYoKU3GAye3XE9N5QcXIOXOl1q+pAbEYDrkWnFEPVGa3YGvZHwTg9rqIELOniAROKggohY+SPwMsjPl6eY0qhTWe8wwYNavmILdzaREXc8pTNLj7feoXc4HGELCl5TgZWwLDZa2rfSl0dDnLGuaK26LVpaD8Fo/JB9jjhABMP/2+qbDI+q6rKkf3oMW9AolLshJ0M1tA+unTbBNbJUJ8jQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6Vvn13tCjZGjrxxEw54PeZXqvlXOoFm2d2htfk4ilE=;
 b=EXtRt8mvmi24oNOubrY1r9JSJDgC4nXVVnj+0zQ6HTrBllVZEJOFc8h2PkUMClYAnrGuEKOWwZj92XCseqCakGHZ53YHj47Aq0w8suucSjLTs9xKqRoc380A6FV9DgxoDFdpF5ocDK3JMNsbjkqk1pnJzNJSX1t0MCxzQkjePD1MENXHUpU6LU6C+if8AbttamXpqGGrg0O7RNn7OPRLpVfV3OsUWGtzJKPXQzzuhrwHuL+Ck35BYGKjCCgbgzyVZt0PZHKLdHmHegezMYmxG0rZ3x7WeIX511eftT0vywFYJqpqSOIE47m/gt+JxdhUvb93AI5OvyjfXgfGpsyAxA==
Received: from SJ0PR13CA0133.namprd13.prod.outlook.com (2603:10b6:a03:2c6::18)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Thu, 1 Aug
 2024 16:24:54 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::6) by SJ0PR13CA0133.outlook.office365.com
 (2603:10b6:a03:2c6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.6 via Frontend
 Transport; Thu, 1 Aug 2024 16:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 16:24:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:37 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:32 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 0/6] net: nexthop: Increase weight to u16
Date: Thu, 1 Aug 2024 18:23:56 +0200
Message-ID: <cover.1722519021.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: f640b79b-e343-4090-5664-08dcb2467913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cv8/wVK0ZQrxGoLx3DRYoB7vrRNv718aLUnMssoQljYxvFjiCB9orCeP0ZG0?=
 =?us-ascii?Q?QMZKJ1O5RMl/YhL0SGdn1D/j/DX+V0DBUIbC1mv1vGt/Su/2N+m/634ya7tg?=
 =?us-ascii?Q?TRUk5cdm6D1tFxzzHEyV2Nrt+soHHFVwYPd3xyoO0hdY5L9mmqEAxP045i16?=
 =?us-ascii?Q?5qlR+QhQcYZU/2JH7ftX3DqXKmD/yqztr2zkCIpt+aK5TZNZinyaba/RHnBF?=
 =?us-ascii?Q?McMpPA+WW3Dti+F53vaPRU0+7xxzx7imVo36yCR7UoAWxIlDsKyioItetapN?=
 =?us-ascii?Q?xMtnnp8NCv3VPPUaux1UikNWdXuBT/mr9dOj5umIHWoX6FIhR1IHM6iDkvUo?=
 =?us-ascii?Q?DDRBzpbkaZlYhTUEXU0SYTrOSBBCVJA+EtE9YCBLY+YBhBjrAzjykT7XlWTY?=
 =?us-ascii?Q?LobQ1tSpKI3cvhZYucKTqE5XZw7N8H4aplpfFyjwOJvKv/c2MWNioTZq0RXy?=
 =?us-ascii?Q?AEEszEUnBqfuj5nDQaAnwnT+0a9CyKH/6OEe/Qf4NK5vBgXfHD06HHG05ujp?=
 =?us-ascii?Q?OPAZry1anFl8AaLQXc1nz3rnN7nfWr9DnGAIXIkNlHhdS5fGTJeqxgWf8hhR?=
 =?us-ascii?Q?OfIYpW47TzmBlzfJgKWunXXgE/UNZEyy3RQWi7fBozrDs/JGRh5Qwo3DMFp1?=
 =?us-ascii?Q?rrXP8nEcLtgk+1O39sjsZ296dWVefmZ5CfOb3Mi2JJ8Z8spcio9/jTJA+uNw?=
 =?us-ascii?Q?lJF/2fT3r4/hczAU+1V9tZjv32/0f83KK0P1RoJbRb3fxis9ndvVNc8I+O7u?=
 =?us-ascii?Q?RBHhin4y4tFszVjCROjVJByQN51LFg+/jc3AT8HzQ4dcHAXdNOnWhm+zdPq5?=
 =?us-ascii?Q?WOgCe7OuTig5EZZ9tP76MhuRrdkZpHktaN0J+waarP4bMGVtcNyzyfl2C348?=
 =?us-ascii?Q?19q90gEod74uA7xh7RIrIXxsK2Db6oYcVT+xMcu1RjpyJeLTMiwrcgOeY015?=
 =?us-ascii?Q?B16jA1KAOGLLpwhxlw1s8Nl075QVIdW9Bk++3OgtUrFLMzgr0kqbPThGgihQ?=
 =?us-ascii?Q?4/l5Dwc9Bfh0mPCHckuu77Ce2j34xyZ7UqAYcoxAO3+kHEY7QxjS1LeD4alg?=
 =?us-ascii?Q?zU4DwWYhyfUL+rS/lnNXsiM8LXspHv5BzZuxropneBo14pyhuGN1xxfGL7pf?=
 =?us-ascii?Q?a3iQJxaJX14UPzrtpnrY2Ia3yZo3kkFchNkcHdWrNeMGfbfA2ihI1mi7KzGv?=
 =?us-ascii?Q?yezOJkxJVa84n5lDcZua+YIlcRK4LPcpJUbVyTprNQwRd00XoGvTDw6i3CIR?=
 =?us-ascii?Q?O4jEdy5l97PhrC4ouUqIVzwZybFs4NxAdNTxFJE2ujI5C2IMvykokKZKey9U?=
 =?us-ascii?Q?kyRyPlB08wWIqJcHqQQw/Ajngn96np0PmIYW54O9OcfUAcX5+pg1Qsp5ZA5L?=
 =?us-ascii?Q?wrUrIfoyktzPDmVPUTAzaIy4Uhi/PvWL+DXFmCaenTBLTKLrwTgpfTrQSt66?=
 =?us-ascii?Q?BApf8hWzwoevWw4w/Cb5VG2Gq+ZKflrk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:24:52.7908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f640b79b-e343-4090-5664-08dcb2467913
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

In CLOS networks, as link failures occur at various points in the network,
ECMP weights of the involved nodes are adjusted to compensate. With high
fan-out of the involved nodes, and overall high number of nodes,
a (non-)ECMP weight ratio that we would like to configure does not fit into
8 bits. Instead of, say, 255:254, we might like to configure something like
1000:999. For these deployments, the 8-bit weight may not be enough.

To that end, in this patchset increase the next hop weight from u8 to u16.

Patch #1 adds a flag that indicates whether the reserved fields are zeroed.
This is a follow-up to a new fix merged in commit 6d745cd0e972 ("net:
nexthop: Initialize all fields in dumped nexthops"). The theory behind this
patch is that there is a strict ordering between the fields actually being
zeroed, the kernel declaring that they are, and the kernel repurposing the
fields. Thus clients can use the flag to tell if it is safe to interpret
the reserved fields in any way.

Patch #2 contains the substantial code and the commit message covers the
details of the changes.

Patches #3 to #6 add selftests.

Petr Machata (6):
  net: nexthop: Add flag to assert that NHGRP reserved fields are zero
  net: nexthop: Increase weight to u16
  selftests: router_mpath: Sleep after MZ
  selftests: router_mpath_nh: Test 16-bit next hop weights
  selftests: router_mpath_nh_res: Test 16-bit next hop weights
  selftests: fib_nexthops: Test 16-bit next hop weights

 include/net/nexthop.h                         |  4 +-
 include/uapi/linux/nexthop.h                  | 10 +++-
 net/ipv4/nexthop.c                            | 49 ++++++++++------
 tools/testing/selftests/net/fib_nexthops.sh   | 55 +++++++++++++++++-
 tools/testing/selftests/net/forwarding/lib.sh |  7 +++
 .../net/forwarding/router_mpath_nh.sh         | 40 ++++++++++---
 .../net/forwarding/router_mpath_nh_lib.sh     | 13 +++++
 .../net/forwarding/router_mpath_nh_res.sh     | 58 ++++++++++++++++---
 .../net/forwarding/router_multipath.sh        |  2 +
 9 files changed, 201 insertions(+), 37 deletions(-)

-- 
2.45.0


