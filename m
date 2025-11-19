Return-Path: <netdev+bounces-240118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7EBC70C19
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 164A929C86
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6E36829F;
	Wed, 19 Nov 2025 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qPIgOAE+"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CD315D24
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579764; cv=fail; b=HRYYhJ7C0kd+AAmKZF/ls+J2EkTWpK7Ak5fBDn+3oyLfexz/zSRRj2lc2Nvamu4TjRBRysYTC/VJO4eSbj6BLXXYczBVNtZNh/kT3ihejB4GertaNxONxdQPFJ4QDxoG8vXuWdCsIs9vNPFILYK/bH9HCCb/Qo8qPw9O3eE1qb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579764; c=relaxed/simple;
	bh=m+4fTtFIkcfkwZg8OSkobG+f3R7EjDWn3lCaW2mlAoQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m02UJw9PVyRVTqYExuVMsRLUDKhnSjhm47jyD8qBf747gcNUDShJUFL21wy8YJ5KjWapBqQldP/s0IbmA4NCeqWs/AFcXYUU1DnIDXJSJV8f6TPS3F29cgWHuZvQ0EXgrDzunHcIom05/O8ygjgV0jnwjua+Dfo+LceigYsBdJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qPIgOAE+; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqYdm4027G/6obz1E6K1rFcVqCtOQElfJSYzNlOJMZGuTO2COTQgsTORGpgI1EkjKjjM9K6woFfGsUlyFr7o12ysPbI+Giks+DrlDmhhl9/B6VD52Oy1kPljHoPPkIw3pPl8QP2mAI9Kg1A86ED7MBFL8W3MFX7zJ/BEHxmdjigbGKBOLvUjFN+sOCuAQtojss0oygP7OdbT06pMeJ+G8B2QeEx7BZ3ORqOftrkx5H/ItrLC9mwojja0C5KYhaOPczTiH0yc9urVj5h9Zh26IZjcomH5U7K2alYYL0jomlEG7mr9zSt3tRvNyweeElZnExiQnRdQAI3nPf/yPxK7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzBOMkOOLjpV5X6Ou0ruCtpwvrEwdp999Nlic/B7FMs=;
 b=Fji3e0CEv0A9mwokUgVwvW4Q3/8nEykTGFNp613dk89np0N1e08iqUVLtHKQWyVfb92kkQS7PySm0uZqt6eO1m7MP2VHTISxcAmddAQWJjP9hHZmow3f0wL1r0UgQQDffLRa1AsDamQT26oTlhsVbvBIWTYQo2CRyoF4444Yho3ysnmBGP3vfDI/tfdGMB3yz5SfsPwL1AoDkhIBdIzN8TZB8Zp3ihbi23IfUfrtyBDO2306k+39NsS6Kn5W1yp69ZKyBqlYrFB3MqDNiWpBJp3OWQEU69jTUI8CblwAg0fze43qcQagqgoPDvmIHQvL5g0ZP8LRtqDWxasDhgGLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzBOMkOOLjpV5X6Ou0ruCtpwvrEwdp999Nlic/B7FMs=;
 b=qPIgOAE+q5x57mNXqM/4KUqDD0glL0GfM9MGhoINGpze5HbbDo/KjlBRCmymKGAK97KRhFdTIh2hWLida+FNKNlFC06oX4gzkpfP1bzK/1GMAonyXR1T+C9inC/swcOtWRLYlN4eYlj3kabGVhM9VujhLb1Gz7JtczrhLQghIuA5eUbEaOrhad0TteFUOUbqRKpjn4rWDY90umPtst0oJWI/rP6sNMIkYj5y//uDq/OeSz14N4YFSuCvgdrtW3p+Ae6pCnzaZqdHBxsoNGKHTamXrlcGQ8hba7FhxK4jiH8Ld0nGRy0uccOgdJBH7a1HjAyr7PTla47OfUXV0Q67Yw==
Received: from PH7P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::17)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:15:45 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::16) by PH7P223CA0011.outlook.office365.com
 (2603:10b6:510:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:15:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:29 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:29 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:27 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 00/12] virtio_net: Add ethtool flow rules support
Date: Wed, 19 Nov 2025 13:15:11 -0600
Message-ID: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abfe1c4-83d8-4dda-4a7c-08de27a009fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjZa2czK7JEfruvSzbBvHvgTNQTh/RvvkoRdaFZjvx+8JKq6tzQd381pKlmU?=
 =?us-ascii?Q?Eurbckcvl75lV6twlqK5zgnX1KdEgPztq6NFAiihvJz6hmeDsVrL/8PDi1l8?=
 =?us-ascii?Q?VKu0eItU0aTAfR1lDdVhZm63kY/vTyBMwvV6gbIfx//bJCOD/7H1WqQgBCfw?=
 =?us-ascii?Q?LEdfr6/7Ru7i6CXpTVsbQAkbym1op0TMFhtCzg62Knlqtg4YF7Nxti3DiwgK?=
 =?us-ascii?Q?bshtOPICut5z5aMcHw3Qj8Xni/6aA6q6e6Tn1585kAyv+1zLi85DH+7LqHdp?=
 =?us-ascii?Q?QBloePQj0lZnG0kKrLa3Khi4RA4yypGop5l/yF9GvwNsj9bf78tIJLrgD6tB?=
 =?us-ascii?Q?m+JbtXukcetrQljkD2VEbSNvkclQJ2pCxpOGno6FNIXMVEx8kuaOX57NfGQf?=
 =?us-ascii?Q?3HUS9l2pin+Ex3UO2OCI/QwDLCIq7YIkFkgc1nIRLTOjc8jfZQjHoo2kMFhB?=
 =?us-ascii?Q?bp/p1lHj05aJe8D37W1WPDHjJlJ0CHk3S/K7SKGFDhoh2tkJV/kNgC5INqjs?=
 =?us-ascii?Q?8HqreXLHb4rYXBX6wZn9vZ/sD0a9N7vPAummtDpTL2BEo4hX5zbLuyIvlKCX?=
 =?us-ascii?Q?uo236DnQbhenVV/m0BOADBNI4/7HUs3DKgwztapZKD6f6tdyziB8EJbML/rG?=
 =?us-ascii?Q?hWUdmC2wzAuj90V86YtQMDlktIGudxD1eMkiX3UObMq5CE1tjxNCs42T/LU3?=
 =?us-ascii?Q?N4s1Ne7mzQO48PTJi+f2hzXu/Rm7ujb4UAjGUtdqU09SS+HOyTBOJuhztwAU?=
 =?us-ascii?Q?v+HgOwFmKe7kaAPWHT1xlypIsFJLSu4yY1kFYoJe5k8HMYX3JeBLa925U0bB?=
 =?us-ascii?Q?r8RPKDOlZ/3M3GoIVsJb5iJmoTOIggRZ7q5OSY2SBVPmmMzCd7Hn0W3kTpVm?=
 =?us-ascii?Q?edNrG+Hfkb2FhF7BagqWrKqO6AWE/Uz2GX0mIOtNX6Q28A8qQlHkR0Mbm6jZ?=
 =?us-ascii?Q?ZVlhTJFilBF6m3+5KQou3o43Gyg+SkyAM8397fFOpSY844oiPHo7+ULuyQ18?=
 =?us-ascii?Q?YvobhRC1rbMrWtjgBeFaIJ8hLbpOwlLA7ikxG6IOqkSiken50je7m3934zgA?=
 =?us-ascii?Q?TVRhZGwJnh4b7PqNLq3XqhGwxX9ZoiItzXABXqZ10IzJ+vP2rbWsIl6D2kqO?=
 =?us-ascii?Q?xLNJN6nd6hYtB56WlBMfyofOd5jy4FcA/a9wSxXOiM3o9G+93aNZc/RHhs0A?=
 =?us-ascii?Q?UZiviLqthqqKGTZ0F4s0vW/HuLV9L/n2bPnBe7Tn70/t1po0zazRQwW9xwez?=
 =?us-ascii?Q?qaJiA2W2IRY6/LvXxriiLRbWjixB05NRlgbXHPVUBSzwi5I839bGNkhb14IJ?=
 =?us-ascii?Q?baodm9MjwrtL3lHdcgQOhC6Yt4Nmo3r7jr3q6EU7eXiIdQqI6F7q6FvRx49s?=
 =?us-ascii?Q?TEfYB4n7/UKJSXGL98RM8u4FUG2YZk2Q4xphlzlKA2zEsMxQPLjml7rI2s28?=
 =?us-ascii?Q?dOiUXc/NUgcPKGKmV7/JiQZOdM7GdzW3IAGg4bsfLGUTeLEKx9IZUauVSQjh?=
 =?us-ascii?Q?tScuXXLDTs4eb9JhLHK6NeM7FBOkSfZc5QHd9yzpba9gnQ6SXCeE8rM31mtb?=
 =?us-ascii?Q?5tBYPGQEYB2wQy/SIGw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:15:44.8066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abfe1c4-83d8-4dda-4a7c-08de27a009fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

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

v12: Many comments by MST, thanks Michael. Only the most significant
     listed here:
  - Fixed leak of key in build_and_insert.
  - Fixed setting ethhdr proto for IPv6.
  - Added 2 byte pad to struct virtio_net_ff_cap_data.
  - Use and set rule_cnt when querying all flows.
  - Cleanup and reinit in freeze/restore path.

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

 drivers/net/virtio_net.c               | 1193 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  168 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  124 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  153 +++
 include/uapi/linux/virtio_pci.h        |    6 +-
 9 files changed, 1652 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


