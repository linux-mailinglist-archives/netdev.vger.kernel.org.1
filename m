Return-Path: <netdev+bounces-236615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED58C3E6AA
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16461882471
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE64155C82;
	Fri,  7 Nov 2025 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TN6MJn8J"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D06179DA
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488954; cv=fail; b=WESLAYKib2AqGY57nyEiTE51iyuOEMibS40SvAnFkacCYwVPi2kRmG0zzWK9gAtYHwGaMkCTGZWvyayohCZ5A9yXmYExWiLSrViioQaShBk7wK7QeLUbVR7/e52zMCpg0Nw9dqF5TfOai/DPIu4DpLHphgisr9TkT3LU4ONsx74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488954; c=relaxed/simple;
	bh=ZbxRft/0mstgBKHIbWf66aWllljvCsg1UhxuYkrFCyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQGnyuuRAZE+iiqTzhKdiDi1xcqQaCYIoM69xva5i0bLK4JPyk6sqTsPCcSJQCbnoFZYfkvey7FgDWe+ZLQbzkKKaVpOVpHdC4Nt/0U6JvhBQJfaCx3dRkhc1vqMMaNzc5RkFi6JzipxTmkXVCL5Qi0ft+oG+0xjZ+Ry+hlpsaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TN6MJn8J; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQp4n6js8Pv9ANHMgl9LOHDxaPgjXneJtYEFiOEYLYuksbPeOx+CE+b6fLCiWg5oHrr343FO37XVA1VfiC5nvp3uyaVEjdmhVDFrtqSaUcdalxjXm4KOpviENH/opiK0KCG3sVdUkN1XfNc1W+QOxU8AujH6J+vI60nml+WSm/SNQsex0lEEIG6ouecb2NQqBT6zZHTYo1I8yEYspaEVnbNves5yB4QJqNoMQROMeDKugsX3xxLF3fm14xg1wuIrKVrHPvp4PXLdpCIxOG/txScMQMYOAjTo0m6fPLLAdWsZytRRj/83BoZGVxA138iRkoOykZUN88+y5w5MXas0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnbWxh0T9y8ixlMLueODx0uCgrASMMuvtQS14cY0Bzk=;
 b=nMic124GkpEKZU2ZTFSo4cXhu4PZBbTTY3I2/2ZqMGtB804F5DZnxZlQdut+mVYmCyG8AufZlFJGteEHrT7PYGX9GL5d4NN3I0+zbIyuUtcorAbV7Ar+3FyQ203/SwktZYKV4PVXns3uYEA7Cuy63DsErsg9FYPeY45cQNnnCJ1kR9n8bva/LJkkE+YHpQpgh5GtDmQbKwZ1EEX5Lp6H+cgksClJi7k6f7n/0Ftn8SjLEQxomNRrxPYJQm5ZeHhbplGfXK5ymLLoHzWCvT2OwgS07QrG8kKbNNQxrUlihkaSyMwHN2JQzRZAlD2fnIehiOi38xATTYobMBzbzFGLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnbWxh0T9y8ixlMLueODx0uCgrASMMuvtQS14cY0Bzk=;
 b=TN6MJn8JZUAsM3ipW8ozVfgX9mS3fe+uwRxJTY7T6OYrEPEseCEJeAAzzz9jn4baJozkiKvUoazJgSaMWU73z9ib4x/oRrjiCIGkFIeFOA3TrupP83zHcqACVwa78WuP0crsYn0sgSC0bsHOonhpJrw8Jhwau2PTVDphODmedmp/FuCCQaopWnD20gm9YX1QSFY7OQeHRfrfG8U0h4KzL8T5h6h/55sptZWbqXWhwUqFzVAevZt+tLGfZ1HXByN/999mfotbSmvNVTNt3dBZuY2NOCYY2pwqcpIwN+VXf2HDfT2670810HEd2mYn79u+htX+vVUV3G/pOV83ajq9GQ==
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 7 Nov
 2025 04:15:45 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1::4) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Fri,
 7 Nov 2025 04:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:15:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:15:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:15:34 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:15:32 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 00/12] virtio_net: Add ethtool flow rules support
Date: Thu, 6 Nov 2025 22:15:10 -0600
Message-ID: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 247ed8c3-edc9-4fe5-ebfc-08de1db452ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C8aiW72crSvuYzh5OuPPd6FS7xw+biUUlIaIScNI4LyhPsrh0IZ0+s45cszg?=
 =?us-ascii?Q?iTbE8Na84gOt/9wwYgVa04d/GbvoTRkytAE+8NTBsuasCF0tNwPZEil8MmPh?=
 =?us-ascii?Q?doX4WGrinmQldjVRgLvxMbOMK/jgPlur1u8t9+assIBWo8vHglk2oGCPwTCh?=
 =?us-ascii?Q?kI1tpLbhXAyRmshFdSRe97YtSjwDEFAY1aBGQNqB43sxSRYdqDIepDQ7j3Zm?=
 =?us-ascii?Q?cUzPxQcM4n5uUmPvAcqN7v1qhSd2qu4AJFm31qJhkTdeoVJ7Ey957CogFg/r?=
 =?us-ascii?Q?vCTin05fHKBCCKJkrYB31gGil70t3IXeOLlmftiS9+Q5idP3eXpfyQB+gtu1?=
 =?us-ascii?Q?NrmUB5B83CmDBA4STGRSnxq6EDZByWVMHDuezDnQarjgbPazwhFboD11OAPu?=
 =?us-ascii?Q?wNRpYyuYL1pbcDYjYwX3dJMT56/5Vn6owZwfnz/5cN4g2lDJ654QZ8abYllj?=
 =?us-ascii?Q?yAAd0LV2ofd/R1kV7HI5qEjZ3YqjFjo22687UI5IoLP7ydA0r0RWwevMPDq0?=
 =?us-ascii?Q?keriCZetHXaA41DjW6NzVsXy6e0VgC8uTt5TaBfj6G29Mi4oXvmDseCkkxEV?=
 =?us-ascii?Q?UpDVVrKqGOnMQyl4J+Ugzg2dnOJ+k/kvFYql9nSMWC8YhtAOquTfl1qNdUR0?=
 =?us-ascii?Q?hDjfgTNwwawEW8haJBQHFuxBsUPXtAzorGb7GqvpDEmPQFx/cn8+z6dDh1fo?=
 =?us-ascii?Q?/nd06lM5LLMSCgxlolVvppYLt5zormaJWMCMZUG9kxpNSNKgRV4ZGIGDJCZF?=
 =?us-ascii?Q?o7nk4FfYeOxuC8DdtuELJPOGcRU2ZdphbPV5iFrhmioaukvCyRf4G04Mmbuj?=
 =?us-ascii?Q?yV0gSN3hvt/kb/c6VviMhMMvpM47RlKLjrE1wfMnObpkrRBzIjvaXNEQIfip?=
 =?us-ascii?Q?35q7JyG4HT0dy65O8LujSOboJ6uJ2R3Ctrqg6yNgcdvorCregJEevwQLd/KI?=
 =?us-ascii?Q?VIvqQkH0BQLH9IJ/mTPFPZkCfr/r5NepC67hpd3f01fai/8ZW0yeEy1iM4m3?=
 =?us-ascii?Q?99jF+zJAmlIofF9VMS97DW3fowRELmn6Sw/z8YsYPc5n73slPJFEP49J4OxZ?=
 =?us-ascii?Q?ZMoOzkV77m3Zt8/dpiknPRF3Rkd2BnMuXeBewRQSzv3n9pKRW2CQuSOiwjUT?=
 =?us-ascii?Q?+VKGYukqWefECwf+zJJhXDn7h0w9fucgm8dnmuuoXTtIJtGU2limpBXbSZma?=
 =?us-ascii?Q?NzDaNQIxNXK4zeCYAdO4EmwDK09ZZ+YUO9g+KTP49wuOIUnDqTT8R8oENEqY?=
 =?us-ascii?Q?WEso5mniYBwcfB2ivNsJLmj/PUW5Cluz/MD37FylDWCNAWliZ7dOj/CNtfcm?=
 =?us-ascii?Q?jc1q/6pBqH/xLIlcb8hGPKgOIo1Htu5CuMLRYVx2JHo350JFZ9VUeo1wYVwE?=
 =?us-ascii?Q?s90dSIu2Af6Mr7IRgNqh4iRqs38aaCLSExlg1isgL3MuxUsPshufM8u0Xv6q?=
 =?us-ascii?Q?kUlAwuv6hWclIJsYL6fn9NA17uYtLAlf2MrQolyB5cqQ30wM9YDFKN4pAqeh?=
 =?us-ascii?Q?2vT1TT+tylj+pqN869H+6JvwVzErTGS3GtZ4aSjGCovP3aqzmQkpEP7XX3xc?=
 =?us-ascii?Q?jSWacwTpkK16quN0CqxknJl0fOk1kciUVxHRxOu8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:15:45.4975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247ed8c3-edc9-4fe5-ebfc-08de1db452ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789

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

 drivers/net/virtio_net.c               | 1144 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  165 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  125 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  156 ++++
 include/uapi/linux/virtio_pci.h        |    7 +-
 9 files changed, 1605 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


