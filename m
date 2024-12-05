Return-Path: <netdev+bounces-149437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B129E5A10
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15AD2859EC
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A410221446;
	Thu,  5 Dec 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upWcGcj3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05521CA02
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413424; cv=fail; b=rqY+AL1J2nCbs06CkjCzMTCPwLprZftf3E/0z3kxMo8/kh7x1/vZevJtGaNlVOhragJoSnhqgUI1x/kaoRNfDPFI1KYWtJAokro+9l0R8ZE6Dg1Q2OZaB6tieDgiSDb0szLVK/PUDEzfYg8K3crgiViko53EY2/ldc7QIrr6nVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413424; c=relaxed/simple;
	bh=ipZYswxHSlX4+RgJyF/y433kneUcn1OgObPOb/z5XHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CJJUjP0atym7lZD9K7z9s6F1DHVA7JOnFgZf+cnA4rekhhjN3x17AexxSF9iF5y/tAyrhcXuoLQ/ed0pxVqx7BYzRokJnfgmyM/TJvOH9q+b7q8o1QNrxmCcAFwmu08QTaWXd2uZ0DORIQLpeaQN5anyRmRFiiSSLUvbom/YWso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upWcGcj3; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQLLZaHsEf+oJwkQRNk1ThL0Hsji1FoP4TtTYXTA4Vfoc6+u599RFxEBqlCIhpJWkrZqolkY7Ze3S9To9MdoCPUgqT0MbiJrcvW/MZqcgaGsdWrTtl/W8ADvZBRcnreHeF04XR4DN8iCH9jp5SMC9bgfb+UbasHartkc4OogcChihLFRi1D2XKD8Kml3784HlTtsBNndv2YQUpUs2izKeGBVTkSHewHVwcpxQ3lGAhQjPWcd977j43QmK9pDMhgcIHXE3rI5OOIiUESQWfqR/X97OoNGSGjYXRoQkyo34ERLkj++uUqLTu7K9BMaT9ha2PJCeq9WYj1kWaj8J2c/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6kNB5lwWgspG8qQpLR3oADN9/YuNqQmxGHYxP+NoMI=;
 b=IPGwGahIGyN2zqgESnBKoqO9vJI5DohAuqdL2utUuz99FeyThtxWrSZ1Mf9yWxrVPN0riNJTiV/6/KCjCP77bYKzKRyOzd/+YUvUSeCag27zH47v/NrmqnLuJ+MhyOq10x3tkxWJlxSIVLj3mh0YgAW4a1oW5TK7RqEY5kOGJNCWmpFsBgVbODpUQ32VrOZNC3Bt3pW/HcHm/Luh15Ur8a0gcQYD+6S/gc9neMMzpcJJpE1qzErXyfnMkGz7337qZKIzD0AKNwG9BngiUHPf7wIyhfWXmbqvbzbksxcZ8zXTSBhdZNU8HNVY9pWtse1AXS+KfYRi+9Bevu+Q8FKdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6kNB5lwWgspG8qQpLR3oADN9/YuNqQmxGHYxP+NoMI=;
 b=upWcGcj3fC8ZQgjny8RS0kIcKtURamQFuOq2UkwH3H/KMmIUnKAl3Tn5Waokd6JdpIpt4hesu5Qo2hTMlO61vzmNLAeKrUZoF21Z25fqJcjQdub+Lvk1GMr3dg906bRQcIBV6prfsc3+Wil5d88QrQ/0RpC/on5QYUGQ9EuvB8Vv2OMdXUlH3jOx9lUgZijDcySvrpKsX460ljPc3QlUOwsudfIiZOuNMzTTXa4dqyh4LY+zJo6fqvlif0s6QRUDRy1aYpv+LVM/ddTQR3Ry6bMKqbdhCCujkv2yYr+JuFlTrttsHwxr5X/6GYtqS9w0P6YXWDY9UmtqvedUpeVIQA==
Received: from DM6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:5:bc::34) by
 PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Thu, 5 Dec 2024 15:43:39 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::2d) by DM6PR13CA0021.outlook.office365.com
 (2603:10b6:5:bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 15:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:43:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:20 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:14 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 00/11] vxlan: Support user-defined reserved bits
Date: Thu, 5 Dec 2024 16:40:49 +0100
Message-ID: <cover.1733412063.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 6805dcd0-b2c1-43bd-f331-08dd15439634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+nMI6T3uq0rINjKbr0NNoR/sMgPQN4jHCaGPIhBT5hr6Xw/SMGGKaSn0DvvQ?=
 =?us-ascii?Q?ho2ugzSIwOceRojlkuR1y3+MnlVR7FyaGJBoBYcZZaETmm92jT6x5B/VaH+y?=
 =?us-ascii?Q?UvDW+mzIIKNOs1NDtAAfth29yloEecg5r+GRPIbbsdjSr6zKLggGJpkL86w/?=
 =?us-ascii?Q?rf/IDj+ENyq19V2w7fg2QZ4km3gML2qf1XK4tzXVSGceLlvLODEdtIEe6iF3?=
 =?us-ascii?Q?h3nRJSw9MJGpbjCgqRwE8EGgwpm8gqOEzefd0waUo+XM5oempDezJAE83Bpr?=
 =?us-ascii?Q?u5GOaE83EvyHM7TcStNUnKATvHS8/CHxf/VC/sVsH1PYscsE+dWEYnKumh2U?=
 =?us-ascii?Q?IK/mvB5IdzO17bzP3Ln58xtrKg6b8M21GI/tCKIyMnmxFUn+PWQWZsXDRoh8?=
 =?us-ascii?Q?1LUjPM1TSvSR4uDHFm6IDbc2IJsFqm9udnj73i8E8W6OjXG+RZ3FJQH7Ijlj?=
 =?us-ascii?Q?izqjZMc7wa053EUJpaAEwgcvUk0c/rfcPvgTI8KOR/XVpJV24xP0MrQ5TXFp?=
 =?us-ascii?Q?HSm+zYKccmIK4amWbKOkQLo6LPZYiy5FMUoSY1YkchdtNqfXDDcxgl4is2iV?=
 =?us-ascii?Q?JYepRGPHlcWsmVp7vHfcmvJOqf0oQEphu9gdbRjUXPzLaLU2Sk3suubCuEMc?=
 =?us-ascii?Q?LSGlTOxRpKlz+lRkegancrIc2aiSK0yK//djCawfFi3d9zhhWb90YTRBVLwZ?=
 =?us-ascii?Q?mV//PRCnasgKAdVly9jRZP0dLoaLyo/FY565hdjk7Iu59Bkb+DQLdyG5ZiWx?=
 =?us-ascii?Q?nXlnh44CP2NA0+HAJKoPplU5kdKBxIOr3VvdMVRjy6E0OfrXDRgDA8kgfaDf?=
 =?us-ascii?Q?lt9aeET0HRzrlY9tljsA9TmhYKPjJO1m34ReMJYbv7gfKZAvdhxI85RLKEAT?=
 =?us-ascii?Q?bbSre5bvbNV5O1khAGODx7SQMu9H0B+OLOlopnwRIHNsv+X34QLYKEQCDKJB?=
 =?us-ascii?Q?ltoujZvGdQpE0PqZvPlTGfwXPwYX5XCQBdmepr89UsYC2YuRrlhcwdkSsFGD?=
 =?us-ascii?Q?NgwAkorgSKqPjHDFXHL+tJELaUo5zI6CvDlkmm7UwszySAWom9zdaXLADW9f?=
 =?us-ascii?Q?B+biHinTQBy53xqdBtbZ9iZp+v6dtQVHY4WoQzAM7g1Ag8JsNpbuIHxI71LD?=
 =?us-ascii?Q?VUkmgv9MH3lL7hcMJAFXIGogZS2bhhmTyuwn77UQeuJ6NTl+ZdeKVjEG9waM?=
 =?us-ascii?Q?VOuHOWGT9LziNJFlkJ4wSkBypZOg5ZOdN686nrOjwP+gRVqeyPM8F7PhN3UI?=
 =?us-ascii?Q?bHiF7dKNX5hNblJiIbl7HQaQanzm0LOH1sdqFwo8ImFkI9N5AKD/vUHPMcSM?=
 =?us-ascii?Q?rOmUK0Rxai/almjPHC3DED7O6cAG5hlZ0DE53B78WexDN7qx9FCXOG0nCDxK?=
 =?us-ascii?Q?WeLYPzUHjLabZcCZmqBHnjU5iZSymH70dBIPXbBm0Xf6cdTTkdAIo7KejII6?=
 =?us-ascii?Q?Vpz85V8iUkfVukQjSAL8fkGnXnv1pLGS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:43:38.2116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6805dcd0-b2c1-43bd-f331-08dd15439634
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648

Currently the VXLAN header validation works by vxlan_rcv() going feature
by feature, each feature clearing the bits that it consumes. If anything
is left unparsed at the end, the packet is rejected.

Unfortunately there are machines out there that send VXLAN packets with
reserved bits set, even if they are configured to not use the
corresponding features. One such report is here[1], and we have heard
similar complaints from our customers as well.

This patchset adds an attribute that makes it configurable which bits
the user wishes to tolerate and which they consider reserved. This was
recommended in [1] as well.

A knob like that inevitably allows users to set as reserved bits that
are in fact required for the features enabled by the netdevice, such as
GPE. This is detected, and such configurations are rejected.

In patches #1..#7, the reserved bits validation code is gradually moved
away from the unparsed approach described above, to one where a given
set of valid bits is precomputed and then the packet is validated
against that.

In patch #8, this precomputed set is made configurable through a new
attribute IFLA_VXLAN_RESERVED_BITS.

Patches #9 and #10 massage the testsuite a bit, so that patch #11 can
introduce a selftest for the resreved bits feature.

The corresponding iproute2 support is available in [2].

[1] https://lore.kernel.org/netdev/db8b9e19-ad75-44d3-bfb2-46590d426ff5@proxmox.com/
[2] https://github.com/pmachata/iproute2/commits/vxlan_reserved_bits/

v2:
- Patch #11:
    - Add the new test to Makefile

v1 (vs. RFC):
- No changes.

Petr Machata (11):
  vxlan: In vxlan_rcv(), access flags through the vxlan netdevice
  vxlan: vxlan_rcv() callees: Move clearing of unparsed flags out
  vxlan: vxlan_rcv() callees: Drop the unparsed argument
  vxlan: vxlan_rcv(): Extract vxlan_hdr(skb) to a named variable
  vxlan: Track reserved bits explicitly as part of the configuration
  vxlan: Bump error counters for header mismatches
  vxlan: vxlan_rcv(): Drop unparsed
  vxlan: Add an attribute to make VXLAN header validation configurable
  selftests: net: lib: Rename ip_link_master() to ip_link_set_master()
  selftests: net: lib: Add several autodefer helpers
  selftests: forwarding: Add a selftest for the new reserved_bits UAPI

 drivers/net/vxlan/vxlan_core.c                | 150 +++++---
 include/net/vxlan.h                           |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 tools/testing/selftests/net/fdb_notify.sh     |   6 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |   7 -
 .../net/forwarding/vxlan_reserved.sh          | 352 ++++++++++++++++++
 tools/testing/selftests/net/lib.sh            |  41 +-
 8 files changed, 497 insertions(+), 62 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_reserved.sh

-- 
2.47.0


