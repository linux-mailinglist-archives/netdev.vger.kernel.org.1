Return-Path: <netdev+bounces-167009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D084A38506
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727903B0A4C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195421CC7E;
	Mon, 17 Feb 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZQzOFyY3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9021CC64
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799726; cv=fail; b=YCWkEj6OSZOD4J2D/5i/GLODmHXYdBl1ZoEUpT2KHL/TCr6FKwEYeG5qRZAVmJ9fN0b2ENB5l21hKRxXU18V+qN5/AN3v6+C7VxvihHoO8sbcV5xp6MAm0qFYps9BxHa5Dt7qc8lIp69a1ajQiLeMFmGn5xwwDQdOL3zwwjzgtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799726; c=relaxed/simple;
	bh=tXddURJNj1RfgnhJtM0zWIx/JIkMZ3aWqKDfz7VvLvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/3+SFG5Y/cHvrCqhPQl6+iF00PrMfkmyFki4FoR2Xb6t5ay1bLH0A2iT0VEwoI4g09HSDFRhs9GpXtdsO2E6Pa3o8VC65VQRHvpNdbrzQninHF6Chw4WjkRg6qcYBdzYbhvy8EEOv9I+po8iRUVeEqltvvbeJ6+5kJEV/MgFwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZQzOFyY3; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPPlbAY/CVuFZMJzWW4/rifxvWXoRjc0jMk2BbmlPHgYGgiiTDVKz4/iaJy6BCldYbJg6M+I3Pz3vPf2sBRb2Dr3qa3Xz8Ire9XFklxZO9PQwhFWquQDd3s7+oZfRAMMqnWP9W1UINgSgh72+zT9qd1Td1a1arjSwOkb3iPh/asWcgi1bo5PrIZbpKLNHDT6Eos4dGfhIkXciVKHjuXRrs/MORY0Z1pWoq/2bW8XDZ8P/8VE7oPzOVOY7dWvvTAU9iCGyCBajGXsmpZji+vQXah/EPC2kMwcW7A4BJ7w/WxOI78Orh28EvGiEnVhMmqp/7IFaATD9EYQOVzuNQcJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3Uvzjtyh+aXZjeyj43Jox1vvhSvfETAsxOnZ5i/dpQ=;
 b=buLIUh0JKzL4ZlKHsjnZduYKKhaOPw3iFq9SjsMu6Vq9/IBo5TSIkMcn517vmuPgw1NN0JbI0UMXTCPYkWMycaaSuDlmqc+8rwS32mtwNIfGbizB5jO4vsE6Og2kQzP2DcQYGZJU4h7REUZso8timxSTWoOSaP/GbR4uig9tldsuUeZm5kUwdXl4WeudoL9awGdprwbymCoEPx0FYuLIuc77HYJVZ4Y9P3t+4Mgo+53ieZg7VRdzjO3RxeATzqoyv1ihny9jcmsGkMNY8plTLPCN7Egju6G/ESAOuQLJBOmmrbx+G6Q5WHQ4u0J525Dk63HEo2cd8/v22y8G8O+JFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3Uvzjtyh+aXZjeyj43Jox1vvhSvfETAsxOnZ5i/dpQ=;
 b=ZQzOFyY3doz56S4VRuJhPxQ9KumW5cqEjGTTDKp9ASJ2SxAkKj39Ix18KIuHdTh3aLc3strtsxBweN+zYAITxhjl3gQman3Jik6alfFLv+PbTgglBnfMGktFsctkJJ8v7i+MCr2d+1gsvRvm7toM1O6bZFoUj3m4GAUspaqQmlaSKeCOOuzvXAaFn1Grt9V+Zwf5uktloA9xez2c+tlnEmhJ3/6kpcnvdlg4iI59PIwEVPPNNQ7nMU9asgRMtopL6uXXoOqm7YqzwLkWfEpYoHkgQQXwO/aDg6SY12y2gGqPwIpd04CbTCpXt/m75mYU8iIyWspwUgiJzZsGX8uHOw==
Received: from DS7PR07CA0014.namprd07.prod.outlook.com (2603:10b6:5:3af::17)
 by CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:42:00 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::45) by DS7PR07CA0014.outlook.office365.com
 (2603:10b6:5:3af::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Mon,
 17 Feb 2025 13:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:41:48 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:41:45 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 0/8] net: fib_rules: Add port mask support
Date: Mon, 17 Feb 2025 15:41:01 +0200
Message-ID: <20250217134109.311176-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c034417-94f1-4df2-6ca6-08dd4f58dab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JinKx5mOv/aZq/hpCLZ1oRm7vkju0x5ykEMu/DmhIlLBb5ScX+B8qwl+cMR5?=
 =?us-ascii?Q?Bojnp1DXoCkJuoanvJKMGW8v3K/WMQIaj0MZUFdPu1VT8ZGaswhak7Me0P2y?=
 =?us-ascii?Q?LOg9Gcddbr8BOPg42uVOHDFkJ2P8JAu6X0dS65WF7hYwaDXDZmvjAV4HC2mR?=
 =?us-ascii?Q?ppVh0QbaUt/PEWPJ4aqocYR+AKsQ38+SPXF8HXzR+I8TVLyEInsMQmpMSmF+?=
 =?us-ascii?Q?1o2m/gJ1cw0Q4+1GaNSm2Lbr1szgXrEHmH1EkLKWP/s0r9VzV43syLGP6skS?=
 =?us-ascii?Q?+p96PzHhBTINKhS9kvkyrwXySI90zqG4BdH00Qh4jCLzX6TLHR2zvTw9NDUA?=
 =?us-ascii?Q?rfpcp1szTCIs1tuhRwXeFoxMAj8f5NBJzVhuAsPkMC9/itQRFqp+t2nLtrlB?=
 =?us-ascii?Q?y/ICxzPvAYzGJw542j0wGn3e0cURps3jCI8SXd45ExIHcsHzhEbeTpzZyEDU?=
 =?us-ascii?Q?PPhrmSnoKhvl1RTHvSIi8ZtsqMHd3lrsnBK3O/oUaWWOUDavH1sjunlUGF+z?=
 =?us-ascii?Q?Q41QEzxTH7QQRlMYpyGo7gZL9vPNiuU/+yvtU6qwLndmbYiNSDR/HrETITI+?=
 =?us-ascii?Q?qxznndsr/RfD6tTpvDi86FJDN6Id64toQglDiN0nmz+bG05zOb2O27asUPfk?=
 =?us-ascii?Q?R8+A/vp+bYfD49ugAFg5tUOcUtcTyFVhFbKUxFQFcCpe5YJLig/4E56uzvmA?=
 =?us-ascii?Q?e3ankwniNxIp+tZLsPBgqCSTZ89L+nUh2+qVTE4h9zGB4YhKWLAnctYT+y0m?=
 =?us-ascii?Q?Rs9xJhmsXY3nEXM7xtpCBRtNmz/CH7DYYDeCjDDNQ6X6UTg2+o08EA6vV3mh?=
 =?us-ascii?Q?XuSJgBVO1cvkE9i+1xXOHKma9QFPGeAzMvrtJzYdWmehiI0/2U5n3+cNlfgL?=
 =?us-ascii?Q?ckPxzaNpsTXn9qThiVO0gWlC3NDaBlouBWz/x1OtRhqXv5r0q5Erbs6+AOut?=
 =?us-ascii?Q?/pi7SWA5aFtZgA8ze+Yt01NqeNeFndnGyseTQHfJjgav3wu5Iuy5SDUfXjKt?=
 =?us-ascii?Q?XOOcVRIALETd6JqSVe/HK4Ur0IEvrMH2kGjUa4CYvb+idnaJeW7ULwMMt24H?=
 =?us-ascii?Q?wPFPHyUO5AzQpXNyAXtMxM2geGJexuF5du16bXoXpcuj1JoLVrrbFpB1FSNy?=
 =?us-ascii?Q?GDcSwOHvO+rKJoRtfhC9lUJQp41dKEsScaTF1CGJfb+9NWTEA30DCucelUMo?=
 =?us-ascii?Q?ds0XAmJtYSnf5efMAXe5Z1sshJGYtKaKIPZhEvYCkVhWGray3aq88BxuaDZj?=
 =?us-ascii?Q?OOGXTjo3wyT28F51ldkDnjt6/h4Vu5mt3L5qVh1UM9Kf1++C61ScIxL9iWo1?=
 =?us-ascii?Q?LmITeVjrJ29UbRdTIJo/3HJRjXL386YblFX6zZNuKvjq4oA7fu6SFkQDF80e?=
 =?us-ascii?Q?IGZGPreAfuJQqP+8q2tr8Sc8nkFV1uEdTwgcegdmoJSoh8o/9vU4sok2fk0D?=
 =?us-ascii?Q?y3gKCitPimNDKfNPSvGzBDis9CnL62kWvVEifvJk7iRqFCz1CwxNSBgrS7jC?=
 =?us-ascii?Q?KO2ECaOnN1FkNos=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:00.0620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c034417-94f1-4df2-6ca6-08dd4f58dab8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

In some deployments users would like to encode path information into
certain bits of the IPv6 flow label, the UDP source port and the DSCP
field and use this information to route packets accordingly.

Redirecting traffic to a routing table based on specific bits in the UDP
source port is not currently possible. Only exact match and range are
currently supported by FIB rules.

This patchset extends FIB rules to match on layer 4 ports with an
optional mask. The mask is not supported when matching on a range. A
future patchset will add support for matching on the DSCP field with an
optional mask.

Patches #1-#6 gradually extend FIB rules to match on layer 4 ports with
an optional mask.

Patches #7-#8 add test cases for FIB rule port matching.

iproute2 support can be found here [1].

[1] https://github.com/idosch/iproute2/tree/submit/fib_rule_mask_v1

Ido Schimmel (8):
  net: fib_rules: Add port mask attributes
  net: fib_rules: Add port mask support
  ipv4: fib_rules: Add port mask matching
  ipv6: fib_rules: Add port mask matching
  net: fib_rules: Enable port mask usage
  netlink: specs: Add FIB rule port mask attributes
  selftests: fib_rule_tests: Add port range match tests
  selftests: fib_rule_tests: Add port mask match tests

 Documentation/netlink/specs/rt_rule.yaml      | 10 +++
 include/net/fib_rules.h                       | 19 +++++
 include/uapi/linux/fib_rules.h                |  2 +
 net/core/fib_rules.c                          | 69 ++++++++++++++++++-
 net/ipv4/fib_rules.c                          |  8 +--
 net/ipv6/fib6_rules.c                         |  8 +--
 tools/testing/selftests/net/fib_rule_tests.sh | 36 ++++++++++
 7 files changed, 143 insertions(+), 9 deletions(-)

-- 
2.48.1


