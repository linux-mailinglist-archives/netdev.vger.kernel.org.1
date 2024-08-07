Return-Path: <netdev+bounces-116506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A0F94A9AF
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6BC1F2A1A3
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C87F339B1;
	Wed,  7 Aug 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJ8lnCDF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8602AF10
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040071; cv=fail; b=PzlySCuFmxIGPapI80OMjCrVIKCTlug3c7eHZXNhEYfbDFve0m2rn2uFgGMhTdLmy/gXjNkMfO72SPQPDDLkOoyXprGvQ88YlSVShwa5lMt+/W4FXZQlgLgrMnWVA9CbvZAfL9WmmKzWzIcfysRMYfwqRs5iOsO1/qMlnoC2nKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040071; c=relaxed/simple;
	bh=L73EtaYP/AvF+moCqxGuSYja2cUId+ialrI/9yns+Mk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UPwxXUApQJC5jaGXEqMkdKE2BOQg3m5BFJqabWNM6gagg7hfW1Ivv8llMueHie0HjTAURW/rgWJZD/lwtwM0MIQMBTHnm8UTBRFjquxYqco+UdFWNfTPyrd14YoNXZ4jZ99wJKzc6gP3yvxzKDqVp7e8UiHl40juX8KA1rElCWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AJ8lnCDF; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY6a50TumycKlGwWg9mt0LzesQQUYKVg2ILL/wlp+lnlPGHAIMCSlV4Q5Zxo63Y13mvDhRjgQYLXnPMUwV0pxqhVyJm5EY991/69Rc8swOtNjroF2I0AHQUq8CPLVHqOSi2EKRDViiDx6SesvJ6GOtMQmgjDHhSzhlKJmtjeupJz8oZv7rPIjKZ3PRQwk9qA8h4t3ILZM/gzECR+xGIIgeayq1SsEw1m0ucvXlxtK9OxZAeGkFZFUHU9lq+vuM/YTQsbc/ajK1K8+YN0vJSnkFx9CGllMh7g9T0jqTKtI/5ypRD/yY4rCioMKRepHf3DIF11q9IWdq5qk5JwvNkiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV28xBiUtlIFKHJ4Xkr017zUedQDmNhpvERCUANfXe0=;
 b=SsRKtJuFeyc6tZnLy2ubyUZjV9NZJcSqZhDos2KTNiE4u8Z+85c+lY4P9hTyzLDvOmsLl0ETZQrxXMRwZIiUq+Xl/wN5h1VVrrwdrHMA1iTZNna/1UpG/s/ZL0jqYApFPJ0YE3ZBb74vlf1EdW+LVVz7ZMOX23yMz+Usx8YLiuOXGgV1i7O0ugizDWCQHj0dcA/DN3kg2IklL9DdwcXQw21A5L5Xiq7ukXKQk0VoDAJeerbGpoVlCEZ/VdR7B/67et2WWexbnH/ia11j/ysd4SxhAKxF8RYTOXAyFC9ero7tR8Z5NpJQOpLpOsBlXt6BnPSJm+il+WHvH3+L8XO2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV28xBiUtlIFKHJ4Xkr017zUedQDmNhpvERCUANfXe0=;
 b=AJ8lnCDFyLyyZc1+0e8Gx5yZn6VYb0rOfJxxqkWT+VDQCotj/0W2MYesXpLTKko8zzgDH7EDKz7BdAKREhiq7jbZ6JXPs/5sGv9J4ZfHXoqzs9m5jvJ9FdnG2p7yBiwjroVnUXftTPD2S61JBcb7wzUB8C0b3DI6LvBEJbuQ7GF7R70yVasElLb05cx5LmmEYBm6m3eI+acRZpNXm9/BM7mcvKa08ccPQLCjmirbUF7UAJgnGw0lWe/PvIiVoiQh9tGBKtdx5zz6fLqshycr4dzOiArBYXpaQjyLGdnC4Z9O0TpprlRi0Jdu8xLb1isE9fQf3EWNOye9wNgeUWsSeg==
Received: from BN6PR17CA0038.namprd17.prod.outlook.com (2603:10b6:405:75::27)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 14:14:25 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:405:75:cafe::d1) by BN6PR17CA0038.outlook.office365.com
 (2603:10b6:405:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Wed, 7 Aug 2024 14:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 14:14:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:09 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 0/6] net: nexthop: Increase weight to u16
Date: Wed, 7 Aug 2024 16:13:45 +0200
Message-ID: <cover.1723036486.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bd73e3-2ecf-448d-5edc-08dcb6eb3d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLlPbFDYMW3GtjpJVT1UfYvM6VN/bfMA/1gQExl86N1Jp49l9hHSM9hJChxX?=
 =?us-ascii?Q?svzF2iKHbKOApVjDxI3vzWUQxtp+xHAQgteOcAWy3FsFKwZR764PF1Lrr8gJ?=
 =?us-ascii?Q?+xKIT3XPjgtH95AgaS8scJ5vbLrPXWkoCGWKa6yKGGT9Aoy3UYsxOj5I3sPT?=
 =?us-ascii?Q?4bVdnDMoANpmjqTLOgBLlI0gttH05Rwy9egqp2wvR6WmJHiziJ0No3/5VdQ8?=
 =?us-ascii?Q?/wPG8cuNfEC29VkvpyGYqxdtfbd+SBBEZBM4rSp0lEtd5dMjCmOLEubKNWDM?=
 =?us-ascii?Q?P9Ske4+rpCqt0WBG+HG6pTEcSF/Uk/RK1JBTFgUP5SWwxQ7jni8IfdHFDWGQ?=
 =?us-ascii?Q?XwDsSny9EjNmhOWsk9T+nP5dMfEPKwpx/vlltddU0/JykLhm+v2gILZ3YlC8?=
 =?us-ascii?Q?tpSrygCr5WRYg5RlG2IVWq9NFxbEd7TO5HI0vsWydMkq13Zx7PByEwuSxDRb?=
 =?us-ascii?Q?7dnG1apQKXKlM9b4/S7aJqHA4CU7zK/B0R7Jqp2eP02lBR/thOzrtHSg68wI?=
 =?us-ascii?Q?MxFrdyzkIUdFX1ljiQR0Zjkh+V9MbpmJKTVBMb6NsPV6rdsRgYJ1ffO5BODm?=
 =?us-ascii?Q?zMb5dqszJfakhPfepT11MIbMTtHL9fVO2Q28KJxwX5PuULizBSlpRmCCNaVn?=
 =?us-ascii?Q?R0t9t90ZAgXNrCMHfRniEYOToshL53pWcJs4lrz5jkD11uYHzMqCGYbB8hCi?=
 =?us-ascii?Q?nLzBQTvVBPdRh51OkTJ0v9d0s8Nslf4gBDuxS9s2OSlYpdDAw5tQwM2lY0/N?=
 =?us-ascii?Q?a4wPl/e/LE8UUAoeHjIJd8qWEYcfJNWks/jm5P+Ew0oqPlPKCS8yj6gwcipq?=
 =?us-ascii?Q?0vNLKfsbqlD5x+koIqFDIW7zCjfJhZs+npoYP3eG9d+5ZXF2keIkrnvUNIhh?=
 =?us-ascii?Q?2FmxyKa36sDjeIM71gAo87xnK3fNHTbdnxJa3QPkA9EJlDNyul2IylSrGhQh?=
 =?us-ascii?Q?RFTLpysrS1Rh9FZOgB3lt3jN4YFnMDlSWvzWznTo/AKcziEpWrvk7CETgVBc?=
 =?us-ascii?Q?xnmTKyV3x6pgnIdZTsSI5T3OaD/7mKAhLvdXLbh12Xc325yldShCTgGpaZyh?=
 =?us-ascii?Q?P2j/hTqI33rz2wVoD5eMWYE2Nuh9Nr+1+NlWfGz2G2r4ry2+qo4SmRibmOIV?=
 =?us-ascii?Q?djV3pwKH/Nflwuky/IpDMr4fnWSieY0GpvUuDUKeYQ/zI/GsafBi6IMbExap?=
 =?us-ascii?Q?Qv/lPIkNP8F5Fy8/pg/k1jWe0/11Zb1fCB9ZeZnYC8X6qn4PqdA++GMo6XxB?=
 =?us-ascii?Q?rIrQZLnnivpnSwM96XRUc+zCeHCI2XqJ2491RtB/ao1OOHPWrKTC6QoWsQJG?=
 =?us-ascii?Q?V3PCtCaDIVBulOtHNYZ2bob+KsLTQlqpPdrBmQqBeGXJeVXW/GE47SO3Rl0e?=
 =?us-ascii?Q?wl9xUIGdJeRTbIYYkvkyggX7X1ra2Litya2VYZw3BfSwJpp3NVjFyInjhXlT?=
 =?us-ascii?Q?uX0xuQvbnH8broDpOx1sXDapQ7MTq8W5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:14:24.1838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bd73e3-2ecf-448d-5edc-08dcb6eb3d5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932

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

v2:
- Patch #1:
    - Move the new OP_FLAG to bit 31 to make in/out confusion less likely
    - Add a comment to the flag
- Patch #2:
    - s/endianes/endianness/

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
2.45.2


