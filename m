Return-Path: <netdev+bounces-236070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCD5C383D4
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE11D188A848
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E432F49E3;
	Wed,  5 Nov 2025 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QmUIO78H"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE512F1FE6
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382665; cv=fail; b=EfOh/DFw2yw5zFCrSdgTB1lDNwtkPmmuUi+Sw04CdBopL4RtZw7ucWBIe+wry0i9GdWjkyWLPk6kZ2qcTUS+okmLi5xPfjz8momxPJqmEmNc28mNTjktLbQwR6IBtDlLo+FDJw7VMPZ7UVaQmFj4bFdZknQomK7mM9KIaq6l0+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382665; c=relaxed/simple;
	bh=i0ZE7v3ynnelTz8dE0jPEer2gvY4o6xhAwBVKhHfJHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gO7m7MLQOqPDCcjVjywF4zzK1G2hUBeWDE2/Uo/3MF5bIbjI5SvNPgScFU/vRnO/F8swtswjk45Jsm/+mLvhozNFklg/cfcjFAZa/ITEfnG2cWV5O+48ZmcIC0QF8arXr0R/amNeZ4A3sa/kUQNTi8je4KlXKKk5slQvz0Lzms8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QmUIO78H; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHOPiDFDdq+88c/z54j0GUThz6L64T7RNfCtRiWzzGvZjoO/0RAubrr8erK9kSKTr2I538QITBJZiHYS15E2nOVADSWC/f+WKSCOuFEwzfS89/uoEROVuJ/jAZoA7p6WmlCITlyW/rhWE9xa1Wi8SWI4alC2GyyPACpktVmBjfhCmF0Vf4HDcjSSe00ARVXEOW+kjBR6SoujQWv7TxV2e4Oxi7WbJLojfquueqf7cnY7WfoXC8ipIlYGUtPmg+u6rPEXM0fZ0sSD15uhHyVXx9U8cJf83CWtGd2a7+lPacDxAzDfvbjrVYNK02jBxMDKMoRyJgIJJFHRhdFyFcj8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQCYa+oxBGv6QMgupuSwk3k4qEAyH3OmB34oRPGrTmg=;
 b=tyLQTcO0By2PUYNQM9c8BtvBp3Axz1XIbZhWpaeUK7ewWrtXekyWjGl/T1F6SP6a3RCDaMUbezrGZYF94JfEfRoyISfjGwzlVvEzFH1rdn/uGfZnayGkaT6hZCc9yEkp9gHTtIxWn0eEhoUmUKCvX16hKO83iLl4wOAl9+9uNqK53Z3hlHVMpVCmcDjFJNTRcWophUeE77JU4ezLlEcx29H+eqRPNXub76ysmLt0/eKo/R542hkYAkOmUMd4WtbS+XX0/giGxW1/pVpHODofuFd3UPeRoqOxwB645o4foI5CigSpfupuZGezZsVN/pcfg9KgnsnrKesJa4UPHo8zpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQCYa+oxBGv6QMgupuSwk3k4qEAyH3OmB34oRPGrTmg=;
 b=QmUIO78HBwTUASzXEatViUYZFyfdVcX2kRzFXPTNm8NfhmfHOFdn6WINYQNlsxFKh3Lfur0lEV7xlGNdsI558ExrAOtZF28rZo0OFRAuRa93zVr+dsEC4CYORLcq7EWsql+tJrdMi3p1zOMf3Tl3cvdf4OeVNF2nOuKNPkt/ZARCvBqrnKRp9OOF7llSMmytV9MNFwT9ckcKaA3YGIzFp9qmXnePidJjf01NQqxajifKemPHjNtotmDqf3ryhmhWEDwPtb8jA22bolfv88EmYX4xTwrKjTyzjPVU/6DYKjYRBfh1L2KwvlcVHIGvQqIQYpQsLLuxaZoExoqSUVCOiA==
Received: from BN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:ee::24)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 22:44:19 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::10) by BN0PR04CA0019.outlook.office365.com
 (2603:10b6:408:ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 22:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:44:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:03 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:01 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 00/12] virtio_net: Add ethtool flow rules support
Date: Wed, 5 Nov 2025 16:43:44 -0600
Message-ID: <20251105224356.4234-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a4e7a2-7550-4a25-0681-08de1cbcdb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?faREafh78E0ufoT1JgEUCK25SwhmAvxFaEgLxa/JjwVf7rvstiDdSalqvmIu?=
 =?us-ascii?Q?qpgBXwDJj78QmfigVJGlQ3XEFBFCsJmRfUZ3G6fDUR2YmsY9E8+9fI2KQ/8J?=
 =?us-ascii?Q?y5DehHTN8gC86dEXFJHddT4RTTCgGoi90wgmMLga3Ee+U2ApGX327aIrfO6B?=
 =?us-ascii?Q?kjIuDuQ/gciautyiV+vY4YiARnFJni2Ww433vVeZA9P8rSID6ke87OzuZtDt?=
 =?us-ascii?Q?b4F99oSh0+JXk+uTU6j6Be5Ooc43Y1L51BjawTTDfLTxzaNcXbptby3fqH1g?=
 =?us-ascii?Q?Vio26AeskuSl08g8q3t3V7dbPk8abNhJPvVvRSus/8PACPjYnkpNzmkq102M?=
 =?us-ascii?Q?1L3wnZ2q3CX+Yft2ufD7K59caEyMORf7SBG6A3GSw9FWZHJiMXAnwL51PaMc?=
 =?us-ascii?Q?FYI+U7HBc17t9Qex7kBdHV/B4REaxxglUzdWX6Vq2UfjbeeEwsYK43ApODoM?=
 =?us-ascii?Q?k7aWQcx3A3BOPHib9N0ksN/LhabEuCKYqJv05/trfx08Yb9MET/B8GMh5rhc?=
 =?us-ascii?Q?zpFe9E+CocXhjbeeb2IIulDgYh4G8uSKw8sYwgAybDXewozLIa6z6+7SnR5I?=
 =?us-ascii?Q?vlm9OJrJFuPJ5eAgAOocayHLi76thkcy7kbttBZE05XDR6zXAWjE7erk1XhD?=
 =?us-ascii?Q?MSAgoHQfqIFsbS2BV/0h+UIr5sFU0YcvVW5coq/mt3P02QClrLzUHktKdH/g?=
 =?us-ascii?Q?eXOtbwnZAi1Hog+sL4LU5HnmK0Tck37Lwd2OdjzqvVqdKzD7HVbYQ8dBYGTn?=
 =?us-ascii?Q?PxdFOBf8GWRjXduz1pcK1R9BvXR+/16Oxjcn0j4WxfIORYziGxW0Nr+ZUYED?=
 =?us-ascii?Q?H9uvC65w1CDWGfMb/XWyCQ8Eua23g0V1nszumeaCY3vO1C1XS3Bwg6/fj9/i?=
 =?us-ascii?Q?LZeplgtXN3lAHKESQlyPQroc5GQAgC3BRutBL8guujL8jAPGG+98/FuEdOGv?=
 =?us-ascii?Q?x5LN1mFsujYiDMcalplhp2URysfypNbEiXMreTaIh3YcoA4qOlHwC7uVNPvf?=
 =?us-ascii?Q?N1IZoHdL0H9/5SlyTdWGm3Mq4XYjQzNweC1p02VAOcI3sFpqcySGB9z3kUtD?=
 =?us-ascii?Q?ZUgYuWQx0AxqhMhgREPE3ZR5j/aM0b/d0s0DUfHGBMfgaVXqYI6+3Zr4Mj0D?=
 =?us-ascii?Q?BPc/DnDvAa/0VOYGw9B+BDWzEdIkQhDwu/Q1HzBmbN21dODyaYLYei3ulNbO?=
 =?us-ascii?Q?IqfB0MYd5zcbeF3IR06xpkIWc2mOO1yoI0sbNlVniacV51fwOfbrRflMWWMn?=
 =?us-ascii?Q?T9ZI7nZmC5ntNWC1dWkgqIUhMhaLieGXJDQosXV7lD/4bvn1dsgbmDvuuF0I?=
 =?us-ascii?Q?n4H+NnyQdssSFVR49BcHeVxgBCd3H6kwQwgiP5C1ekTnLdsWfOPW4/cHArh4?=
 =?us-ascii?Q?FpdHqqVt4itGIrf0FqpNlH23KiE4BLM3V00MRDGXxjWFASsL+t3h+LcLm5DD?=
 =?us-ascii?Q?5AN+Mz5xdxD39ZIW2zzO19ES3LmoJyUbtY+r527JDMe6KqLFeTGn3d/N7jIQ?=
 =?us-ascii?Q?wbvEiVGANC1NNoam7yZqotFJ6/C1CyNg075o/1MDAeOrP5k1M+sy67qOW8Vg?=
 =?us-ascii?Q?XiWN9RRdqN3e8pZV2X20JZLy2HlMt0i5JFAro1F0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:44:18.7150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a4e7a2-7550-4a25-0681-08de1cbcdb22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191

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

 drivers/net/virtio_net.c               | 1138 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  165 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  125 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  156 ++++
 include/uapi/linux/virtio_pci.h        |    7 +-
 9 files changed, 1599 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


