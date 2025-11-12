Return-Path: <netdev+bounces-238105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F12C54438
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83E084EEFDA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8192798ED;
	Wed, 12 Nov 2025 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b5Dem9Ze"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6621CFF7
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975928; cv=fail; b=EhLo+GXU+zQVnzi6KRtcfoF5lIZuadxVmRB3VQiFEgCE6vsHgs8f6WVoSAav0nKMUrNbcluyUQoYRp5RozSil9a/p1syinS9R5w+U93DVxD/k1IDsDxGBMBXap6lIBqDNIbLwlil2PuP8JkIwu1iYGB0uGcMoL0itL+HdcGX8A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975928; c=relaxed/simple;
	bh=MgVUKTzuso+Brt3Sxva5PLB+MZHms6ATaAhpk7eE900=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmxypTbOWdqeF1VypJRBoFkfkNmdvatJj2pbLhDJrT+X13q2ZYE+odIeyx06m9TMwPnHtP1p4Df2XZczlnfM4f/2ZLqdi25NrI8RxYfKU6pUUqLR71GxpJYs8mmPP6tzh3d1B7i9vahchnLJ5dBtEMyEby36GH3BULq/GR1AIVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b5Dem9Ze; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvoYdHFAzKbi9mVUqfx+Irtysijp4gVq9yJuZzMMEJfkRyNulq7Cr8j3Anxj3CBMRRcfjuefZlOD+0PfK0XoGI2J/M6SmFksE+Ct6iv0bDyO4XZbivhZDk7pokJlCdPtoBJke6OBz5NhtgX/pl+9KWa7g+higNw1ZibbJqPQ/WY6aSJZjDBXKc2UZ9faKEW+phH61k/4kw5Smt3bo++9VsrbK8idzmca7B5Fvj4z32z7jFOk+yLPiB3aajFHx8GcRKuwe2ki5bTtVgYgfK7KU3mM+pUzCT4oMDt3wAOwzbPmsSieCEOkhhH2UVlJ3RArkXaIbaGkJVtrSZZoip8qFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0c28jKHkUYo3Mc5ygKXbSlkVOxmegkfjUVCyhtoPug=;
 b=VuDI8phfXAnP+tmVsVDqnbTywLfDvb/9DSbydfeI0G/UJ8s909OKA2b/dXVBiNEm4AN5aTIpkV0FX6uRFLMrEY9GxUfvPKFBepNdRec8rDdZpnF4LDHng/vVCDZw48COkgLSfob5yZDjVVQ9bkaM3kj02wJYrIDSMVedQnklQVmRXUxlShKykapFESqVq/nyT2+a43rCFIdJVyevYqhmMnskwagX7PAusUXmHXqEClni2Fbe4M+xAW2ZM6R1KxXEKWGyXe+aOpp7hqJP8/42301uK3fmxF0b+mEt48+vjYm4nKoXDHt2TAfroIreFRxZ00H7yz8WcuecB4XRb0dplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0c28jKHkUYo3Mc5ygKXbSlkVOxmegkfjUVCyhtoPug=;
 b=b5Dem9Ze8YJAaKW3loVBZh6EvbSwvAi/8J85uTkNLexFK4ctaepMRVjyJHTBxFSSpSag3VqGfLfOn1OJe1FzvPX5JQRT0i/L5V91uopY0gISkV3HV1I0zaMOBqOKeYCbG044zGzpxqr9j7FxZjRnpE10GsL8aY1SkHiSCrepSt5a5Z/6zHtvrPqgL9+TlWjmT7wOBfWHHkzyMT5wZ1hQuP2qZWM51Z/TfE8594p4SfsvdslOdcJ5TtNH0NrQQ6vtz6hnIdj08BtVVa0pESyS3U7Y/FcO9AUrd9V8QMfOr10h/MyL89qBaXIaZr92CVJpnqiE+qRkGeynAIIZqHv9iw==
Received: from BN9PR03CA0486.namprd03.prod.outlook.com (2603:10b6:408:130::11)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 19:31:56 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::a5) by BN9PR03CA0486.outlook.office365.com
 (2603:10b6:408:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 19:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:31:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:31:41 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:31:40 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:31:39 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 00/12] virtio_net: Add ethtool flow rules support
Date: Wed, 12 Nov 2025 13:31:20 -0600
Message-ID: <20251112193132.1909-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f2e8ec-15ec-4e50-d7ca-08de222223fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMM6nQXNrT5I6ElaZQE78tXU8U/onZM2Ost9tLrr5nBChVQDVvrB7oz6z5MC?=
 =?us-ascii?Q?n7/1eNZGMxpo/xUn4ZZYni3EWnX789qGNsiJGJ084svQ9pZ2tACY1UTFUlWb?=
 =?us-ascii?Q?cg0picg4A8euJLwbKgPM58X/dDTHyMltNRKl0BDxnLdL4itndXbkS53ZhH31?=
 =?us-ascii?Q?OKARF4A7k1MnwlbObnyBoQ8cuCQwZE5a9aShGKICEYzttjg6lfyTKIhAopd3?=
 =?us-ascii?Q?tDQv9Gs94HEDaZZaWKgI6sh0hwme/vjvEdxxMjNI0UA38S6ovyKsNWoG9E7g?=
 =?us-ascii?Q?1hrh+dxeba+/87TDl6v7oinnG8HKM2y/qgPEIARcEadz1HC79jbQYQS0ZxUe?=
 =?us-ascii?Q?5olpad8K8LsEy9kMS+aumLuok5lv/vuX4GMZDsGIFJuZuCEPqg9/9oaJ4EpS?=
 =?us-ascii?Q?p6Rq3UEXZ2ppubPWVk4uIvnKVziMwXR8+/XJuTzw8XrNXu7xWjK5ZVmMq3z4?=
 =?us-ascii?Q?gjpWex1xcez6RfwMnc8OYyzk74kOkVE39QTBy4N4Y8DkGQmiuuhlAIt4pIN5?=
 =?us-ascii?Q?5IsMZSf0j4+SJQCupFCk9GKK0bXv7H5Fu86KQ3z5WoBTj5eOsXBwEhF1ia6E?=
 =?us-ascii?Q?joDYo5oEr/IE+BGrsosTpZW8Hoh5b6HJC0OHgzm2uvLHz0C/qLh2eRqkfCxb?=
 =?us-ascii?Q?sJlFEkvXXiC9BmyTPwodIhI/04dNrie/aiB4Q89IT3rtPczIftq7GRig1TC5?=
 =?us-ascii?Q?0c/QyVKJGTEAtD3CZj8Sizy3g7hBbfXzzOy2zFHDyVqMcedApoXp6QEzCub0?=
 =?us-ascii?Q?G58PHV0kqGjXchmp1SK54Aj+Lw9w5Re9awjDC7ee63EL9L0kx0VYDCMdWjOu?=
 =?us-ascii?Q?v/B36HfevmYqlW6YNLwisUTb0rWrAE8M1O42bdI+RCbPLMctiZmjmIkRZD8h?=
 =?us-ascii?Q?bX7jH3GlnRymAyhwIL/25dtHia+kr7rivxOOF041w+PQrdo3GBGSdw/yVaLt?=
 =?us-ascii?Q?EbxagLuaOYA7yyfNYVPoVnFXkspEllCEkFoPBxFpTA4cav2/99gdWd24yPPu?=
 =?us-ascii?Q?ZhfZRzK2KyGrneGALOYDvlmstdf2IqA5Qqavw4biMIjrnaGeUsqpfLXebfJO?=
 =?us-ascii?Q?v3c3SeFDdYcYE5lyyNvTMiZiEDmFyGEoWxE5P+v14UHgb6Dtgl6ARgW6JV7b?=
 =?us-ascii?Q?Hg9NWsXD0XEy98HN+NiKZpFQQ4zcncv8+4h0CwkfH5/IWk5MfsgA0EMn9aY3?=
 =?us-ascii?Q?lKNw8RDbx5+y4lL/F5fFNbmgo2ezoQ2Odw9lfuVMdKIkYrKinuUOVLfC3SJ2?=
 =?us-ascii?Q?NsHcmQBVLOhbdjhTLbg9X+/YraPzRtLyAxjVP2Z0KR6d9Ar+8v1ebI7Ef7A4?=
 =?us-ascii?Q?rPk4jm5sm1WNgmE3EP3s5iz7XTy8FprRuxwNrlsAJ/625oVYtHLcVB75r4Xk?=
 =?us-ascii?Q?2EPSgPUjANS9pfyufH50UlviHt6EkupR6byqZrcYnQw3soQAP76T+jiLKsoZ?=
 =?us-ascii?Q?whg9Wr6yB/4p36jiSZiGgaRpNC1FjdkHdpLIASYT19FDtvFYf6oNR5JGEQ+g?=
 =?us-ascii?Q?Z9uWG++u77V8ef8Q6B8cpeqXXIOQk823AaLqXOkQZYW/TgCsXewBYjBmn7tp?=
 =?us-ascii?Q?HuuPaxk1wfLs1wySi+5RbXxCz+/kiXzV6FLt1AVH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:31:55.9198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f2e8ec-15ec-4e50-d7ca-08de222223fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568

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

 drivers/net/virtio_net.c               | 1147 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  165 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  125 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  156 ++++
 include/uapi/linux/virtio_pci.h        |    7 +-
 9 files changed, 1608 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


