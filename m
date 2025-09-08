Return-Path: <netdev+bounces-220882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E8B495D7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4C14C3857
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC531196F;
	Mon,  8 Sep 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CGkIQ611"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93735310779
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349793; cv=fail; b=mSdxcEsJXrlvocDUVLfVZwUjDl52im7QUWdR4wbcPaXilmWpcSMrMJgowunq5WS+RqiOwKy5iX5PXosOm259Ze0+hyQiINNB3wmYHbcmhHxKXM43suLWB1fjaz5CssF6xGZ9AFLFRXAsvCkfpEdFfRUj4HYj3OjV7htmkpS1AXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349793; c=relaxed/simple;
	bh=GmMWxIpHdWAcDOEvJ70zRtb1JoeJVst0r6aMtcu7xtc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uqmOvnHZRq5KdJTUfCdQgCeYLvx7lTUyjbXnn1pNW1vsd7Y0mUvor06cMWoroAi0Hy9Ga0LqQu2ixQjvLmpDwC4Ra602dDGhjIeFPdnE4GYnlBHNWDyaRFwJLY9lzfqIdn8uYpmToi/GnEBVWdOV38AAjQyfQv5uS9Imu7xt53c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CGkIQ611; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq/HxLM53h6/PzSCagbJXTvFoYULst++IKzwk/BH0lWoAw2v3EvyXeSDEHNenzmPnnOVmUb9GLLIQ201SowuvvOMUti4Fpbh9NN/fTU7wLi8486ZISs3gSX9q0E+FQGmogmXJd+mmJ1OcQ2ciLanC62SPKr9R0Huf9nfpXTOepSuDMK3hzaPyixGn1iTt9HJXGyHzWyo3fGnqy4nrO4xOanTLHPmb5CxwAVJHOfYRQovxMqCfNnJcfH7oww8RdMSnH0erl1HbfAqlJN+OWSxcxeurjIRC760bilvFabN6s72N1CLn5aB8/ZcKqdriZRo/lGwMhQc36PJbJ75ceVfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePMHSiS/m9r9l0lSKvdeO8AcUaZFHUNd9QjwsemxV7M=;
 b=bdJFVeZn//ovW8fkbbE6X8GTvWW9ho7gqLcDmVws0NXzIqXvwbPqAHWM7yZp1Z/USA234ZaywbL0D15a1fFXlqIRl5xnPsXYVoD44FRr1Cw8wcgkulNQUjQr28MynVIPyVRmpM6qyZVB8el92PpjLd/2w02uhBYSK/cKIfaAfB4ELXJN+pW3A/A0DLFKHeC6EF2zxcfntMFKWGVAXuWmMlGELMgmCKM2/H+esAPWoBuRUYP+Cwcw11pEXFzBXS7sgswRuzcKQwhmRTKQ1SQgD9xLB3SlwemcQKWycFytfIHCJTr+Qwmd1PZj2496EUSdGF9j+0E4FcwhU/b5LyyQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePMHSiS/m9r9l0lSKvdeO8AcUaZFHUNd9QjwsemxV7M=;
 b=CGkIQ611vxTvYCbfOKBKL/rwr1fxZ4Ur9CrWqrJNnlOeY6lPt0mwnUYoAFxV3dZFuffT6tUrTAjoUE2edT7YT76hDKAlciaZotqGBAGGg2y00D0bboua6fJDRDl5K1ja5xYtHJTxUrC4RDcRKzDtPv1gfkqMVckoeY7eDz8qgcihhFcL9BY7oVdZqf1kFJ7ekgf14JDOPLpcMjEgtk6OMPOBMhqOw9HpnAxyAJvW4MyJUBhZo6pmiS9c2HhEG8e07vSujlsz3sAWkITsuqQGwxNz66HDGen4fIhf9Uy7/hvbshMFgWt+bxcNxxM8//OqMZ555AidGVbhHFOMxM+VrQ==
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:43:01 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::6) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Mon,
 8 Sep 2025 16:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:33 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:32 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 00/11] virtio_net: Add ethtool flow rules support
Date: Mon, 8 Sep 2025 11:40:35 -0500
Message-ID: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a909e3-868c-46cd-c9ea-08ddeef6c67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OuJn38XiDgHdSMSvRZt8PcWd+1RNOgmcvpJlZ4hU+YU+fRNdCjcZYbhrIXpl?=
 =?us-ascii?Q?W3QEhqUSgm7h3h8fZEE4gT8TY8PdwGIoPTqx/RzsZdGaywSux/PW0nl5luSR?=
 =?us-ascii?Q?yX3jnnirihtwYA1fYW5eh6xUnOjcmo8M5PILyKD34XMzouNF9Ty+IEagD5os?=
 =?us-ascii?Q?eyxeQxyd5HLSS5FsyG/bOikSGrjOzk4DLBhqtOTy695oOhvNGw9Lh/xkMAUf?=
 =?us-ascii?Q?/AnMiGljF+XQnL2GaJOXPJ7Q3nJG1bDmamqQ3qpf+uvmPmIuMq2y7AOqibpc?=
 =?us-ascii?Q?rcL5UbJZWjn8hlQrcwnJ9S5+ffr4cahDh62OnPXt7tlyHs8h+FGaiCP1MTxp?=
 =?us-ascii?Q?elFcTnh8v77OHhlB7CCei7u1+IUpoNE7eWtOPMfMbhVWouagFGDNh/iaq4tC?=
 =?us-ascii?Q?jC8S/+s41jCow9vqqH0XzcWvtZoD5OWy5jRfZSydr/YDXOByZ3PAzn5lvGnL?=
 =?us-ascii?Q?ZRlKp8WGv0XO6csgKpdmo6TexShrpSfkycKjsRc/XBwOO3nyoBoyp7mWS8TT?=
 =?us-ascii?Q?9rKZt5zOMnq4XA9sHbHuUlB4kMuzb/eTP/fTiQ/dzz25rXEz2NYV4OO7P0LW?=
 =?us-ascii?Q?C3tcaVhbIURJF1pwZNgt7DWGu5NKb4WiMcBe1lxTisItp3WZG2AHmh3+ckvz?=
 =?us-ascii?Q?kMdeg/fNu7nV4gWOJGWXK3j5bMdPO1+tPt1HIXtN6Q40AXL911KXlyo96giV?=
 =?us-ascii?Q?ai/shRQFFXAwp9nPtafRG48sH5nPG+uzd5WUlgVX/LpU1r8CT7yWYtxlz/GU?=
 =?us-ascii?Q?tJvA8tKg06VGNe+qTPDmBWz++txNiTSQNDnrkcooElmN4VtLJPXbiVgDPQW7?=
 =?us-ascii?Q?/RJ69/8XrEFKyGo4vtCDVPm5ZR1C5odfoYEX4F5tON3Vjd3F/IgI2b2QInuP?=
 =?us-ascii?Q?/dl101bynzhlhTbAQKkBEhPu5+ci3P+9giDa1e7D21emEGD0VVq2Lhf32O4U?=
 =?us-ascii?Q?eJ9ilPa3e3CWvdqSG0piWLRbZU2dtWc9SpZWISHPjUne+uez8UYlCAyAfnKI?=
 =?us-ascii?Q?LL9jn9KJXjZdaHSFN7DqedtAV97KxboHbzRtEZ2fhra0ZXaK7SPFMxHF9a1l?=
 =?us-ascii?Q?SZf4JBW/zJU7C6yMYqvQ3YIVyalkzYWPTmHH77Ql0TgQkOM+FhHa0+Q4FX/n?=
 =?us-ascii?Q?97B3IK3YywgLndIq3TPRBpaZAXW6v2q/T1RONC/y9axblZaxJHKwegm8+/5h?=
 =?us-ascii?Q?nroor8qB5mHHJtqSknnGX/m1msXzGeg1CFDtmyPHxOvJCUc+Zqqf6QgdCJ/C?=
 =?us-ascii?Q?5AFZ7YWXa8TXyfmZ5PT8PZr9FGZg/b9AVjPTUwLlH0mhQlr5iCdbTv0W3Alo?=
 =?us-ascii?Q?+gcns5fu/Otxq8CEuunwYKeiC4QzX06Jo6qxGUG4Wax8ZJrrAUTk2IAh7Go1?=
 =?us-ascii?Q?q0H7s+aUmc+6edjRmYJ96aXVj5hzjjXbOhZAYsaGKik+iI8aeEKhB0KpRsNs?=
 =?us-ascii?Q?2vTI2pnA1kUmTzH7pfijwAxzMLZo6dFbHvOLrTPf2mmKUEn0oYNw/mM1/4I4?=
 =?us-ascii?Q?b0x7VsNaTmUErZXsNEpF1toVXERMigdUCZoU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:01.4864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a909e3-868c-46cd-c9ea-08ddeef6c67a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

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

Setting, deleting and viewing flow filters, -1 action is drop, postive
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

v2:
  - Fix sparse warnings
  - Fix memory leak on subsequent failure to allocate
  - Fix some Typos

Daniel Jurgens (11):
  virtio-pci: Expose generic device capability operations
  virtio-pci: Expose object create and destroy API
  virtio_net: Create virtio_net directory
  virtio_net: Query and set flow filter caps
  virtio_net: Create a FF group for ethtool steering
  virtio_net: Implement layer 2 ethtool flow rules
  virtio_net: Use existing classifier if possible
  virtio_net: Implement IPv4 ethtool flow rules
  virtio_net: Add support for IPv6 ethtool steering
  virtio_net: Add support for TCP and UDP ethtool rules
  virtio_net: Add get ethtool flow rules ops

 MAINTAINERS                                   |    2 +-
 drivers/net/Makefile                          |    2 +-
 drivers/net/virtio_net/Makefile               |    8 +
 drivers/net/virtio_net/virtio_net_ff.c        | 1029 +++++++++++++++++
 drivers/net/virtio_net/virtio_net_ff.h        |   42 +
 .../virtio_net_main.c}                        |   32 +
 drivers/vfio/pci/virtio/migrate.c             |    8 +-
 drivers/virtio/virtio.c                       |  141 +++
 drivers/virtio/virtio_pci_common.h            |    1 -
 drivers/virtio/virtio_pci_modern.c            |  320 ++---
 include/linux/virtio.h                        |   21 +
 include/linux/virtio_admin.h                  |  101 ++
 include/linux/virtio_pci_admin.h              |    7 +-
 include/uapi/linux/virtio_net_ff.h            |   82 ++
 include/uapi/linux/virtio_pci.h               |    7 +-
 15 files changed, 1662 insertions(+), 141 deletions(-)
 create mode 100644 drivers/net/virtio_net/Makefile
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.c
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.h
 rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (99%)
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


