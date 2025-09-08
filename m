Return-Path: <netdev+bounces-220714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD0B4855E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B51F3A436B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683872E54D3;
	Mon,  8 Sep 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIENWwjm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31F1D63EF;
	Mon,  8 Sep 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316906; cv=fail; b=IUBqTPjemnZxio4XAswpAsE+DB3Xjhwgkvk/EOgU7BcFSmU6BGthHzVagAeD1rPsPTgsBG7hc8dl0dM5GE03kkeH+LYCafb00igN/lk95Xe+Xx/zQ6qPopZdWjGjTx5te9U3v2Ur5yrnZhz1ymGJAXpRZsTOK1bsOpZNlTAghxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316906; c=relaxed/simple;
	bh=+dE7iC/v/tESg6Y/I8w339BC3tuFrw/QLEAzrMcrEIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zv2f/gh/F4ohvOZjHMAk122Av8MRl9VVHhXat/FNKkdaao40VPWhWwvAEHOlRQJbl3IDXbGSZyU3hwDjPyBvqw2XnrZtmeFN5RByXvZAxFqfPrELPg3iguc+TpqF+hYeLuTRwx0O/T05wLsDnXNCYgQYp4YRQ6ul6jJJuleTL3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DIENWwjm; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXnJu1Dpr166dVDmdGpFNC7zVf7Wx6vrzhtandji+rSa4D/fhBVgD71ROyPy4xoraFbQpgn3rzoTsSLkZtZIjZcnBB1QakZVYJKxTSlMXEs1uwUz0Ir/B8sHhYPaG/JQifDNoi8DqmI/vgo6z4QyQpgRWy9udkw9eK9SLx0j8pKfdtolADY5/xtUNoQaVStT2E1bocfIIgckBVxaphN7fcdAtZgJaKkgEpeqmVHeLube6ceAEJQu+ARQe7okKOyoG+VNr3OfajBfK3/Z8SSi0FQWSpxJPo+oAD8mUak6r9moS8y10NJZkjEM9kfJfkH/aOaQYk7ByZQHM8wyfKYsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuP6SkTxnnh3je/2hCja0DVUT7ngpcBsRCFw3TP6vbA=;
 b=tg1kPBw720gEjSgZhI5ux0GxW3n2uGSjb1JfTycaCcAxer9KjW86cmVXh8uI5SHVocypLaxz0A33sUuA3T2lfUsGpepBvaw/AjnYCdtekoCLW/oXagRPYxMK1xN3fQp3M6JcdqzhmwgW3gs56cHujFj5sekrDEb49xz6X6TN4JgYH1UZL98dWBPJeWEMQDZndUtr46Ac/ihESWe81F/4uvkqsmWrgGW9ytkonqdRL6Ey4q0lC4F6io0OKDMMl/StUyTRFFQqDQhwEGj7Jy/HtQxzoUB3PKPVKKfdc2V9r7dE8n6cAa9iA74Iy1DSnSvmPz1XNAzYCvLZICbNCRW8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuP6SkTxnnh3je/2hCja0DVUT7ngpcBsRCFw3TP6vbA=;
 b=DIENWwjmCZCxAxAs6h+V8zCs5EhcWjrV/R7ToRS+i/4A0BWqd/cbe0rlsgwk6yFpywooq5yAyEyzL4vF7vvIgUr4P8CV6nf+Ni+GkarIcdBQdAUe5bMPjdbkVb4qraGzTBwNOFPi8RJ8+xNty5fMwWKF9Er+sYbVeS65u1QvI3e8RZt+0E/zriQpM1+RD3+qsLrFZsuvxrg2RsLrAS+nki3ah4VmCpzkD1r7CIGinb1c2FYAOGPfxDj7iadyE5bEv/vVqS1Sd8yI5rxme+mp7ufaFO9LNl3bWYtQGgjIXwPWIELnmkMxgfEafzEvjwX4z9KolExk/DWaNvPwZqkZYw==
Received: from MN0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:52c::15)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:34:58 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:52c:cafe::e2) by MN0PR05CA0016.outlook.office365.com
 (2603:10b6:208:52c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Mon,
 8 Sep 2025 07:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:34:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:40 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:20 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 0/8] ipv4: icmp: Fix source IP derivation in presence of VRFs
Date: Mon, 8 Sep 2025 10:32:30 +0300
Message-ID: <20250908073238.119240-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: d6122446-28c7-40e9-ca08-08ddeeaa36c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UK2yL58odqKeRtydZcsrcvlo7F4CxfoNVzYmBdyn96eEpvk7EE9sEUrRycKT?=
 =?us-ascii?Q?BSoSBCzYvcWuGPSNt0IBPiiXv1UxBN+M9deq4DopPSsOAjlfUWl5R+1o8era?=
 =?us-ascii?Q?wvWustOuJ+dizcjzjhVe3SXI6Lpc9AGdVzrQ1MTWI2nhordXBsmGrrWg3iQO?=
 =?us-ascii?Q?0zJG+0fFWk6DbRIS28duRu7S/8Os9LelAQZKvLbxfNncVd1jlHFEy87brlJN?=
 =?us-ascii?Q?X47yz83XqdtPkYgAeK2LmrsFEB5aBC0INmuGczC5RAk79q7eD9N85nEM/nWV?=
 =?us-ascii?Q?2ZX7pjA8LMRq6mVSx0G9ZHtImS/c9GFgkr1+ETLLz3ORcewhU7f2cI2zuIc+?=
 =?us-ascii?Q?6y6f8RzWvK08hr7g6Yh8JC9LMIeSEzemZSusNWF20Ysg5VC0PwBZUMiEbUis?=
 =?us-ascii?Q?viXVrjfqL5BdTkneq+Eh4U0DeGJNy4S3s2a3tKe64ioDhNbItQ3fktjrrj2f?=
 =?us-ascii?Q?5dBJpEV3ztzlTrhntgi02cNLUhZjyXQXyMeoERtK15nJzJCeB8Y4YOrIh70U?=
 =?us-ascii?Q?RG9zWJ13Oh6Y6PBCuNfLVEuLAnVJE/azQYD3gHESt+WlTTxS7CfJiWco5WN7?=
 =?us-ascii?Q?Uef4tJBsG2LO+C+AYATa+tJawX4MIsW8lLa4DyIApSmVLiGWPXuLQhe7mJJr?=
 =?us-ascii?Q?qAv4F9Bx1nv3vrka0JKbwubtCaJgu7ZwwfKmA6i0jJCs5UGQALyvsXHyqbNU?=
 =?us-ascii?Q?kKEs4T7cbAUEqbRt4ErrDXPRIXPoI4cHSTzWXg4VQGuWIZTsiqSarFlV22j8?=
 =?us-ascii?Q?Gayr9rnt5eT9k/GBQ7x+caYSEgQBeqBJhhFZCSZXTJ1/p1RT59tXb2pdVnjU?=
 =?us-ascii?Q?jd2/+PWBaJIRV3FnocwRr+GqzS+hIx33viwDusB0kxh8lhmwFcWlen1Z9BAq?=
 =?us-ascii?Q?GTTYhh9A+GrUdUHYThYVOCCejDCS+y/qBiotig2IiRCaOyzU8fpoQSO9j+aa?=
 =?us-ascii?Q?5mJXe6PzRqcE8q7BlieSBUo7kMmcGCUQbD3vKg0v/yR8P/wycigvkir1ENJ0?=
 =?us-ascii?Q?aWAgcjjiJcsg7mnhb0EIUSKSnxN8Ko9fJK03JG/w2ir2wJlG3WpvAvQFwVea?=
 =?us-ascii?Q?TKVGxoN7CNzx9MItHzWBre9pJgoWsSvcuhTAYoSjf2xFYcuktN9uypePdqrX?=
 =?us-ascii?Q?1zxxXRDub640NsX4kHoaqcAGUku2HdOYBBJGyGaMc3i9TLxw4UbsvouB+fZX?=
 =?us-ascii?Q?huovwoSOaAD7a5lI9awj+nQIIKTYEsZbC4yKouTG2DJpE+uzt0L0QmxoaEiZ?=
 =?us-ascii?Q?wthgfnVJ3XJZ44RFjS7w2yAzv+OEmuR6dQCaKX4JZ/Ash9wUK2GKxkN+Ylky?=
 =?us-ascii?Q?gbIE21KGchU2SLN91Is0o9nf4dCFSmf03B3qIxf7RCJYi1wGNPB49s0rYfcc?=
 =?us-ascii?Q?ttbhOUSFOUF7mjqfG+gZdm4fhw/CMkVwASPBI9XcSPVKVbo7Kj0yzYRPHm5W?=
 =?us-ascii?Q?z3HaVDDihYGMwJgeveJaCWOgdhvARVrXNVUD0R3/WhpUGwH2rSvRIDbxQG3C?=
 =?us-ascii?Q?7lt2OLJHUKIv0jSaErHJjttGoe8XvpjtIBIaGdIv8ctbUyYeVCOsowFakg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:34:58.4797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6122446-28c7-40e9-ca08-08ddeeaa36c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270

Align IPv4 with IPv6 and in the presence of VRFs generate ICMP error
messages with a source IP that is derived from the receiving interface
and not from its VRF master. This is especially important when the error
messages are "Time Exceeded" messages as it means that utilities like
traceroute will show an incorrect packet path.

Patches #1-#2 are preparations.

Patch #3 is the actual change.

Patches #4-#7 make small improvements in the existing traceroute test.

Patch #8 extends the traceroute test with VRF test cases for both IPv4
and IPv6.

Changes since v1 [1]:
* Rebase.

[1] https://lore.kernel.org/netdev/20250901083027.183468-1-idosch@nvidia.com/

Ido Schimmel (8):
  ipv4: cipso: Simplify IP options handling in cipso_v4_error()
  ipv4: icmp: Pass IPv4 control block structure as an argument to
    __icmp_send()
  ipv4: icmp: Fix source IP derivation in presence of VRFs
  selftests: traceroute: Return correct value on failure
  selftests: traceroute: Use require_command()
  selftests: traceroute: Reword comment
  selftests: traceroute: Test traceroute with different source IPs
  selftests: traceroute: Add VRF tests

 include/net/icmp.h                        |  10 +-
 net/ipv4/cipso_ipv4.c                     |  13 +-
 net/ipv4/icmp.c                           |  15 +-
 net/ipv4/route.c                          |  10 +-
 tools/testing/selftests/net/traceroute.sh | 250 ++++++++++++++++++----
 5 files changed, 229 insertions(+), 69 deletions(-)

-- 
2.51.0


