Return-Path: <netdev+bounces-229863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227AEBE177A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB220403950
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCDE22127E;
	Thu, 16 Oct 2025 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QFSgjQGi"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012521FF33
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590884; cv=fail; b=GAzxyaPJ9QexsGsjKqJSiZcAMFNi6LTKoip0P7WTAbIgUI6nSqCealIjuU+OUSFYSljmgk7KfYqLcnpMvxXqhIE5br6PfsFCPykcE2JAZPNEPaO96LXw3KjxPtalhOehd9zq/DniodOyOreTi4b4Uxk20h6gz02CH8yaw+Le5DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590884; c=relaxed/simple;
	bh=lJpSAKNchMavMdhzm0r9BZwmaN+lDTtF+LRXFrmMmR4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tMk+vpG6GrCAtMndpkGFwP8tpSF+fgB79zK8MKdkBVhGx7v0ihLF37sVC8W2qzkuf/gN9MNBDazFNCsYoR24zbt/2x8HogGUGfE9SbLPE8uEWvKI8zf4a4eyg7Le6x7NnKouW5J5lCPneMNWZTPsHYdvkSustkd1eNaacmTp2QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QFSgjQGi; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPRIItaTei2rdO8StE76NuRmU88iJcykXGq6czCllzuY/RW5po7v4XBgmaM9/keD/nH/lV1kmlgIPkRg6S3Q3O8pmQb1Ubao886ts2GbG9q3RklLPtL4i8LqIiv6ka0aofPPrix8GqARGGnfqVxVONfrd+5opr2znV30aaOTBUmMc1XP1flP3jz9HulkzRHkGI6Q0T8Qd3ELZl4LVhCgz4wgMOHdIHh9Qlw/hGDHU/wLiZrPe3qBwcermvcsMvpYABHs57bjGh0G+/H+n7CgTNEo89HX4BrfBc/7ECp9qf9Rc5AkYYqSeVWJOvZ2iDYVinB/vMn8NxITLHTKYHEvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blnZNQqlyMCWgH22SvK9IoVT5LRhIrOnqYRJmCRKI4I=;
 b=BIA1kHnojs9YdrmSfYc6X5on6UTw5wyecDkMIvSA8MoO89SQnaoBtXOFU6pFYHudatChHcLvOwEZ7emhDzMbzoYKSydEsm4bnbtB2DXruVMi/360DKEw823FzNM3xe8vdofCd/qHx1bEW1INzYW4dpX9rfVcFuxg6SaanPIePs4021VfF0cn3dzX3jYi6z9iiZ+FphI6SDXaChV90ehzY7oW/1OZ3pH2yC5f4SSI1K/HykyiDWINxez4xhuiDiLGOxXBY6p3UfCU7ECGpDJpOUVvMTZ9wFr2XWjisI4bS4P1VrNVKLMfOUzn/jaO8xo3J9I6EwFB5NXCRAzmlXwjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blnZNQqlyMCWgH22SvK9IoVT5LRhIrOnqYRJmCRKI4I=;
 b=QFSgjQGiy38XRDnEgCUU+oan4jS98ZyIm9zIeY6ugm2SkMlA6z41D31/Vd6KLxZHpKx106oq7FPQboQ/kaj1bj9NM7ZrQEovcxfP3WhXPRb3zs6w0bnukncWgexQSELV/yPR/L/KGewqX+Xjrnj1EoQzwTW1KpzvLE46VQus2Gd4P/XVXWS2fRKXRjtr2t2DW6cKAmqq7P9/87O9XdkNNqwR/VFdyWyaixfUXkBLfmZLNGRvJuBkVB/AykcBJwN1q+EC1Us5KmOt3B7Xd2BD/e0bIZbjNwtzUMyw2o9ZdYhXstalFnuL+7Trf3tw0Kl118v2ystdFOomChl0atrfcg==
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Thu, 16 Oct 2025 05:01:19 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::69) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 05:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:04 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:02 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 00/12] virtio_net: Add ethtool flow rules support
Date: Thu, 16 Oct 2025 00:00:43 -0500
Message-ID: <20251016050055.2301-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: ca268bb8-a559-49b6-ee2f-08de0c710b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+tS3HHBWPOUQ5XMi4Y5WLw0gk9Mu/YuYHvPLyFJMM5cdsOdBrrgW1KxyIaG5?=
 =?us-ascii?Q?gE4x/ImIVIWiGYGa/ImxjRjI1r2+Xj2X2qHJWiupQHs6FeWL074BQ8Y7/XLJ?=
 =?us-ascii?Q?Xa0hsMZbuE6Of2aH8DRmmoQlqn9bLD/MeqhPuIwNpOpf0uutetIYBcd29kg6?=
 =?us-ascii?Q?OrI7gLZL1eackmDJfyCEIdwZi/DNyXDnbrhcPZ5oxntgQibAofunMOzPK5Ms?=
 =?us-ascii?Q?/J2+/ErVjHMG5BlVDw1EQZjku8/bL/lwg+UglhPWbRoJ3txMcbDrBfij1EHn?=
 =?us-ascii?Q?TTnFi0RzXzabe7PtvKPT6LyiOV5Rdm+B44E0Xemn46f6rDXw9XNv5DGpCLzY?=
 =?us-ascii?Q?RZzUNX0nPRoTUg+BGe2qvbd0omJLpN4ugFVV3NK47uXgmOMIlRYEwVYoT4L8?=
 =?us-ascii?Q?sXu3si03yBW186UvLwTypfa6fryDp+ryZ3UiSG/h+PqnCdA6jMUQs2Uohb4D?=
 =?us-ascii?Q?dn/8UvHW9+RCML63x68iQLcGSR9SNBqx80YCpYWDYpTUOLnpx7PIKtKPm4Ur?=
 =?us-ascii?Q?bHjjBrTXLGc1HjqiIM2jEJhnPodwR15L8t2j0lexBJNzW1W+QXCq0eOaT8DT?=
 =?us-ascii?Q?74kIYFBd23bR83r5auDTbmdve96vxoPwe06syyTedDHEcwbj8rbbJ5itkG6W?=
 =?us-ascii?Q?XDn5VyGPeQYM53f2BUqVZxgaU0sq0OHstPhQm0KMZL4xIIy8vs2jkRfg5zwz?=
 =?us-ascii?Q?eXqI2N9o1cPvaHepPbOEgkdeaRqk6wi07WoeqfdLETGEFHvnNSgC/8hXmo17?=
 =?us-ascii?Q?WvXzwlz416VL9NGDLDWuI1tdNpVDlJGqW1RU1aI+TrxV1/J++3qhm72MaaRD?=
 =?us-ascii?Q?qQn4mRbNMVpHOKGTJX8XUQIFM2GVZ8CcitqWJFsKQzmJQlO/IwYsyqvutuEf?=
 =?us-ascii?Q?l6MFXZjz5867gQWAoCzVX7qWrzi0wWDiz0GYsWwq6AccFHm6eDGpjPeZYvqn?=
 =?us-ascii?Q?26tfyr00uZMqO1BRqlw30uWu9kSKmb/YWzX8+FKG9u5MSGtFUejEChJWS4qY?=
 =?us-ascii?Q?ZHAdibr6obcQWUWVLZKefvrB0dxeJTK27HnywYHIeEbWcZTwPIwPDE4G0HE2?=
 =?us-ascii?Q?ZpI0x2CE4Kzwq0Y4HvySN0hmOd/1Vq0OsoTc1OoBkOU2ikdWUyMLUYX/Ew4E?=
 =?us-ascii?Q?cj/EeuJKMvX0QzWjQBRecquFX0O4liP3oIqEiginU/pgDQVHN9A90/OxTC+z?=
 =?us-ascii?Q?O4F9KMtN76Vmx4dLZnxMgdcKa0mABTNHtynC2xm6l+GDUaC4cCSBpl0kIhz+?=
 =?us-ascii?Q?WZ8lGAE1sqyB9CVCd47mxte+iFzTS+ubEn8+rTx0a8LUTFDM1Vm7JQehJ6MF?=
 =?us-ascii?Q?/QogQbA3xzJ+HMKLhjF7M5fS59UtBZn2XCn9im9MpS5E0rKc6CAb+aR0Q7yi?=
 =?us-ascii?Q?gP31wsnyYyipJAH/4oBF84USe6xYn11i59ycuEq5TjBr7rswbM2iH0ofE50L?=
 =?us-ascii?Q?5fO+1Kj4oTRm1q+8Yyxhi5bMRAtYY1qdIVGFVzWpe3kw2Hgudh5ER/Q7gHLq?=
 =?us-ascii?Q?nFgp0T6cjDasNgkSIDT37Ikw/EoLGqNYIb5ny5+9dXjB10eAMXbWuVVYqKqY?=
 =?us-ascii?Q?DlbcpUhx87LNyloK6mhhs8jahiuFy8lFd2PwSm4c?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:19.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca268bb8-a559-49b6-ee2f-08de0c710b5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469

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

 drivers/net/virtio_net.c               | 1119 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  165 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  125 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  156 ++++
 include/uapi/linux/virtio_pci.h        |    7 +-
 9 files changed, 1580 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


