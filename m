Return-Path: <netdev+bounces-249775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE44D1DBE2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A13F5300D918
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA21538A297;
	Wed, 14 Jan 2026 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWbSOdkc"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F656389E16
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384554; cv=fail; b=SzAj9xabqSLD1G0Xelk8ocb6NoEXzse1PaDcgPpEgvBBNdUcRjovewUkoFJ3mObbiYVqTyfvARq5RktzJhk3cIc5Z+G9OgchhijR5vhb0RmwbKtH60tMCeJCsrFLWDq5kWbznlEoZmUIeWmcXAM4Yg2M3BqhndWcFi+aM7XCYZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384554; c=relaxed/simple;
	bh=CpfUkZ+pjVWHx5Z9knAvYSg/NQiBKyJpJk5ooOFNwIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jGsyZpRL3LS6jBSuko1CThIohPadCIYSgnHZk20PmX6jEynxtQPUjx9kfBeZZtmKH7XhV2b8+wEIvCqk0171MBZem+AqfL29Dh0rEs2zdUb4a8qnclvJpdI2qAqf4oRthYqHGMCFoFO6CAfYuKc7+TQgEPa2TeaAH9b3Yl/imow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWbSOdkc; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yb6aQZgwjK17511X5FXaxqcLC66LIOtnF9A1HNH/n6qEIsfOHdfvvlxsDDXMh11so8uKpjRqRWymywz8Jmi1rChj3KvCISqg5xLhGiGeiLYZSTxUHh5sQO4HK+kUNKs+bB7IqteRvfaEzN0yffspZqJzZrBv3cbSdVysNZh260Kvc1VA/UGu3ko0sY7PQ5axyP9fvTcMQmatRa83bHEvhgB8cpjh0Oigx6qj25v4SyqtNq9Ng6TW/437ZsOY/MeoAL7zKoafGnf773qBwBopTU8flRNr3YuIZp4jX00ISpBU/yo298EW54AF0T4OkUruJ7F2gSgu81EyR+wpMKasLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/VcyFpNqbqqZGzVfsQY0yCDyVJjgtg4R21Cjwpd7Dc=;
 b=XGYTPkVTuxjZ9cndDwifbWH7vmEZ03ZEPvpXxC2xuoksvuXEvlNNySHDZnQF7W6E75HVIwYVjfYf8Wdnr2Qv6/SO6lkAuvHqDyDWXHSRrodqj2D6fEmmvBkCFoGtO+9qULGpvrfqeSb2p90kR2jb9cRPAtNyfWf6JmReN4f8FCBgg/KZBTazRbD14maeGx1vIYzIg3fIN9s3tQ+D1VgzL7Ef/ZzQHLE9AhZMyqoTqN4AkJNJkSp7YXNzJnKkndraveEEIgzAUZLzHNhCa7CNCN+S0pu1Ei1yXtmKSVdwZmXAnRg/l5YyRUomJ84Y8ogszlo7BVkDcN4JLUQIpl9W8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/VcyFpNqbqqZGzVfsQY0yCDyVJjgtg4R21Cjwpd7Dc=;
 b=fWbSOdkcM6aU1kr3mDYJoIXiMdjzBn/Nkxe6LJ4ZBJ4waPexFiwVCY6LbbJmlKH4cpc16bZx/tLRgNBUNVUsGJ70jcnPr97Bgw9MpWFPdwwt5eG9paKhsZ3ZQaJWxbJhfpBhKC5Rqj2nUJ6mbXSptLbl8trg63wgEYAOLP9xtsGkE6r7Sz0NQ0bT20HOyidNCq8YYGUyXPqE8oxYHLnenXNBXderWW3dLd5BonCKRCDlGV8LPEfr1zb2mRqe6K+iJc8MfoOrYjdwdr4bRahwRANzwZ8Hx7v1E3YPy2qwij91u4x4yC7urG6uT8pzLq3UicL6u05OZ5sLEe+491faZw==
Received: from CH0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:b0::22)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 09:55:46 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::14) by CH0PR03CA0017.outlook.office365.com
 (2603:10b6:610:b0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 09:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:55:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:55:32 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:55:24 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 0/8] net: neighbour: Notify changes atomically
Date: Wed, 14 Jan 2026 10:54:43 +0100
Message-ID: <cover.1768225160.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: e66cad51-faf4-461c-9f5a-08de5353168c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llJVSuh5ops3Qix5SZGhaEuUS1nX18ze1VOYDWe8GIOjCnzMghZ1xgKinYd8?=
 =?us-ascii?Q?iLGaQMohethdD7rUTprGGMhnWlfnzrpSgDm2IaQROdE10kIoWnC7FhYh0eZ8?=
 =?us-ascii?Q?MX5Eo9z4S8/etjGDn0xW8alH8CzUmE2CQIc0CQjL+tYWdlT1v/3jzrySztav?=
 =?us-ascii?Q?Z69Ydmvnh6UJPlzstR9UR9tM2HzjHPTx2whtSFNPTyC9Qc64btxG59cWwLZ0?=
 =?us-ascii?Q?X5m8nEyhMMMMSj4805FqBULYY21L7kL7iEzIxERUpxXJMw+eTxDmXBFZxW6F?=
 =?us-ascii?Q?JHq5SgMauqATgUcO0BvTn51doVA7EzjimeAb6/M4GxyrUxVdOAgCKAQcQie0?=
 =?us-ascii?Q?WKA1JWIYb6+rBe3sHsiZVukLkxNvPpkwWFq+hvaEfYHk3rJvHHarQmr+Nhqi?=
 =?us-ascii?Q?RXN3/aZYTCzFSWLQc33u0Ttpmy3w8LmZYz6QhqiUEljBW9pJsAX/JhE/ELbw?=
 =?us-ascii?Q?qTijpLD0cUIGE+WRKj7z76qPiysSyCZPXHO1+vFYWFGXlp/cjMnLeQIhbHlM?=
 =?us-ascii?Q?V9V/v7QeoFMmIZspkgJ9LnUnE+9nt9ZRCpzRh1FyZXtsUOCE8BOJQumNDbH3?=
 =?us-ascii?Q?ejIZs6zO52xCCXWNCCRgokiXqy5LX7q3yno8nCl/cnvXNBNOQdh4fdu6EML1?=
 =?us-ascii?Q?PtqciTWWIr5Z72nlh7Ht9wOMuGQYL4gB7dQQf4pgdabRQl0pPw+5Popyhymv?=
 =?us-ascii?Q?o2gz58diSX1Q5ibgfiq/mJOTajFOuMIi8gKO9r+A5Ul0ecjQCbQpYoArWE7x?=
 =?us-ascii?Q?EpUtAA1fyLqIE0Rh95N7Gib3bhZ79p/969FfT6qdSJRoFKTnY6Q84uAVaRlj?=
 =?us-ascii?Q?0/SQEfVhHNpTwAuC3dXsCjtFDEe76QwynQNHIdHniCHEYXG/uuAcqgowQLok?=
 =?us-ascii?Q?iX+IbHasV8J8Ekm2XiZU/NhSxj+ctJcBz8JgP9VsThbqaBOmRjVdZK8Gn4Qo?=
 =?us-ascii?Q?et1icI6Bw6Lb0gr9lykITw2Xbpwz7ahOAfmzmnH8SjdofHZgkvUcm8qIdUdz?=
 =?us-ascii?Q?oRtQHCbqcKofr5AIfF5SsRkyRn+0YadZhYibRpQb2ES8CqVY5OpbWg7EdX0N?=
 =?us-ascii?Q?KSSbFiwtFsg5B0ohfo1XARehY+ZLuKajJnj/+4emT66xEa2kqliCCoQbTzO2?=
 =?us-ascii?Q?/378dZYCeHqChbpiSQdCPRte3DXOtxUfu3xHxUoIi2p7aykfCqji0gz/sqLb?=
 =?us-ascii?Q?cygS43ALVVa1/Edl3szD+NgqDdV2lcInUpvSdy4t/B4qJhlak/P2vw84jse3?=
 =?us-ascii?Q?W2+/iA3rFNVaUk3CadvSm2mnV2uHQkQ0Bi7HbRRKaXATaYheRPspTMfsqeVL?=
 =?us-ascii?Q?sdH5bDi4ilIOlN7TW8GlDl7HNfF7ml0FwPKXJXywJGkCKP3pMxb9Krtjq7KR?=
 =?us-ascii?Q?JT75BP4Bd2hNdSg8xEeZFqpw9ZZJu6exOfUAls/q4T4ojbSVS2PEHJgeLd7Z?=
 =?us-ascii?Q?P/jZHZ0/aeQSS5lNrIhTH2H8D9kt2Vtk0jurPZyGs8SgDgJOXzoz9U40PXVg?=
 =?us-ascii?Q?cJVH9N9Pkr/9amc9XDO2HZPeHQe1g4Y6nY9R1XV8S6rgJNCsZn6TVmZXYNwq?=
 =?us-ascii?Q?ilBjbhsL6m+UdxxnN2o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:55:45.7359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e66cad51-faf4-461c-9f5a-08de5353168c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

Andy Roulin and Francesco Ruggeri have apparently independently both hit an
issue with the current neighbor notification scheme. Francesco reported the
issue in [1]. In a response[2] to that report, Andy said:

    neigh_update sends a rtnl notification if an update, e.g.,
    nud_state change, was done but there is no guarantee of
    ordering of the rtnl notifications. Consider the following
    scenario:

    userspace thread                   kernel thread
    ================                   =============
    neigh_update
       write_lock_bh(n->lock)
       n->nud_state = STALE
       write_unlock_bh(n->lock)
       neigh_notify
         neigh_fill_info
           read_lock_bh(n->lock)
           ndm->nud_state = STALE
           read_unlock_bh(n->lock)
         -------------------------->
                                      neigh:update
                                      write_lock_bh(n->lock)
                                      n->nud_state = REACHABLE
                                      write_unlock_bh(n->lock)
                                      neigh_notify
                                        neigh_fill_info
                                           read_lock_bh(n->lock)
                                           ndm->nud_state = REACHABLE
                                           read_unlock_bh(n->lock)
                                        rtnl_nofify
                                      RTNL REACHABLE sent
                            <--------
        rtnl_notify
        RTNL STALE sent

    In this scenario, the kernel neigh is updated first to STALE and
    then REACHABLE but the netlink notifications are sent out of order,
    first REACHABLE and then STALE.

The solution presented in [2] was to extend the critical region to include
both the call to neigh_fill_info(), as well as rtnl_notify(). Then we have
a guarantee that whatever state was captured by neigh_fill_info(), will be
sent right away. The above scenario can thus not happen.

This is how this patchset begins: patches #1 and #2 add helper duals to
neigh_fill_info() and __neigh_notify() such that the __-prefixed function
assumes the neighbor lock is held, and the unprefixed one is a thin wrapper
that manages locking. This extends locking further than Andy's patch, but
makes for a clear code and supports the following part.

At that point, the original race is gone. But what can happen is the
following race, where the notification does not reflect the change that was
made:

    userspace thread		       kernel thread
    ================		       =============
    neigh_update
       write_lock_bh(n->lock)
       n->nud_state = STALE
       write_unlock_bh(n->lock)
	 -------------------------->
				      neigh:update
				      write_lock_bh(n->lock)
				      n->nud_state = REACHABLE
				      write_unlock_bh(n->lock)
				      neigh_notify
					read_lock_bh(n->lock)
					__neigh_fill_info
					   ndm->nud_state = REACHABLE
					rtnl_notify
					read_unlock_bh(n->lock)
				      RTNL REACHABLE sent
			    <--------
       neigh_notify
	 read_lock_bh(n->lock)
	 __neigh_fill_info
	   ndm->nud_state = REACHABLE
	 rtnl_notify
	 read_unlock_bh(n->lock)
       RTNL REACHABLE sent again

Here, even though neigh_update() made a change to STALE, it later sends a
notification with a NUD of REACHABLE. The obvious solution to fix this race
is to move the notifier to the same critical section that actually makes
the change.

Sending a notification in fact involves two things: invoking the internal
notifier chain, and sending the netlink notification. The overall approach
in this patchset is to move the netlink notification to the critical
section of the change, while keeping the internal notifier intact. Since
the motion is not obviously correct, the patchset presents the change in
series of incremental steps with discussion in commit messages. Please see
details in the patches themselves.


Reproducer
==========

To consistently reproduce, I injected an mdelay before the rtnl_notify()
call. Since only one thread should delay, a bit of instrumentation was
needed to see where the call originates. The mdelay was then only issued on
the call stack rooted in the RTNL request.

Then the general idea is to issue an "ip neigh replace" to mark a neighbor
entry as failed. In parallel to that, inject an ARP burst that validates
the entry. This is all observed with an "ip monitor neigh", where one can
see either a REACHABLE->FAILED transition, or FAILED->REACHABLE, while the
actual state at the end of the sequence is always REACHABLE.

With the patchset, only FAILED->REACHABLE is ever observed in the monitor.


Alternatives
============

Another approach to solving the issue would be to have a per-neighbor queue
of notification digests, each with a set of fields necessary for formatting
a notification. In pseudocode, a neighbor update would look something like
this:

  neighbor_update:
    - lock
    -   do update
    -   allocate notification digest, fill partially, mark not-committed
    - unlock
    - critical-section-breaking stuff (probes, ARP Q, etc.)
    - lock
    -   fill in missing details to the digest (notably neigh->probes)
    -   mark the digest as committed
    -   while (front of the digest queue is committed)
    -     pop it, convert to notifier, send the notification
    - unlock

This adds more complexity and would imply more changes to the code, which
is why I think the approach presented in this patchset is better. But it
would allow us to retain the overall structure of the code while giving us
accurate notifications.


A third approach would be to consider the second race not very serious and
be OK with seeing a notification that does not reflect the change that
prompted it. Then a two-patch prefix of this patchset would be all that is
needed.

[1]: https://lore.kernel.org/netdev/20220606230107.D70B55EC0B30@us226.sjc.aristanetworks.com/
[2]: https://lore.kernel.org/netdev/ed6768c1-80b8-aee2-e545-b51661d49336@nvidia.com/


Petr Machata (8):
  net: core: neighbour: Add a neigh_fill_info() helper for when lock not
    held
  net: core: neighbour: Call __neigh_notify() under a lock
  net: core: neighbour: Extract ARP queue processing to a helper
    function
  net: core: neighbour: Process ARP queue later
  net: core: neighbour: Inline neigh_update_notify() calls
  net: core: neighbour: Reorder netlink & internal notification
  net: core: neighbour: Make one netlink notification atomically
  net: core: neighbour: Make another netlink notification atomically

 net/core/neighbour.c | 147 ++++++++++++++++++++++++++-----------------
 1 file changed, 91 insertions(+), 56 deletions(-)

-- 
2.51.1


