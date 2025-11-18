Return-Path: <netdev+bounces-239592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC3C6A0F9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F634EF42
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A59433EB11;
	Tue, 18 Nov 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KDVo8kie"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F62D641C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476766; cv=fail; b=DMCm+7i2DVx/aXXFWjqOL8onAA6k5ogFf1x2RqnYj/pfls0TS84qzi4Uw5Kh9afjJEoDIvf0jr6n6BEjX/UiYpPHKTXio00qJB3K957ginBe01m1CJASZCASd2B+NZeB75HVr+vynocnxQN08y7HJ5ASwyJri0k1F7FGXphF63M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476766; c=relaxed/simple;
	bh=Bs5Lnk5crbZpgHsNC3zrarmMr8AglNrATYXqfR8MDDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q5dH7hwS90bBo4dZ6eeH8fv01O6kQp3gTU+z3UJvZkULr0gRzIYUspKSuxldjfoNkup4h93CqF6f9OIURrCY3HLjucF4R7i6k4T1eDPiVipqGYyDyk3M1dUCa4A7Ocwy0tdc4qFo5PAkaayWJYTchFYcn19/KgN+mdZFgDKgmbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KDVo8kie; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilaPP9zLM8k9z4R3MBelkLMoccYU6mFshjBwOUrz+itL76fgDUwoWGZt2c1Vf2y3g1wMq48LritIbObdzrf0FoCVXy3MD58Gfy7Izj0VpKdDwXhh33oZLcagpl5JOudTJ+pM65H5THpXY4p7wYT9Y7gBn4LLITeMGt/0CJQ77NuLJ3o2Uuis2IdTS/g60/LL6DBVLn0BV5HSE4MN6ytbwurWa1qKvn43ZPSSWIIUyzPcp8gmUgRXvZY3tqBcUvdQyfAHCz2AW+m9Us/lmoSoWYmJSd9/RkqdvqcitQPNu/VnON7ba3hn+wNgqpVqx7MpwujEw3kF0+6spKNxiz//eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CicDe0LayDg1GPmbNzrXAE9j93e2BXISJSIurk5hinw=;
 b=lOUQxpnbH7jZpT3nNVQgkspAWvg8HmxLAQtFO3kKgkOqTtpf4iw8I5BNJ9hzAGmVQUUhwXxor5+RNxfjJQEWY8HqiX6b5qicRgtSBEGLdLYirvfmiSNRb1Nod+XaZwloypPDOMliCqMslJSOZB5WDKMWalVS6RYHIXo7VzIhwgJYs5xGHYbKL/KXSnIWjXnmqM3MqWJZ8LU/C3zqIVSCuoDa19itK2vIxJmPrFHTJuaHEt5/8nPRyqovmbX3PNGwMtcETJXB7MlmP8AxU5ccS6VBqmzq6AbTlDmz6olHeebP/U0LpoQ4GZmLyL6oaQdxqvZgGbRC+MQurDzZsqbBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CicDe0LayDg1GPmbNzrXAE9j93e2BXISJSIurk5hinw=;
 b=KDVo8kieRfXzyZdKj+SuYqKXMMxf9nKYJfq9hDaNK63mkVhtvFuZw/K1Z2Oq6WCjzEPE2nRw7aus4CX4a48rlaxjI701aIHA6KoONG+rv6NiyA20W7pf2tQHAigtQ5WYZiHMB6DVPpR9OH0vBD4hFd6LeSQFxCKVvYRYGe0lEEX1U5IaTzPWWZVWXyn36S0ro7MYal9Q6h3o2yClaqwBXuyRG/AVMVVsFZ7oOduWy0BoxZNJbstA9/HCpOM8AseV3nf5NdEDAT/8/3SccGX9h4j7tcFzddQoSJOQXn7JTqyed9iSeXbvCUade1rmAVEp91z9qFRfXd89ABMutc1SjA==
Received: from PH8P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::27)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 14:39:21 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::f7) by PH8P221CA0034.outlook.office365.com
 (2603:10b6:510:346::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:06 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:06 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:05 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 00/12] virtio_net: Add ethtool flow rules support
Date: Tue, 18 Nov 2025 08:38:50 -0600
Message-ID: <20251118143903.958844-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e119188-783d-423c-7bfd-08de26b042d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOEfppMzWrpja3oNdMJCspZ/j/4vlM/x/BMy06VyNqF0pWyXb062uAu2rAbB?=
 =?us-ascii?Q?ZIkD9PrPpzOlDE/tCLAxaQczemG8D6E0xHdvIw85qpVJxLsrrBhD0Xvr+kyx?=
 =?us-ascii?Q?8luqD7mD6S9I6xIE0yApKDeJW7LgwYXd9o5NbrGpn8X3gltid/V54Q8m5FVG?=
 =?us-ascii?Q?1UUrLANrPtWy9uWSY96qIcSNNtTOZTIw6fNNOurK1DCyHe/Dipza4h1Vid/C?=
 =?us-ascii?Q?rN4n4/t5DIv4ZroKs5ZgQDf81qtGmesTAtERN6nzLw7y6BoHOHf0LvVIpv+L?=
 =?us-ascii?Q?8XECkne3fYklHXDsz8Tx6bHLL+SgvCUVUTTlyAQv6kdN4PIVDTxROOMWsTqk?=
 =?us-ascii?Q?KxNQw0xPfE6UIDMvV180GgfR9DcJXw3AbHsh88NAxWcC2lLD63Ayz5HBp6Hh?=
 =?us-ascii?Q?1MURpYD2ylTYhCFeFTcwVSMV5wHGDoZW/WJ5dueM0ucCGvQM33zdDyvpzjTN?=
 =?us-ascii?Q?iVOxGktRxlj2azG8yesaCcLh9jjVqTF2MdWNEiRtX1ZyMiMrj7TPMQ82H4Ar?=
 =?us-ascii?Q?vM0kcGWxKcvltWDz0/kM54Uv+4wkqZiAn8EdU/rDZnO11EQxBSmyEKeJA7uC?=
 =?us-ascii?Q?AkUH+vzuPcBUO4SwE8ussdLhKvcQoRNcOjlwcI6LgFK4zDe585B0RgPmp6al?=
 =?us-ascii?Q?6SDP1hy3aRXgEAyRcvrN8Z/foQzqktBdAdVQ5/YmGIOV3+ZU8rHGi8WdvZKd?=
 =?us-ascii?Q?FpJpdm1aX3Scjd5oxcQOfCO3TjK9zoLGJeZdCQ17BxCjaKzxCwj88ZGMC4su?=
 =?us-ascii?Q?/Zh8rA3r27CSc2bExPs1yEWFYVzhm+5XmkuIfqhh0dqBPf71qFtyvnyDpmfy?=
 =?us-ascii?Q?W9bgaH2ffG/qthBw+hZuWrDt4p1dxn20wchvArSUV+ZmabgOCe4yS5EPFKBx?=
 =?us-ascii?Q?0dTNEk0WCAIY1ovX5m8HfpevT5gv9dvqLkuS4BXmRZcp7sdTR+BgjwzEYQiA?=
 =?us-ascii?Q?yoxR8cBjYnHUIEiofHNJ/+qqPw70/QnVJVGXLzbLjlmAfewUVFmIR6nIFig9?=
 =?us-ascii?Q?AWpeL3FIy05VLikOBzDbfY7Z6y65ORyMdMnGsKmWuY+jmDdWCifxlC8rCcUO?=
 =?us-ascii?Q?7PNHd5FYDoGAIYqDWh9mHIQSCK4PAWtqF+1gr7mlEQgzLF4zeQoIRxYlb34n?=
 =?us-ascii?Q?RW1RaFqfmir752hAU/QzvbaIxvQzNT6CNJJziLWOh1aDmW36IbQCulH1M/QG?=
 =?us-ascii?Q?AA3sTfeu9g1INmOWnJOqtoPYVx5v3LOv6OYx8Zc7oMHuL4qH+hw1TuNC71h+?=
 =?us-ascii?Q?APADaifKHZAPJGcj4ylg75hk/OHKNur/OIXp3OxzYm7CREkvb087IP+omOJS?=
 =?us-ascii?Q?rZMrZe3YU/+ye2ztLp1m5vvJkMcFK87DqAkoRUeXVUpdLtbBaTNtJjY9XUoM?=
 =?us-ascii?Q?UFcmSKLxHQt1leHyLlx2pb/QwyOa5hAXODa7nhVeQoZjnn/ng4x17wMUkalT?=
 =?us-ascii?Q?CkxPQ+oJqEDlxpsbVckdK5GaFpDwJjcsVSHSqSJf7ROETw+RfGDhhr15V/OM?=
 =?us-ascii?Q?4jegiHCnK2LfjMcjbul12+JGY6esEvfiZqoy2eBGBX6RWh6tbzA0PHcAnCwv?=
 =?us-ascii?Q?7RdeuWVNhqz2cVdXY5o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:20.9458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e119188-783d-423c-7bfd-08de26b042d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

This series implements ethtool flow rules support for virtio_net using the
virtio flow filter (FF) specification. The implementation allows users to
configure packet filtering rules through ethtool commands, directing
packets to specific receive queues, or dropping them based on various
header fields.

The series starts with infrastructure changes to expose virtio PCI admin
capabilities and object management APIs. It then creates the virtio_net
directory structure and implements the flow filter functionality with support
for:

- Layer 2 (Ethernet) flow rules
- IPv4 and IPv6 flow rules  
- TCP and UDP flow rules (both IPv4 and IPv6)
- Rule querying and management operations

Setting, deleting and viewing flow filters, -1 action is drop, positive
integers steer to that RQ:

$ ethtool -u ens9
4 RX rings available
Total 0 rules

$ ethtool -U ens9 flow-type ether src 1c:34:da:4a:33:dd action 0
Added rule with ID 0
$ ethtool -U ens9 flow-type udp4 dst-port 5001 action 3
Added rule with ID 1
$ ethtool -U ens9 flow-type tcp6 src-ip fc00::2 dst-port 5001 action 2
Added rule with ID 2
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action 1
Added rule with ID 3
$ ethtool -U ens9 flow-type ip6 dst-ip fc00::1 action -1
Added rule with ID 4
$ ethtool -U ens9 flow-type ip6 src-ip fc00::2 action -1
Added rule with ID 5
$ ethtool -U ens9 delete 4
$ ethtool -u ens9
4 RX rings available
Total 5 rules

Filter: 0
        Flow Type: Raw Ethernet
        Src MAC addr: 1C:34:DA:4A:33:DD mask: 00:00:00:00:00:00
        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Ethertype: 0x0 mask: 0xFFFF
        Action: Direct to queue 0

Filter: 1
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 3

Filter: 2
        Rule Type: TCP over IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 2

Filter: 3
        Rule Type: Raw IPv4
        Src IP addr: 192.168.51.101 mask: 0.0.0.0
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Direct to queue 1

Filter: 5
        Rule Type: Raw IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Drop

---
v2: https://lore.kernel.org/netdev/20250908164046.25051-1-danielj@nvidia.com/
  - Fix sparse warnings
  - Fix memory leak on subsequent failure to allocate
  - Fix some Typos

v3: https://lore.kernel.org/netdev/20250923141920.283862-1-danielj@nvidia.com/
  - Added admin_ops to virtio_device kdoc.

v4:
  - Fixed double free bug inserting flows
  - Fixed incorrect protocol field check parsing ip4 headers.
  - (u8 *) changed to (void *)
  - Added kdoc comments to UAPI changes.
  - No longer split up virtio_net.c
  - Added config op to execute admin commands.
      - virtio_pci assigns vp_modern_admin_cmd_exec to this callback.
  - Moved admin command API to new core file virtio_admin_commands.c

v5: 
  - Fixed compile error
  - Fixed static analysis warning on () after macro
  - Added missing fields to kdoc comments
  - Aligned parameter name between prototype and kdoc

v6:
  - Fix sparse warning "array of flexible structures" Jakub K/Simon H
  - Use new variable and validate ff_mask_size before set_cap. MST

v7:
  - Change virtnet_ff_init to return a value. Allow -EOPNOTSUPP. Xuan
  - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abini
  - Move for (int i removal hung back a patch. Paolo Abini

v8
  - Removed unused num_classifiers. Jason Wang
  - Use real_ff_mask_size when setting the selector caps. Jason Wang

v9:
  - Set err to -ENOMEM after alloc failures in virtnet_ff_init. Simon H

v10:
  - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
    Jason Wang/Paolo Abeni

v11:
  - Return -EINVAL if any resource limit is 0. Simon Horman
  - Ensure we don't overrun alloced space of ff->ff_mask by moving the
    real_ff_mask_size > ff_mask_size check into the loop. Simon Horman

Daniel Jurgens (12):
  virtio_pci: Remove supported_cap size build assert
  virtio: Add config_op for admin commands
  virtio: Expose generic device capability operations
  virtio: Expose object create and destroy API
  virtio_net: Query and set flow filter caps
  virtio_net: Create a FF group for ethtool steering
  virtio_net: Implement layer 2 ethtool flow rules
  virtio_net: Use existing classifier if possible
  virtio_net: Implement IPv4 ethtool flow rules
  virtio_net: Add support for IPv6 ethtool steering
  virtio_net: Add support for TCP and UDP ethtool rules
  virtio_net: Add get ethtool flow rules ops

 drivers/net/virtio_net.c               | 1154 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  165 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  125 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  156 ++++
 include/uapi/linux/virtio_pci.h        |    7 +-
 9 files changed, 1615 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


