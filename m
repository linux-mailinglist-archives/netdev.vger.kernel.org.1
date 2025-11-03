Return-Path: <netdev+bounces-235248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C5C2E53B
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFCB3B7E5B
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E942F9DA1;
	Mon,  3 Nov 2025 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qxq0dgBe"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD752E7624
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210550; cv=fail; b=CXEsyq2tcd2SFZbAhCXtJ3pbD6kvutbnQzXVRPlKKC4vGQFX+6BlXLqbd2VWJ/nSCCVHXyo+qnyiCCICAPDugl47YXLra7AvqkUBsRQPVHlCynbdL+YH7jSk/fALuTOwSzoYNLwcuaNNkNz6vKzuICD8tLpTAUehNk+M7bfytvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210550; c=relaxed/simple;
	bh=n9PrCAlLSYJ3XGDykPcWOshTCY0tG/Q3hUqafxIQLwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KiZ+7U74hWruQhcZzAL2MQzkIdfgyQflZUgxAieZEAmC1UrakBAVnqi+90KhGvM1MzGK1F2NMdtQXAsAa4sgdV/tdbOlA7bqrOWOcLcy5xVHkgvd9vxXxqyKx4xPn6nDIJHJ1GgY9GZmN6HPv+CNmESn2QCGvjTtWsQqlLQXU/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qxq0dgBe; arc=fail smtp.client-ip=40.93.194.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXHZJNV/aZXVVLrVBylCo8XuQGKU+EtooBxBYQavnbxGcTpNFzokojF2cfXMpEmhp5elhLI37r/8yDPkc9c0hGs+NoMCV5bYYZpFZcv5RF4oy7qBSuSQ//Y5orm2Cg3BN2tg9Un1fLkIwEXU1EgOdEg9Qt2KPMlCygJHuXZeiVJ9d/uG30REcmckQ4AIzNPyeTPOvYS22ksjaZC1Oa0ABUOxyt1Sub7PnL24QjGNgfA3Fa3zeQSZ8w6VTLjTYErS68gzsKZWkKiU6eIshWzHfBSnpEAbxDx9ycGYfT6q4MYkAGhadq0d9NTDFxXct5flArHo2K0yYTFRQmlDxffCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otNIfJnjHoYR3FM/8R8G+NEJUbGn7FCPu2mCbG5nbZc=;
 b=c5CRRgdf/p+EALVtcSwYFnPprlavBLzJJFD+6POG5vy8n3A6Fyyo1jQHgJQ9tmi/E881PPxYvmV3aM8JzVotwF2JJN7JunAFX+4dRHKWmaUWmg8ftnLjgfqXcjzP1folgtjcDlgOJy5BolhcMPG7dKtDxwu9K4A6hAD8bJqMzsnM5PMpl8TOyPBU+LkRKC1ePS/CiULbBPTom4BMmeKsB2uc9dcEfpV9QdzksmBDkmUXvH5Uzlu4F7bVEz8f1LkFVHc+zfdWPWmkLl1eUbK3fXywFWeEc2ty4yPSPQH6Sn2bk6uKh+6CtmIP0jfKecipxxA+5tI9GJEzEH9UGYReVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otNIfJnjHoYR3FM/8R8G+NEJUbGn7FCPu2mCbG5nbZc=;
 b=Qxq0dgBevmD+fwli7zVoM9X+SPkrrpjvJqBxeRZtKJ+5LiNpBuXdNk8j22x+a0rpFdGc0t0gmt98q95fFE3ZBj4cpVbBugkzU+nnfwDnyNv4JwC/4kWiRlfLUta5RlICqJaXVHNAYAp3DpBTiUebzQ8zZMANMAf9Rj9BsxbzsFqC0FfH7FnpKZYuolg/qJIN0lyoAtnAEGE//vPsWusnopIKFglog2DrecGdOGw8IO4ukCG/mhUgMm0KAg5PcvavVmq5XiAkQnAhJGtFqdpc2wXBCk5+HE7042I4EZPKc3Btt1wNmAeWfRqH0lE4aA8epkjTsGbXcNcUaKdN/EjgvQ==
Received: from SN7PR04CA0161.namprd04.prod.outlook.com (2603:10b6:806:125::16)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:55:45 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::71) by SN7PR04CA0161.outlook.office365.com
 (2603:10b6:806:125::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:55:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:25 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:23 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 00/12] virtio_net: Add ethtool flow rules support
Date: Mon, 3 Nov 2025 16:55:02 -0600
Message-ID: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 43339e42-25d7-4c90-47f6-08de1b2c1f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xjEFPfanaiHDmnz+ICh71iPl3FRl43glNuTFtMA+e4DEIIuuDh3Seq7xiR5H?=
 =?us-ascii?Q?BJKAB9W4UbIuWp3gY3tdR9qjV4J56h6lymq6m0tYX8iXE+JhuiQohLLzRNs8?=
 =?us-ascii?Q?iNAfTObc9HDntHqqgcXNDNwBaxYGlhy1nedgTrbrNq0I96EySude2CCEobSF?=
 =?us-ascii?Q?czGC8sCbbIEyUAbUw4NwepRpkmvi5NXePApz8NtKd6UaBW3q1BEF1kpgVRKv?=
 =?us-ascii?Q?sProLPkQEqy2BprIT/OLxG8Ov1YB9FY0JRfme6XFJ/6YfnhqrDuS0TSATXUJ?=
 =?us-ascii?Q?pQP1J2cr/0aMAqGTnULzp8iAgoIcpqKpVXcne1UwFz1kgJM9ySJ7kUhfqJGa?=
 =?us-ascii?Q?g+hj0uceP/aQYIdhbQwD3zsnTTb9dbGXJBQUvAQ7vAL5/xnZLsAMiARXOSBP?=
 =?us-ascii?Q?LJxPGJWOR+aMUrk4g2FODxXSIzvhEGDGcGJ+2BLifKF2958E1hT0P8OWgPKr?=
 =?us-ascii?Q?yi3KRXyVvN8kBvKSCWqHxTdcCT9D3if6flQ68rzbPPEeYtUAiCsFmP2Z/x1i?=
 =?us-ascii?Q?ZgCc9I2M/c7KVtOfmXMI7riPOabpNZH5j8QXQ9ZFSBTx51rZK/dBT9AooKKj?=
 =?us-ascii?Q?Y7DvCH9/szdXrsOFXk6pln9es+OH30c669kZnJkspPrGjhIKTy5VA8gLK+I8?=
 =?us-ascii?Q?li61YD+jcrf2MqQ4lL76cQ3yNruknrJDezVLGrZJ8M3VKFunG+0chmf87Lm5?=
 =?us-ascii?Q?tBasfddHnhGXjOlBNe9k+XYKQsp78ZsbyXBuorkiKi/Yi1cDOTRjouldoXBy?=
 =?us-ascii?Q?eSKkisYjvo3C8ft3bA6HZYy8XW7Dtt7ejO4nYaRhc1+YB7NlJVJMMFDLlBQc?=
 =?us-ascii?Q?YyYEdUUPLfkjkVlVNNIe2qUno1hAX4id4hVPo61Gfqp9mIACAK9bPXN2N4X5?=
 =?us-ascii?Q?UvaIC0tcA8n+PzvXFft0zhZvKqyrLbFjXsEm/ZLftu0Obno7VltK/3QejJzL?=
 =?us-ascii?Q?FWs/c/zTgjoAhrrE0yjSzhi1WlPds8dt7zfQ8pIgYNQG2RMW5wAJs6hdyGmO?=
 =?us-ascii?Q?KusLuUEffGKOpxA5ISu0SU5szIX/iWdcqKHhHNM46/cU4RQ8usQZFCN3j/8v?=
 =?us-ascii?Q?hQx10WSdex2X0jVEcjHz/ssEop9JLSR6HtnKh/10eZc/4ZeIXc81tBHb0u7h?=
 =?us-ascii?Q?9tAnvhX9ynY3Fu6OHkvJPatBp6vmga3Cq4xJ0qgyg8N0gF54XRTBDFO9vqP/?=
 =?us-ascii?Q?j1UwnEHBh8YBdhcbir8y6lGuTO2DbjfkwcuwhEPv7daxPQ54wuaw2WBm0PVn?=
 =?us-ascii?Q?zkyUAc35Qv7NNFfItSFbUQLlBqSbF91amdE/Zli8zKMzGVup0PgoNUyQJxl7?=
 =?us-ascii?Q?t+CtF3WF7MJfxj2mViiPDHpQYwWAFK672Xx8kxybgNjU+C8UmVeXbJILWJBX?=
 =?us-ascii?Q?qXyRZUiOweaQGSoXI+RgHgu183aHcXAjDwNd1U40gHVDsSnmjRSKf/HSfLZ/?=
 =?us-ascii?Q?emg2+xGqZ3cni/d62Bc+z82ob5ksE9Qo8IbrRJiarXZYQmxUmQJYkYDaXfas?=
 =?us-ascii?Q?HVWe8nh9vztEjfGEbvRm4dohWHlgXUqduFwCLiseJV444d3gA1LHBEqdC6Nw?=
 =?us-ascii?Q?dUet/rAdkqm3yghFlJFMGJf1T17xRh5u9niWaIP+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:55:44.5423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43339e42-25d7-4c90-47f6-08de1b2c1f0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

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

 drivers/net/virtio_net.c               | 1139 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  165 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  125 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  156 ++++
 include/uapi/linux/virtio_pci.h        |    7 +-
 9 files changed, 1600 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


