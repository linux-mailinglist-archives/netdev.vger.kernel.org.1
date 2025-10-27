Return-Path: <netdev+bounces-233266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3628C0FB59
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BC4C4F4E04
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B656317715;
	Mon, 27 Oct 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EIdJKVf/"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A1316907
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586827; cv=fail; b=fECK2sUkMUgDqWJpCqNwCwkqcF2wam0PP6KV5gL/T/YFhFb4T/m1vWti54T2IuC9R0tSz0Sg2YDzHNlq0A5tZu7+zpuLw1UHVXS93aI4b4/PYx/4UylS/Id7kGoxiMhffL1iTWglhNUbD5ObzB2rHs+DPtPdzeYcOHeUZKayBXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586827; c=relaxed/simple;
	bh=dE7EhlYq+/n+ObZHMtkhRk9NLNvw32QeZEuuN79sSus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ny4P2VodeuqnEh71K719ivs+A8TtqW4wcIJySYoLSExQeg361uhykObTTmO71li4FY7FZfUwO8pOmtgXQJz1AbJY/oiP+m2e/QMXJkHSOF3p1u/fKyXUProfR+OMw52Muval1HUImXG6Jdi1+C5uzQWD6HQWlCR4hKpgqhCOUqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EIdJKVf/; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/TOLehTIKt02vOdUGp7Tn672TFMwJfqcjV7x35LyjWfnEcuIlG4C0ECFKAmTV+MxARyHL9d3NcR3hBm739a2RdybwSXG0bE1aejU1rZwl7qjpvr8YySvHEmQnnQu7GUE4fAdO/DCTHhJLVbgFLZ8Fdh6LMdyNdzxBZAAsk4evIyv211caGPWDlXjuCdpkoJfUl9DyRmcTCE7WzUjp4Fw+fITXwELw9vSRvLg5aCfxg9Gidl9mQJrCHVhF/mCeEZ6I7zGhdlIwqD5lLgMRdu8URbGgLQD2OXUOV0qvtcmeLU51rYZ6JWHTbP273RHOYD55esTUefLD5TirCtCWeQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ/4RzIZk3JlFwsXjAAFPsp0TqINoBMvZsjh7u5pHr8=;
 b=YurYADGMLKHicyKbc2iC8dcu4OGvsLBBAr2xdAYC1CqQ6a6rRfau9F5mu337e/BOIGdHhB0D2dIQ01b4N7C8pPlZLqnRv+/Q67QXsx1VXvGfyRaAIo9xA+WC2/brhDD7AreeJLX6WUgZWVn1CrypkoBIk6WC2LSwkNKIUhDusGXIqWe+HSyhlcKpVqTDqKaSBDIDB0i+AOBR7G3FMzVQ4l8Mc3FEnejqzLRnN64fWXG2dC8pY2HrlXYI6LRyd2sFnkG3lPpRro3D5zafyke48g5PLxEeauAyjcQh5MCWxNl8iaFDcy3ESjKj9b9z4Y1IdbIrEK+4EBf1dBICf9q7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ/4RzIZk3JlFwsXjAAFPsp0TqINoBMvZsjh7u5pHr8=;
 b=EIdJKVf/+G3B732V/JvnA+OtlEsEyww2Z/Y4zQmeVdF8OmcGgFdUyny2khultMGfQIgZ9vHSqHg8wEWIex521O/CSRf2KhObwTzyApw0GpoR20VLySdwSZiw/g0b7y+/Tq+Rpk9hkBLcyhgifByvX6jHjNS9yGRWRhQOg5pQABC6mbMGmDw2zpHbrEoIAIdnY+SJ9XVgWVTn5uAIXZxkDH6810PkLFJ9uumNxAMjfd3IOAghNfHVEVrCXB524nn5EXIInOIsMgF7AdN6GYFmoES4HuHk2VYAImrl7kJTvPv/Ipg6EKjTg9XRMANCmNJ+GNmCpiKl7c2nVEThlGKUow==
Received: from CH2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:610:51::25)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:40:18 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::87) by CH2PR15CA0015.outlook.office365.com
 (2603:10b6:610:51::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:40:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:01 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:39:59 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 00/12] virtio_net: Add ethtool flow rules support
Date: Mon, 27 Oct 2025 12:39:45 -0500
Message-ID: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: bd58da25-7b37-4c88-d22b-08de157fe567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FRexwx7LRkYWCaGksRzy3lycQgJ5Zivx6kGusHbCAhmUiaJx1tjPCHfD6sN1?=
 =?us-ascii?Q?wsX2pSz07ztUO809cNBsDu6uuubetwtaoTwAE9Q9y7aOatC8iET+e73F8VcL?=
 =?us-ascii?Q?Kj1IygKeuUZLFSk8VPQPtw6BXJUQ/IMu6g7W+fKQZQPAONjDh+8gylKeQ0fx?=
 =?us-ascii?Q?n40KJaobEzYxlJZDQXuTD+5xwpwXNAtMf/yqs43jLpEFOfsG1hMwFbBqicEx?=
 =?us-ascii?Q?5hClxi9/3MU85X7liEJ7/tGv4EIzkTMgFvh7gWGAW9m4o8v8Lx4vOfL6KqiH?=
 =?us-ascii?Q?THOGdiCOuMTG4DaQDMLA6KTnMCJVL+VFlJqvggNTYE7OLu8Cng7KAt3g5ZVp?=
 =?us-ascii?Q?3bdDXwYHXAueRE6irlnwosU97EXG+osztlYR2ssfqYh/jfH3bgAymXcJ6N8P?=
 =?us-ascii?Q?gmVezrPHLTcNbEIQ3Yi1HFYzRqXgv1RXqPm6U9Eag3JaBWvLzd0iOMZwmaiL?=
 =?us-ascii?Q?XHvAqJRBcOXvDQiCdiDXo6VR9VnkgC4FJNCWVDnFItAERu24DZ6MilCYZzII?=
 =?us-ascii?Q?178amxa0wuJtBtsEW0hD9ewFHYv4Ic3Zu8ThOpV3mJR1lwcuYW5kFE0+9Hel?=
 =?us-ascii?Q?+DPP/TCB2Nq0KrtxR7NBP1Ydr+AiI7B7Qzfuss76OOKnwgsp6YaKtVnrFeki?=
 =?us-ascii?Q?/59wI+wRYa9GCXaEoxcpF0Gnm8vEI2BhcqSijdwf7XQp6vl4Wt5i/8m1t+Bp?=
 =?us-ascii?Q?h4zkhGmvKDYwQ6DNW+tSubb7taZYP42eePhB4OBZ0iI5BOz9JRhYUlmzelLP?=
 =?us-ascii?Q?CW6BlZFnICal4j6ISEV/h7CpF5oa7AMi9vVC2ymOdastSAOQmyr4+/RMm9aI?=
 =?us-ascii?Q?kuf0tLobGa6dCAtMqPuIUBsUzUhjAtxSVWrezfhGjpSyNePuvqa2S7kZE+28?=
 =?us-ascii?Q?kSsumMKSEkzBAuSSVal0nQJHwq2eT+sai5kz/lA/91y2pYmg0O6hzx2RmH1F?=
 =?us-ascii?Q?lZKrNxy+6jxWOChhxIgnSGqrJYdHB3VKEhmGyOw9aiiBFneCXRh7NdwhnJBw?=
 =?us-ascii?Q?ub5FHN9CFqg4hi1D0wL2RRgjNom+W2dxheBaVdUUQtYlMmrFT9Du7aPjoP+y?=
 =?us-ascii?Q?lVWc8+vc0wYCGAnpbG0iZY518dJfo2hEOxh/XAL/zwa/vGx+XCoYcgPIbO8c?=
 =?us-ascii?Q?kv/n1kCcU7mltb4Qn4DD30L5ElKl3rX6FHU2jYCPiOYCwJBKWniZSBg502wV?=
 =?us-ascii?Q?W9kEeSuvSQD+IgVx7+3ke0urFp9FTWslBd/rwo0x8+CHceWRjyzN7nProfgK?=
 =?us-ascii?Q?ME6ewKA3HhirBCFbm022x1o3nyiHdpAOT2+/tkop/1ECkC77bMaJUHCz2Ole?=
 =?us-ascii?Q?4YR6FIT7JXik/azcAeijgB4C+8L06bpetH91KKlqLKRbi0nmRH24p74xkNCs?=
 =?us-ascii?Q?m6chalnVFaZ4VGoL3CbW0DxSQbbWLoci3WmBYXOiFw/vnt6yk5s6MamqZisE?=
 =?us-ascii?Q?36kFQCYBhIoQs2aiGW9lEos5II16T+bOQGESAbvezJVS2hMK5ZnAz4ICDWAo?=
 =?us-ascii?Q?LOEVDguf9LgVoNRHJlohl3DBKtLWtokkXXZOgj9QUkQhp/dwQcpl/iS1cJRi?=
 =?us-ascii?Q?GmsVO51c7SBCnt/gzcBglec+bd8/Yn85O+zznI9f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:18.5453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd58da25-7b37-4c88-d22b-08de157fe567
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722

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

 drivers/net/virtio_net.c               | 1125 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  165 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  125 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  156 ++++
 include/uapi/linux/virtio_pci.h        |    7 +-
 9 files changed, 1586 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


