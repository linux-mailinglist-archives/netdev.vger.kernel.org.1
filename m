Return-Path: <netdev+bounces-217406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A279AB389B1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635112070AD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F32E0B48;
	Wed, 27 Aug 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4VZ5wQi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FADC2D5C7A
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319963; cv=fail; b=P5RVIsmYmEwwuj2eF4rsQNclPWLcdFI0v8eJAtx1RtMu310UD6Ti8mfWTCSNuzEjhkCCR9sQ6vFePd0Jq/Lb/q3wTFqHtK+lw6KuazPnbo+1y3X50pjtGJkS0c4kl1o1yhi+4jRKg7iRIrNPMb3BF9OybozNGLEHB2+bWwWyYMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319963; c=relaxed/simple;
	bh=pAeljbBEbUY/7U/GINzKivFW5FI2Q/gCfVNvpy0TH2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PPBbYesqclIAAmywvwg5uo7cDFPPYSW2BTkT9e5yyUC/L1JOSAyPuqd8blsKqrZdZLBvpgUMRc9zxEuNpmtKIlTLMKY17A4tK6RFH+Gr5s/WK2XWu/bq+esVQO2Azm5jJM6segZr6R2Wb1iOjraUw8aLRcknCN7Rl3B83HRdAtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J4VZ5wQi; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyemFAiwjrJpL/9tk3ZCFQCDFCdCMNm7rFDJfYJEJYnJD2ZiqEIAn1GbK6PzmiwUp5riPbyUL9t5Nt5yrK+OhbSG4k8R4hG/Gg6znflMGzmi7W2ozM55EpVwEXKFfb/DrNKpwvQGgXbMbTenHAn9L6J4R6ZdInNJa8djg/sLe7CuQeIMx3X3z5XSNBIMjaxioNZAFmYlPg8wQVCh97j8ZxUkTEgUzh2hwpzSWdse1QzcVcC5DWkvPyDeycgD7oG9FHfCG2IsWh6Eo5AoFiXN2X7HRewCqyU4mkqbqB5mEHnMe/LV1w60ErxDFalwepGRHDeqK9Kav9MVkLOVehhSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw1bBUd9Dx42hgVCJOK2In09UX7O4oLJUYTA/v3llvk=;
 b=ZTsT01b+rj6YdV1gtWgVvztF5Fn1pzcSSdTScsylcWYpilhz7eCk6iv4hEdKLj8DbE41ZhDE2fGCJgnaW3Xw2ZBAw3H/ZBmogYGNknOrlKrm4w8EWKivggOnq4iVxg/I9iCWFMuJ/ymoU5Ouzf6ZBV9QFCzAIflmQ2JB+SWjOp0/jysgcXP3fQJYXUVPzYjlq01JmgAABWfq6pu8//WDnGW+XOD9C4WRDWRQLry7/y87z4ipFfmQD5U2RUfG+U59GQYZQmd1dFwIPp1CQbugb6GdiohRfHs2ACF285vm78BB4lv79/oaTefRoB+gnxMzvd+87sJ7NUlzCJ6YKqdUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw1bBUd9Dx42hgVCJOK2In09UX7O4oLJUYTA/v3llvk=;
 b=J4VZ5wQi9yO/n1Yrja6KICXi73AFmEIlTBJspOqIpzRLBgXdJtYHcPjOZv8Ov6KIwIhiHfywnQpNE/QkDwB2PW0lM1FIgnVnhx+SibsAEiJrplRPz5tUs0U50gaOPPumcGgaOczqp7R3p9cKb/FQDC565y/xmxw97ApW77oNzFnZ5sERof7E63u97zBCPG+4/YfF45f3YNr75oeJZvj3goEitu0u4S58EwGdPrYrOIXoIamxtbtL8P3XOPMCyjSraR7yAEDh5iY9vlpQKU/DUrxYfgyL8iQ60jl9q3jJAqgsAlDUtMDx7kN+hJy6NWBT9ezutLe+Hn0RN+lTTtoffg==
Received: from BL1PR13CA0403.namprd13.prod.outlook.com (2603:10b6:208:2c2::18)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 18:39:17 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::70) by BL1PR13CA0403.outlook.office365.com
 (2603:10b6:208:2c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Wed,
 27 Aug 2025 18:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 18:39:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:00 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:38:59 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 00/11] virtio_net: Add ethtool flow rules support
Date: Wed, 27 Aug 2025 13:38:41 -0500
Message-ID: <20250827183852.2471-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: ecea20dd-d70b-4ed8-b4bd-08dde5990774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wmlIOYoy2j3KCO66DK0BDRwMrj5hxrTsbEoQDNpFQkYte15C5tiSHAzI7fGn?=
 =?us-ascii?Q?ADE/pJnJxQ3zJcLpv6hWfRRMYvHF/Rqnctwxbd26/GxX6gmqMxJjYr0wgXSp?=
 =?us-ascii?Q?5fuIOezv2IGo3wc7gFR7zlk5lMDfsquj884KKoyokR3H8q8yVIrSEuJs7ciV?=
 =?us-ascii?Q?WBq93soxgXNgyw2m9g+RVr/dsWXsvWjF8ngXgzw+5nZTOnyciXex/qUgclf+?=
 =?us-ascii?Q?oB+UoIODdnTRfml3gvAcH9sLte9QtfVX7J+BEynfsL053cpx/S2e/6vM46nM?=
 =?us-ascii?Q?/kkYkMX/HR19RKAUxOMJ5cfY+r0mNbJTmfFdV5kLtZ+T5e56e9Hq9CCTDeIe?=
 =?us-ascii?Q?RC/A6fOdpwoMoVF0B3r1dk1sG/Jqm/y22YGTyCZcLlKp/Ha6q4vk1c5OKBy8?=
 =?us-ascii?Q?ZkVmwyQOE+l4+k4lhqSz0Imk/azvAcoMHfTJJJOW3qQLkN46aWooJR/0bP1E?=
 =?us-ascii?Q?fjDnoFqrpmZHHVs8vZE5k8xeTjizftqa84q6H/lYSaMynUn3yALJJRIiQnhT?=
 =?us-ascii?Q?bhESKPRKqKzNrN4UiDrLReNdM+c92l8Zl0VAaWcexSbHzJAa7nRv8Y3ubSAf?=
 =?us-ascii?Q?1Um4c3z4E9iLnqzY9GZSCGB+qQJ7DNKPbcJHb0jHY4Cg51x2pD3L2OnFqz71?=
 =?us-ascii?Q?rRFi/BR7aQWhMtLY8xw446YXcj5pFOQ0fwb3X95h58cDbDjjUuxDpIZOeA+y?=
 =?us-ascii?Q?Q9jVM6eCyC9EHvh+wGaMEN7a8qlAt4Ysr2oU6tzRTj9p8h8hyx/3wzAPZMH+?=
 =?us-ascii?Q?fHNxNh/rlSSDBbtl2eKNwwTlHKefU2Vh7Hcab52GRSQtowBcT3sqdmAThaQL?=
 =?us-ascii?Q?ZHD4nsNy659ck1n9nxsKklivlKS/UvGfKHlJoL2Yjdh2W4vhvKBFB43L5wOt?=
 =?us-ascii?Q?jrW7fN9wnTkfxp5LIhkBciNNd9CLgiFOR6sRpkirftkT1Tr+9Coz/QsOAJpQ?=
 =?us-ascii?Q?2mdjzBzlKWWZOOTPHrtzWQBE5g4wyZg28jHehgZNdxNzA7vPySF7BFa+DN6b?=
 =?us-ascii?Q?BNgM6OpphHpqyK+KtJLfFOGUlq1Kp6wvVdagCJfoUHAJqi3plYws7tnWgHqF?=
 =?us-ascii?Q?+f0aqfHtMWC0ltUcbKqnaNEXfS3yjlYruqK6KX+SNd5ydOE7YPNB4PgZco5N?=
 =?us-ascii?Q?MmYJ67UC8Im5oH9bxWn5lstaTxRjtufw0xqYAvIb8NQuieKRYPkvU9uEE1yw?=
 =?us-ascii?Q?DyUEgsnEOb5/NuofjOBiUHUCtCS8XJlIVDpLMaCkZ3qW8q80DGfLol4nSUEa?=
 =?us-ascii?Q?sIzUbczLqa82stQcgGtjh/zUX4Aj8H6XoVEyOGjF9iy/nLJZkOqRazr3Fq0p?=
 =?us-ascii?Q?I2kKVFQPBWvjBu72CMNGc8ZhjCTgZ3Eb35S00UxZUKXZS/WFMvLCBi+6gf5e?=
 =?us-ascii?Q?8xZAfCAn1HOpdog8R5LCDObat0tiTd0imi03MvqT/x8K2MV1VZiIm4GU7I2o?=
 =?us-ascii?Q?HAoRan/3HT2IybbGrcUlXpnOd0ULtS1JTBI2LKNvJ+I9JIE492ypm97WFJ/O?=
 =?us-ascii?Q?gVu2FAt048baz+JDXqgahqpRHWA811zvws2C?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:17.2451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecea20dd-d70b-4ed8-b4bd-08dde5990774
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

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
 drivers/net/virtio_net/virtio_net_ff.c        | 1027 +++++++++++++++++
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
 15 files changed, 1660 insertions(+), 141 deletions(-)
 create mode 100644 drivers/net/virtio_net/Makefile
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.c
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.h
 rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (99%)
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


