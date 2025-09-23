Return-Path: <netdev+bounces-225631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00202B962E9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEBA447ED7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C0B21019C;
	Tue, 23 Sep 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0pi/VF4"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E218E20
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637192; cv=fail; b=QZ/q6oCKT7YYDGF44Uk4ZGZK8AmiMMraVSfg54vB6ewagoOSO8cwefvMmBl0iB6mCbUuT7D6pQX9Y/ijVe6LyIjAs2bJvIGbEK3NysheWyDrfKlcsYc/xDCTxBFwSPGpso481j/QH+MDUASstiR8b5CKtPjShbLczMlgO52p444=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637192; c=relaxed/simple;
	bh=2S8oOL1uDO4UeU1NE0WmrD/evDQtjt2lxSOX+uH8G20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pHk9mKpAIqsq+qu1o5O3w1ORefeLa35yKcm2eMxvH+y77PNbqZHqQEeKqNY3SttId+/oGfl+7tkO1zEJb9mDa7/6ZpOIMYcNRFXYZsHbLCoitnPFfOMNcprShM1cfMVjnALQWdYWFypkvltdv2uVHDQJRASQwyn4eWPZElX8lEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0pi/VF4; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhElZiaAAfNECRPxtBbv0KafG/ZreIDr3yHQTVJ50JWRXPINrw/zTxVikme9LL5PioZy5Bw8h6/qXwNF/U7QcvLfrf+7ser83lwonjxF/STiLBUBRVgs0Ko/W56+l7XrENOzk6yRdr992suXnrDPAXhCHj2LGfw15J+qJh4tqF4ksq1XIBLeDEcwRNgA+T8K/vblYgz+e8SkJTk79OQT9Db1UUYYY4xYQWr2BwKs/2838ygoaPDX5CXkrGWi4GEKvePzfpabrJ+SewnMEpMbtOGEcaJ39VfR8tItJk2pH10pd2C9ECIn6qP7uDc+Jrez0vqBgmi4SqClUADO0+1nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xZxks5tJy9Rtw5gV+YKhZr/8bQM7sCFWPhy5uzr8k4=;
 b=i4LKLXxMfiEKq1+aqq9p4KWzOCi3v4UI7BC61PHC8lYr/+37RS9+oPObFe3guN2KN2QAQVrXWP6T74TGzoytkDNnhHCdiwdigBOhBI3mdDscnJoqgm0oj15ROiEWa8DfjopQYxB/HYNEqtDZ8C2wISsrxwAiNEHqL8FjrDvZIRxBQYClK7LqpI2VYxT0bwv/crhzXQSD/UtoW7tHtIDqeT2MvIsB8md1xTlKroH5zQ7x1zEeYNZJcNmY+hbOFIB+pEFIyrmIGtkg1NcQ3BxpYPhxHbV/ZlTTf6qxumqjbJRz8XPpIxFSIvGyCRqi8iFodoURoNW2rRa1fRlQ4lGZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xZxks5tJy9Rtw5gV+YKhZr/8bQM7sCFWPhy5uzr8k4=;
 b=E0pi/VF4uv0eszHuCwlOC6WgZl/DPrK1gNejJ56dYKWC2MCAGM0mFTf3+p525T2EdmhJmd1Nmps4KUhMM1aE6XLE3NKPbtKm1gsxJbBI3/YcJCyhxRxsBGTUvyCeuWeck68pvOo70//JMSlveNtHTOFEqor40RJp1qhvWRX6uDRZ0jOESEu/qO7fRb6yPuMSRh3xNNMi751GibQ2ah/NjN5vbGBSqOCz+ZOxFkcHvSYIm/vLoSJddeSQQldHlf/WcEc1HXj6jOwb+S8H+uNa0BuymvrApmU1KDXbAMqIFd1xZwY+JGG2i2INvi4efg94T7X2AXzYkmgZv7tz8WdsEw==
Received: from SJ0PR05CA0140.namprd05.prod.outlook.com (2603:10b6:a03:33d::25)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 14:19:47 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::ff) by SJ0PR05CA0140.outlook.office365.com
 (2603:10b6:a03:33d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 14:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:19:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:30 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:29 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v3 00/11] virtio_net: Add ethtool flow rules support
Date: Tue, 23 Sep 2025 09:19:09 -0500
Message-ID: <20250923141920.283862-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: da16e0db-d0e1-45ef-0e96-08ddfaac3ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09H3rPyDjnWw+9AEBYx9EJjAKIK/kRgUfg/HJxHePJYB/PRRnENeaeX0Ldp+?=
 =?us-ascii?Q?Z02T8KnFg7ghuElZtqjw6sXxriBfkZ/WNdq5Ukw0VcXOGurZdkFmK5UWzYf6?=
 =?us-ascii?Q?fPIY9atFM8gS8yxWMOuVk9jsNQk6m/5aV8TfGK4azm9EjTbWOU0KD16HTSsa?=
 =?us-ascii?Q?yg99QnmhsbcfJlTNY8hfM/QhPTOJfsJwjJuUFHXP2y34aW0sC7Knxw9kXIzy?=
 =?us-ascii?Q?OT8XVwhXeFZSrwsBh4qjwLq0CTvUmNtG5UmvhrCmOC5BPffcvDtOXElIyUZU?=
 =?us-ascii?Q?bxveijFhU+MvS5BaEgqOjwy6eFQV3teTM86sethzr1qozus9l+LAturGM5SI?=
 =?us-ascii?Q?koUDLY4oHNKINpiqEgsYEiiz3lKf7fTtu663EBnbV67GwzyR8hxPEEzlF8Gb?=
 =?us-ascii?Q?/aeAQ1znYYvyT+4ZyBll3dbQAcWyzY/6N8HQEoHjC1DtnEO4rqOcTgpNbEWH?=
 =?us-ascii?Q?xDxCc+3EGA4DAqEG0cgdqST77vHtP7IneETjR31fmVXMjI9KT5AcxM8c/EFp?=
 =?us-ascii?Q?mVvez6BnmDZJ+r3rVZz4Oc3r1ubwzn8nQdVNHCLk54OLCzmz0Hkq4fM9B3x8?=
 =?us-ascii?Q?VZf3UHX3FLeRGknfa7xF1TIhs5vKrQUGrsc6LedgVZc3Qy3Sb4T19ysjW9n2?=
 =?us-ascii?Q?ZdNECPnrmBYNg0UU36cbde5ffw/5OrJJk2HkZ1tRMSIPHJMLBUXd3NcfIfye?=
 =?us-ascii?Q?PqvBFeFL8h0N8686pTr2y+BrR6e/+PQ9vBfhBSocDIwhn9HLUl2JTiSRJIru?=
 =?us-ascii?Q?A+fMnP5K/NVK/+km5lrz6xXutNFtwCwNe4tngVRG2zU+fPqTc5EYrdqm53Uv?=
 =?us-ascii?Q?PWgzt8pd36XF2jAC12MeiK6bynLCKa1Z2Ex/S1Z4XZuyGRMy6m9H9bcj2Gr3?=
 =?us-ascii?Q?3Oh4omEx2kom/BdBCMvgdLAgWc4J1cT52XY8MFKFz2Tr1/70EO4kEyTZKgDV?=
 =?us-ascii?Q?JwOQ6fU4tr+7+gpT15ACYzUBE9R/sSb9vorFRS9UKDQeMZ43LM0+VirF2nKl?=
 =?us-ascii?Q?6MzbmDTM/sGXOl0X/hlM2hhuVL8Yffde0TSPgZV7KaTtP5VxdrXS/ajau3fd?=
 =?us-ascii?Q?yzViF34IHU+3sOPGbIiTEaxbsJiT/MAoqbAC5P3pkzmuWfz78TL3xJKNkqs9?=
 =?us-ascii?Q?TFSdCCcf8Aov2o9tTxfKHxfKQbPofnjcYgWY7Pf7Ii/IvACZWW+aekTrBEy/?=
 =?us-ascii?Q?XO9wgWIGz+MZTZkrEiWmDtXqBW3tDZpy6k0ubJQ04ju7fbjQkb2Ps+Yu4Nhy?=
 =?us-ascii?Q?jqCLp3J+C9hOSJyWzHIodzxb6pD596OelgTMc8DvqVwct0D+Xqmn/a0iTbvs?=
 =?us-ascii?Q?X+qHMBAhM+ZhncHZFNRmyKjtwy0TY0kNubOOykfMsE3p8qFHmNH8S3oFnHqi?=
 =?us-ascii?Q?XxKsWOZlTFwnD2fJWDZ5KhhsMZU2k3W6OdGlgyOREXvnGVbINzkE8ZLMq0M8?=
 =?us-ascii?Q?RDJMWNgsDxTl9vkoVJ2+6H1HxRSaG57XuCw+u6yhg6zj0C4XGrzGuuMfFZcu?=
 =?us-ascii?Q?H8eoYJ4ZXR9jXrWAeCjDWZ+RM9TUjTt9whkp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:19:43.5302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da16e0db-d0e1-45ef-0e96-08ddfaac3ddc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

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

v3:
  - Rebased
	- Added back get|set_rxnfc to virtio_net
  - Added admin_ops to virtio_device kdoc.

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
 .../virtio_net_main.c}                        |   46 +
 drivers/vfio/pci/virtio/migrate.c             |    8 +-
 drivers/virtio/virtio.c                       |  141 +++
 drivers/virtio/virtio_pci_common.h            |    1 -
 drivers/virtio/virtio_pci_modern.c            |  320 ++---
 include/linux/virtio.h                        |   22 +
 include/linux/virtio_admin.h                  |  101 ++
 include/linux/virtio_pci_admin.h              |    7 +-
 include/uapi/linux/virtio_net_ff.h            |   82 ++
 include/uapi/linux/virtio_pci.h               |    7 +-
 15 files changed, 1677 insertions(+), 141 deletions(-)
 create mode 100644 drivers/net/virtio_net/Makefile
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.c
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.h
 rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (99%)
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.45.0


