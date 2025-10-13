Return-Path: <netdev+bounces-228822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E54BBD5134
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A273E5EAC
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7583191AB;
	Mon, 13 Oct 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aYDhjQtx"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036A3191B1
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369288; cv=fail; b=YXJ2kRrmFZGj7p4h3dUEbVbRAOd5fcFXPzpBOOuWX/dDFF2LJ/w1BWHB6/brKkAaDBNZvWD/TbM5XkRHRm5hRiqhgVc7Lcr1ebgrvHNrIajIOzBGJPBs94oxhcRHnD5ZdI5aLyHyKzFkamIc0efsboQTbOHegt0RhlZWuhIwGC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369288; c=relaxed/simple;
	bh=JeUxxITHH7JhmBQ++owSaXgrVGx8t6oXAp1OEGqdCJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lgx6eoyr24kuT/EOEw/9l+iokhDEw+nOLcgBvGnOWZn7L/hs2/lIc2Dzi2oCedgSxPbB3XNZ2z2nbG5kRtqW5wy3GE9Qc7HZ3J0bfE899F/bhewc08fCX69zD6zbKmtXoRikmp/gRtVrVChlgF4IiEXoP38g4aoGgApjelp7cCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aYDhjQtx; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beWGSX+os5unSKH89on4bEqmnDIXYUKIRQW5C6Kw7sebhE9TRTKEr9gz4j06lvM8RCKgLUd5z89p30kk90e0AU2dBMrvbSCs7lEGfTqWo6twrAcokOLw2Lzyp9OrsjmFedWc60e9w04QEonYb1ER5sd8pyPOjgXg6OVuXtVzMcNnOve8aCdVKlBCC3Em6wE4HusUSKz+3b/ZVttK5PTGvo241BK2eYnVaDXawlcjPyO5AjyvoQHvp8b1izuo6CyFer45uQu+MjFRbh1XYpgDarJpcYNOH6oUMfwr6mqZejmBOxgB1r/l6MCech7TveS9jAjr7uju0HCrhWsTpRLxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW/yekQJFH7hKr7ZJPP1+C69r11+MWoVS2xIVy9WH1I=;
 b=lXCr63I3m5OkjTgt9pX/57pFJiCXhwSnKCnJDS1ugmG+Lyd36k0skB4XYbVaKbsIDXKIXNpNCt39tvOdGKDjVmr/imGxZ0RJt4ve8ZezmvvTVdxXgxDWwBIHQYgyViyYNqzO+uyd7XdGbYDJqUe4KJACuGKdK7ImC14U3G2kzlYkEDDbmgg6WN+w+0tu+kxrwwG9S0sc8q5RdV3l4OPqDJGuQQOT1DzD3QaxKJClnSOzPCfmcvSzO1ryzJbEYMMMz1wEkN4tvR8/uRYEB4QzyO8AFqtddQthOiFxGhu9BRT2Ousi43jtysosHP11UNSBG4COOB+ZWetAGLkHdHAtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW/yekQJFH7hKr7ZJPP1+C69r11+MWoVS2xIVy9WH1I=;
 b=aYDhjQtxoSK8sCxIcplWTJxz2V1Z/hX+DMhtg0ktXwvMOL3A7t9HW3EM+7eHEh6q0Oax44UOSZbltlstQ98a5yM/5p4MdQlLOapJziBtI2oX/2lhsTz39IviNmAfQMvpDTu4weIv2YSCS5m+eg0LchitnPLCC2DWUQvjY/nwrzqjnfv0KaYcf++ln4x+PZPB3ZJqrpM4dbGWuGIbrpqDWqehxay0s2DVX7QfeB9RH4Yx3mu7SRztkk0bCtOTSqiFz8mIYVoZ87PtOWqpOfWrTd7NCu7FdWhkURGEKWp4bcymoW7rbbh49Hqpm+dpEpKI6f6ICTdEXaQnCBiheT4FZA==
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 15:28:03 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::6c) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 15:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 15:28:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:27:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:27:52 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:27:50 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 00/12] virtio_net: Add ethtool flow rules support
Date: Mon, 13 Oct 2025 10:27:30 -0500
Message-ID: <20251013152742.619423-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 2328f1fb-2e7c-4acc-6f43-08de0a6d197c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?unsFzxYJli4NOkov2Z7QMhIN48d//ypk+Vx3fDqWJO7axoARnbLa82CAKUxb?=
 =?us-ascii?Q?fpPL9y8QwAWnrELt6eEX99eOuT84j9ftFQ0q1l+aqmen/gKQgcQZZq1go08Y?=
 =?us-ascii?Q?A9H6bebcGeunx4gEsCQd152YVZHSH+bwVsuxDAs6XhIbx3ivbRA0W0CZJQx2?=
 =?us-ascii?Q?b3M+yT18gI1xvyRWUrxHW0FMfIookSdabj5fwj+evYdVWj8Rco/Qyb9ome9g?=
 =?us-ascii?Q?7TRdA3FmWDXFK2W/HXtyBZu4954jis/8GfC+kxO6mVYj59kbbUjHogqgK+gg?=
 =?us-ascii?Q?aZo7Rg/gQ6paGFfP2JOHZSoO1EjczeFn7EnpvckheVMrBY3xsY7566mGeMom?=
 =?us-ascii?Q?Qpjb449Xl8MxC9sx1Od+2UO18CkTtupHnKIM0p6mxiXsaT75Chqa45/4dCfE?=
 =?us-ascii?Q?I0tvodVJVhLQzfRFq8HDOUTq8bFQuOHQmv3hV2v7lFNwRdX+oT6yB27EiRwk?=
 =?us-ascii?Q?ULCGsy8TglMvAQG0GjjfknkNr6buKc3/sk0jWKPSZ2KM9zJbq2fJO1I+UF4D?=
 =?us-ascii?Q?4ChVTiN3HYbxqdArCF5WxlkPREefFIfCZoxIRfFUp/yGPiV8sCxM9vP3ikR0?=
 =?us-ascii?Q?UpCwsm5pgbi7fcaO5HWZyqUOnSs7YYMwgfB5UIzU0HMF9r8MM5BaV4hNajtu?=
 =?us-ascii?Q?JqNEzfSzROAv+Ow+0A0oo3BT2BoMn4viiOumNAUnGO4TecyD2HjGVqJbcuyx?=
 =?us-ascii?Q?MkmkVxMmnde8n+naf1XcgjHR6ZWNuU7QrxslilZGoDrpbXNLXFfNnqNIHt0j?=
 =?us-ascii?Q?LgMwQJZyYk5gS3Au+j/X7SbZqIEc24mv1UHh+60eScfF+xLU1BlYMi9fGo1j?=
 =?us-ascii?Q?iujKn+/iMW7vs1yMqfHYFki9Eul2FscycGovkdPC8xMwXxKMas8GEeyoROG9?=
 =?us-ascii?Q?Krk7v3tmy8Sp+3pIVCGurCJnarg7iJCW/YWAXe/lMCoEJJdvasUsn4YpN33t?=
 =?us-ascii?Q?gFl0wblch67EPpJ00XHQlVsKqSNoCX1pwhDVmI7hodjW8nhIZJ8BLWlXOWNy?=
 =?us-ascii?Q?Dfqim9OKUa+VNflRwuH6c2licHaKj6/OZ0JTyyeMMhTZJh+n7WK9vynQkRq2?=
 =?us-ascii?Q?hNBg3HxB7CGFht0qM2smtaTEEQy280jbnxALdmvKBtAHJ4PXrJHEZEvnAMPQ?=
 =?us-ascii?Q?IKO+rV2mgrPxxc1i8X78AMHfUkzy9mzhEoU+fWMJxKyAPFMSNvF0ZKkgF4pQ?=
 =?us-ascii?Q?AuDUFrzAbWPUuAX/RYDCv3CtOw3RimDSHUNF3EGp5iWKRYd//3v9IHZnIhnT?=
 =?us-ascii?Q?6EhSq8JzlW6BVqonTQDmOARkKwyu3SpoNpawZkvdoS7IH9fwBbJ6bDr6tFqQ?=
 =?us-ascii?Q?Ek+DakTkKS7tO9zFThyts2eTJisVuQjoSapl+40X7APPVh8uALPWLlQmqXdH?=
 =?us-ascii?Q?x6Ouu73NskAg/5Izk1+DASAzLV4e9T3po1ed1eLw7dfd74RodolXzMm19e8B?=
 =?us-ascii?Q?mpfLNaf91w7Qpy9brnEYAXH3JtIWF6citoZCwkDVmvI6M0Ve2qfA+CEzk6gI?=
 =?us-ascii?Q?3yrSgqnaOr9s1FqHgFIxwwVV6v1fAVh1t/orahWjDOmko9atyO8wucAMbo6a?=
 =?us-ascii?Q?2HfBjumMnnKfqCYKUkO/aYEHdqNm+m9BLdGINiRT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:02.7111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2328f1fb-2e7c-4acc-6f43-08de0a6d197c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

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
 drivers/virtio/virtio_admin_commands.c |  166 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |    9 +-
 include/linux/virtio_admin.h           |  121 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  156 ++++
 include/uapi/linux/virtio_pci.h        |    7 +-
 9 files changed, 1577 insertions(+), 10 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


