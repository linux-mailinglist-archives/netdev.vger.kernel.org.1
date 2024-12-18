Return-Path: <netdev+bounces-153088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012BC9F6C25
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223F416F188
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B414AD38;
	Wed, 18 Dec 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ezdFKQpa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346F142624
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542240; cv=fail; b=N0eWvgw9w8IdRANJZxnvvVbTvXYsCvMdM1PyOM7YHscB7pnZ87Vhl2EdDJHBYgcfIkmkgntwkI739pJTBLGYF8/TVDjf4TdnWgBLLVVR+kbW+MrvotzWCEEjCASHrMjhjozFD9G8qu1hMu0zz+I7j+okYKUGqGdIfgHagQqilK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542240; c=relaxed/simple;
	bh=qozwDvCdTyHQUlxqT+61kKXFbqH3duXDfsn159w7kek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQySkULjAs1rlO+bTM1gNixFuDbtmfN2jWtE9xBByu7lpnkphFAih+D4vcWXoUDCJTQ0px6SQLVErhyf2sU7rk/qwHD8ZkwTf8LcXrjCmfGvHR04XzWSzhWMgFpFQPKGxhqE8T3izvFlT41Zg/6lLJVcsQCpE6qlSgwBQSCTeZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ezdFKQpa; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK4PeJI9iaWZFG5rIAKRx0gvP5FvLgoL2KiUXDJRw+5DSrBFdaK1D32PqdkmLf0kpcKvro+Phz5nay7sG17VDXM3RtSutAXe8jLC70UNsBI6cHpmR81ETl4YRUeP9hm4tMMse/XYTokwcz0bIrVR0Hw7CFaPunk9BCROIZVD/y3OL+/+B+kdwbr/ONQYdUe9xJ6PRCBGGazBzIJxoH8fXkcvo+QDkwYfHlk20Phh+uF7ezvGC3dnZQttsSxz9CmTVGGaZt3u2IEN4V/mL6RlFnBoSfMVOZJQG7Yk985XsdIKhB58dd1Ar2aWBOP35le3abO+JyjQ/e15Ow4kAKa9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe+5NnnAQ95S9bKk4Hs/NOkeTXMFpasS9REKt7pr0M4=;
 b=TKhfFOTls3phKQwKXHB+suYXRAP8AggDL/a0zJPmo/qHPreDtr7/shRGEhtvhXa3iafrOkdyt0hY7eJ7x3AU5HLJ6AkUA8yRrjyA0m7L8PMk4hFjbHQuFNgZIKhl8Xtr7sR3XzT4mFrD+P9y/kPEQ7GqpeL0tcZpFWKTuhMEfvjDuUGB2pY4KqiJWf/4y/580GRBoyNUMk9lGhiVniauKgp8biizks1ft0qts9cjEOF8SDLNWxuHbXAi50NIbPb61WZiYr0Itj3ccOmP85tkdd95gPj8JTujuTxdT3d0T/rEDA2L4XJayF2IR8qfXNZLEVINjgaOx2yEWvb8O100ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe+5NnnAQ95S9bKk4Hs/NOkeTXMFpasS9REKt7pr0M4=;
 b=ezdFKQpabNsUpftgMNoOAyZRzmHsdGlImeOiCbQR9jsWwzBUM+EieLJ9DMxMMTNBjtjngiAbRh3ASI35WT42cwjFBlXv3DauVW2P4N1MbvamHjU4fGnX0VCBfrfLmUsyDv5HU/YV2u+WZaIyuBFFg+7laBsJrTEfOoUIXB7rGZruCc3BaN7H/+2YqHsCgPW5JBgO95Bh15TC9ungqH1oQyZGnx09xghw085Y5gUx6sVDtYakRlLMTMdhoTeGKiJ6I7lkg+lfK+BOfvpV3loH6y7KIkYy3821WVa1en56tLtcdrP8Nwc7CRtDVDTYr+8REFL4+9acAWzDvqjGDG/dpw==
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:17:13 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::bf) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 17:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.6 via Frontend Transport; Wed, 18 Dec 2024 17:17:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:16:52 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:16:47 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/4] bridge: Handle changes in VLAN_FLAG_BRIDGE_BINDING
Date: Wed, 18 Dec 2024 18:15:55 +0100
Message-ID: <cover.1734540770.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: f0149339-f575-4f1f-e2bc-08dd1f87d03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?85nvCGMSfPINzPDK+L/5T2lh328DPVR3lau1cSO7bfHIbf+2w3XT3nu7Dlb8?=
 =?us-ascii?Q?SgnmJJzqvq7M9r1UKI/Tml6Z3Qax2hOMSubbdLBP0Fzl9fPSmaRXiLlb5Rru?=
 =?us-ascii?Q?Jpka6JKN7nY/G1yte6aqCDIVMzMsDE9Dxv7lnJ4elwC/7SIFftut78WX74kp?=
 =?us-ascii?Q?V+jc8YMiQ8xtCWyvWP9u3cdMNQtVTasRl7lDre8AB7kjJR9G+EnQWnygcjd7?=
 =?us-ascii?Q?eUP1X6gtyJ82uB/bfN6R2/CuxlLeuf8V20/JtScyhfVPZlh9v4ul+Pf8Q21H?=
 =?us-ascii?Q?2zA5NSeokz8pQWjKGbl8Vor9iqJ0khuTgEHQLyPfLgo/RotNy/s+qV051NUk?=
 =?us-ascii?Q?7vHXwPW2exHE58Ze8ZjZeX+VuODXbUMTdsaelrAeTyBIKgvHQS0NAX/jRfAs?=
 =?us-ascii?Q?4dGYIrIpc9296gDG1ZXeQn/ud5jNnvh3O5YFb1IsRKSx27Yn/J+nhB66RSpZ?=
 =?us-ascii?Q?JDPSpnVtUuytbIRo8pjyUIMu0m3I7LkWP/tH4TRdxKXGenDWfioUEsNoo0LZ?=
 =?us-ascii?Q?W3Hn+7nRTgK7DQ/X2G/cM559Ic0U7FiNPpwVPeCd0xfhlKkYHuhNbBNpA0Mx?=
 =?us-ascii?Q?s07BBTjzzrzKu5cPppcyOADJAQhSev5EB/fNJlTmFgAb35OQM9dmFlFw72VV?=
 =?us-ascii?Q?+t1F+nNizehEB1aTrvSySEFBNTSygE5lFAOsafpXclucETYx5vPG+zU7nnpi?=
 =?us-ascii?Q?8ZPih+/lnKcpC917MQIoG7Jx+MciRqIVkrZzp2ztuI7/uMhZPlCXMiTLNhmR?=
 =?us-ascii?Q?Ag3Jswy1GbZTxvRMI81YGm0x8wNgSsPZs7JuTNIymM6EUISzmwaZtjwBpMv2?=
 =?us-ascii?Q?CWebqta1mXS/Co1rFE832TbFdj686y2+xK3ar3S5Vt8SBrC5AHlsn9x7q/AK?=
 =?us-ascii?Q?O5Z2yJh2757LrS4JraSpK4/X2pKAblyfNlsvJH5wPMz4LoGJQCZSZIexJ0aD?=
 =?us-ascii?Q?WBuz6i83tyuO9f9o6Up5waVw1Z0K4HXgIrtd+jyCr/jiSpi0EDc9i3VUGnMD?=
 =?us-ascii?Q?Mzf5RqZAtg7/kr4V2Z644gtzm7Ftk6ReplwqProLW3dNMq+mrHKQaXkmoxvT?=
 =?us-ascii?Q?6yDX2Jcn5YwlS/tRcC1QQjtzfWV/zepaY10IIjHLUpHlQN6VcSfFYPOECUOe?=
 =?us-ascii?Q?f0m3OOHqgFeFgoOeHFVwfSRoVkBBfH7fr8FzFNublhXsuKHrbDIYOfFkK1zB?=
 =?us-ascii?Q?xthxYn2jIXziqHZLZYYeKQlafFIuV1TPzlQMimPuuS5NlR+vSmMggrmejfKB?=
 =?us-ascii?Q?q9Pxguy6s3s+bOn3YKeuVVuMb/OAQEd9vk8Tc7JkeTVZ9hYJXIjaC7NFv8jr?=
 =?us-ascii?Q?BqbIl627pBCYTJK1AdjstbB3eUBCcfVM0dMN2Kwf1UclARSuyY279pUsUuLj?=
 =?us-ascii?Q?AHNxhWBdI+5ncVqxAewbZkjxhGAV58k34myUQKTrFlOLiV1xslLe4IVDQkoO?=
 =?us-ascii?Q?IBTGSM6uxaDU8rO9iK6fojeBTrAnQ4a0G1ox80mZ7es3FFzqJBclB4/JJJrt?=
 =?us-ascii?Q?jUIyhvFlT+jfBtM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:17:12.9613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0149339-f575-4f1f-e2bc-08dd1f87d03c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232

When bridge binding is enabled on a VLAN netdevice, its link state should
track bridge ports that are members of the corresponding VLAN. This works
for a newly-added netdevices. However toggling the option does not have the
effect of enabling or disabling the behavior as appropriate.

In this patchset, have bridge react to bridge_binding toggles on VLAN
uppers.

There has been another attempt at supporting this behavior in 2022 by
Sevinj Aghayeva [0]. A discussion ensued that informed how this new
patchset is constructed, namely that the logic is in the bridge as opposed
to the 8021q driver, and the bridge reacts to NETDEV_CHANGE events on the
8021q upper.

Patches #1 and #2 contain the implementation, patches #3 and #4 a
selftest.

[0] https://lore.kernel.org/netdev/cover.1660100506.git.sevinj.aghayeva@gmail.com/

Petr Machata (4):
  net: bridge: Extract a helper to handle bridge_binding toggles
  net: bridge: Handle changes in VLAN_FLAG_BRIDGE_BINDING
  selftests: net: lib: Add a couple autodefer helpers
  selftests: net: Add a VLAN bridge binding selftest

 net/bridge/br.c                               |   7 +
 net/bridge/br_private.h                       |   9 +
 net/bridge/br_vlan.c                          |  44 ++-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/lib.sh            |  31 ++-
 .../selftests/net/vlan_bridge_binding.sh      | 256 ++++++++++++++++++
 6 files changed, 340 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/vlan_bridge_binding.sh

-- 
2.47.0


