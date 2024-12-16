Return-Path: <netdev+bounces-152321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1727D9F3722
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384BF18863D9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963282066FF;
	Mon, 16 Dec 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qS0PbME5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41C205E35
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369171; cv=fail; b=glT2lcwyudet/xzdllFy5Sr4Dj2kDELDa6FDvRun+QfEKSs7k/AnNT85RoS18Pq6b0H4JXm2a+XcmEdNqh9pg+prcqBKZ6i7V5RNtRlmO1cRSt6gN5YC45DF/zw19qaau65lI77guVwcaCnuBG2tL9sp4ejQBGl+O+SQ1fQRKDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369171; c=relaxed/simple;
	bh=QjIfyfv0t8ovu9mxQbTbSCbruca0qFww1ANlXou8UOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AEOaoW/FcBQ2fSWTkMToRPnRt6sE51LLOt0QvV22AA0VVqEydLzfL+QrMM0wwfqaCDLXy4sfCTv7LdetAv4PBYv7t7POAPfTSdjfqbU+LlGLap0Jw0zB+kvYffP6ucQqoc564BIEaDU+9fhFnSeHv1r8U+nnGxXVjJOrq1HbvRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qS0PbME5; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMTMo04+hNwMkiPJN+O/mBeOBALRzenfOtK0TqTkro4XRYWBBVdyuZqVTgqp9HRXKzikUhANnvkB4ClfMO7HN70BiAWwF/JrC82mTnQi+s8QYgRWrjZtIOtlfpgL+qGZ6XX25GFYvEqUhZ/ifDdpNYmLA0uw1ErqRZNItNNsPkua6qH5HhbAHbfg4EcTFsqOfDB4Zhf+MsWoHHXvF4wttMRbU5E4Mwm/ynFkZnIXjSG1qASTIZXY7WrYWYBnv6ZvFH0eDhPPSfuNegNoKseHMp2rQLIDyW/oMGqsznlbqJq7aVA0tEMR/vmggsML7dA537q4A9Wc+kO7e1ut1W4xVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5NFcHlvmZJMpvttoqjYe0wlelHsnqWm5c09idBRWOs=;
 b=O3WRdZ+dotn9Ylb2oSMaNynydSqn2rb7lNj7Sp3br6O78wiALVk1S9OyvOchv07f2pvNelLLiyG4Nj8Qi5ACQh+ss6AJtlFoIP9SN0Ke6WSUQj/CZ9UHMxf+D9eIpSXQaa+/Lykg4wvMQVXOTQ3MpyCWcwtkLYiPxOxWtdSc0dDsbyjz0JGBgv+nuX9txoF/0q+Qtx3OCMsnx5IUktBxiCwODc0Q+2m3oliNFfKeAcdyNKV3JCwhzCULnKjsV2yESR1AJSrmRZvu2Ey2w/ishcwzSOtiuycMfGjAWj7akA8VxE3WVVd9jtLXcksFwF64suYShDVxsUhjiKqqUzZXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5NFcHlvmZJMpvttoqjYe0wlelHsnqWm5c09idBRWOs=;
 b=qS0PbME5Q0JzeCeadDI0TknPRJJKTSeqkdNmAwcMECCqSjL30Hnm2ykLEaj01dZnvhfEAySbsZrAvYOA91SzgGhE6NU79/yZ6ZRWjdWaVbisqmshqxwlxl7xiQALpnB4L8P48JXeYHj2dX2w0tthF35hDC2s1d5B658OW1NspHJwLKkGY6YZrfeq0S6qyyvQbrs3b5CpSjpjyD4ZWbVB3zNgqIUDm3wV5meYNtOLzcaWsNd/aHn8HvIbnKBm6Fe52Ifqb6Mrp3u+5TXd4QGiYuOWprmpjKP5JXyl8Dh/p8ZRceAfsC9rhlILkXWQYmhRUiwkmxpjWihacM8KHjrlfQ==
Received: from CY5PR19CA0069.namprd19.prod.outlook.com (2603:10b6:930:69::15)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Mon, 16 Dec
 2024 17:12:46 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::25) by CY5PR19CA0069.outlook.office365.com
 (2603:10b6:930:69::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 17:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 17:12:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:39 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:35 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/9] net: fib_rules: Add flow label selector support
Date: Mon, 16 Dec 2024 19:11:52 +0200
Message-ID: <20241216171201.274644-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: b1147064-f8b1-4cd9-8851-08dd1df4dca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ymv84bIn4a1HjmViPE+fJLwGgwS+xcLdQ0Te4Csy+N0YBIiuOt273QrHkYcZ?=
 =?us-ascii?Q?BoQ2HDPWpKMPfUbxdoyd1+Y70gg8pitTAZYUMmSEN6yMbuabv7nNIzKEkwrI?=
 =?us-ascii?Q?8hAyO+5EwbTMSpdHcNu48ZJoelWOjh+v1u4AHlDPWNrFRhG29Y45VLPNvbNA?=
 =?us-ascii?Q?KDVDIGUjzxyQUvsBH3r9Wz/Kl5mGTrrkSWxiLPI3B1orCVn3uGflORjldmRn?=
 =?us-ascii?Q?XRU/FPhsHfaqQJn5+T2jnZ2EIhZXuS4OMsKfi4O7QsrBhxOXGCmNoksGNFOw?=
 =?us-ascii?Q?+yxmrhWHk6Hi5ugW6MdbgjEuNacxqg01+azeBL5eiOnZQuwG57w4B8D5b++6?=
 =?us-ascii?Q?e0QzgQNmzjV1egqovjMv4FsNF95OINxJAbUrCkPDTVzCCqae+3F5BZ8cT/DP?=
 =?us-ascii?Q?Ba0MnDr7Vss/wgs8mwD7IV1uOAWgHAeYOjL7Tgo+g8kq0Owh8X5BZANRgyZl?=
 =?us-ascii?Q?LTailamWdAHgLGJz/Fw3oR+giAoE6fQFhPkE+mJElUcTJkm+VZJjiYRu+vQM?=
 =?us-ascii?Q?8Ve6gkyFDLkCiiQIUGG81JrzVEpFKd5MYsZpAG7s7TVtAND8yEVZqUeTGrnC?=
 =?us-ascii?Q?0FspzXSjM025kCdwj5/U6bRN+KCbw0cd681cAXWsXUH6SwJ+Rjue5NQ+Is4l?=
 =?us-ascii?Q?FyeaWS/NCj2hyJdLCnBpyaVpvKqKCb6CEtPGV2QISaF/Lb59wV1UxF+QRU02?=
 =?us-ascii?Q?EIY8lQmJbBLNX32uz8T3Dutxxb1133o92z0H9+qBAzu7S/b/jAEJ27Y4Q15p?=
 =?us-ascii?Q?oDUGprXq/bKHro8Z/Lu1ti9xAA0+gio2Ey71Qh1nwGPRdGj4NRpkVhp6nDkA?=
 =?us-ascii?Q?nV2k3icOm6B+nsQLjmC/tsFAESyiKLML/R7J4oPLR/vSYZOsdUTh0FkDwfIM?=
 =?us-ascii?Q?qr4l5ZUWJWjVqGj+fU73z/87q02l1sUYoZmnyL5Pmac9Dhimz9krkl+U41bC?=
 =?us-ascii?Q?MkqdHa4QfRsVQGOKi/67L5EqPMo12z0XeFW5oGIVQHWD9O+t6JUSLzCN/S9i?=
 =?us-ascii?Q?7lHBZbUEtQSAE+x+IA1Uos9NFbh2V8DOnhbCCer+IPdAIDFkTarBU83UMtzw?=
 =?us-ascii?Q?ad1WG42+CM7NHfJB3+33N4oxNhCosgBewiMEBAjLZJOf5Edaia4JwPh7zXOR?=
 =?us-ascii?Q?iQH9fONKrJohTW/EIk2GYhFTRj63x5LMi1tBy3O8ILGMDGCc9D/JdCbdK0Qr?=
 =?us-ascii?Q?russ/oQb1Kntj3M6bN5I7+6GC9+LxruCa22z/STGgJ06A4uDP8r8uS3Dgjup?=
 =?us-ascii?Q?5zdFnwD+pVzyHcHptM5z6VS9RGjmOlaNLAheovJEaYD9oGdEmGoYu/ru81gc?=
 =?us-ascii?Q?orS9WqhH3Z5mPOYo7AASgB+KEpY4QWwJBcupNSNQH4f3c6r+86Mn8lzkzjlf?=
 =?us-ascii?Q?WqFUivtapsvE+unH0s83Npgi+oGMjsBGr73+h4tMr9v81Q8wgf5HwFicccyb?=
 =?us-ascii?Q?71aYDW6BVu6s0CFNFWZGWieHgsP83B2uvGPVoEBkl5jW9ELg5ugK183/eI9u?=
 =?us-ascii?Q?79m2M5tbAT6T8Wk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:12:46.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1147064-f8b1-4cd9-8851-08dd1df4dca2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116

In some deployments users would like to encode path information into
certain bits of the IPv6 flow label, the UDP source port and the DSCP
and use this information to route packets accordingly.

Redirecting traffic to a routing table based on the flow label is not
currently possible with Linux as FIB rules cannot match on it despite
the flow label being available in the IPv6 flow key.

This patchset extends FIB rules to match on the flow label with a mask.
Future patches will add mask attributes to L4 ports and DSCP matches.

Patches #1-#5 gradually extend FIB rules to match on the flow label.

Patches #6-#7 allow user space to specify a flow label in route get
requests. This is useful for both debugging and testing.

Patch #8 adjusts the fib6_table_lookup tracepoint to print the flow
label to the trace buffer for better observability.

Patch #9 extends the FIB rule selftest with flow label test cases while
utilizing the route get functionality from patch #6.

Ido Schimmel (9):
  net: fib_rules: Add flow label selector attributes
  ipv4: fib_rules: Reject flow label attributes
  ipv6: fib_rules: Add flow label support
  net: fib_rules: Enable flow label selector usage
  netlink: specs: Add FIB rule flow label attributes
  ipv6: Add flow label to route get requests
  netlink: specs: Add route flow label attribute
  tracing: ipv6: Add flow label to fib6_table_lookup tracepoint
  selftests: fib_rule_tests: Add flow label selector match tests

 Documentation/netlink/specs/rt_route.yaml     |  7 +++
 Documentation/netlink/specs/rt_rule.yaml      | 12 ++++
 include/trace/events/fib6.h                   |  8 ++-
 include/uapi/linux/fib_rules.h                |  2 +
 include/uapi/linux/rtnetlink.h                |  1 +
 net/core/fib_rules.c                          |  2 +
 net/ipv4/fib_rules.c                          |  6 ++
 net/ipv6/fib6_rules.c                         | 57 ++++++++++++++++++-
 net/ipv6/route.c                              | 20 ++++++-
 tools/testing/selftests/net/fib_rule_tests.sh | 31 ++++++++++
 10 files changed, 140 insertions(+), 6 deletions(-)

-- 
2.47.1


