Return-Path: <netdev+bounces-98993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4F68D3561
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6801C2284C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0116A373;
	Wed, 29 May 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nYSCw6cy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988916ABEE
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981692; cv=fail; b=ZxZTuMyf7c1wfCJ5eNGxuxT3GqehlpUO2J0JxKCO3+P18nUoi0fiFkJ7IeJFarcerC17737iJcZ+CWK9A4bx0uFP0MkuXek1CqRpXdG/Es1OSrJ/LnzOdPfARBrT8+WvYlv7YtGmL7083CzO8YgRW8/domwte6LMbmmx37Y92PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981692; c=relaxed/simple;
	bh=WCKfTVtWzl4ZH3UpA7SVCYYun6GjAei92345U8spykg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGOYNjKfqOdeqjyAkEwMB9AqtJpk+Q38JCJ5JiY5OJXcRTpTWCaaYt1kozq506yhP7lnI7o3bb0BUBuywiaMW+lB+RKhE6TcLA6vbfuRPwmXg93FjewPUmFbuBTlaeZv4Jh+Q1eDkbhnAGGvzY6r3Dq9uXp7mvaq0Wo+tI+Qo1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nYSCw6cy; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jsy5GtMxgjjFW6nsb4l9iheHWNabeKcOld4ToSDvIIKQJ6/B9zOBHSSy3rvrL/ANDHYTR4yrtLWrvVxhf4RUkSRt2aKDRCPyqbnSwTTWKiPN8WgZ+ZRt6eufbgtUpqMgRpM2JiH+Zxpl5HwpXJ18RmSmyNX+KnQfvtbamnkaq57Kx60Y80ji/8tf4bcrgeFUH7sHIG2IkOE5w0vTaUDpHB9Q12ckHpHijpocP1NgLt7OFvaGg+iNhyji1ITgmLQ1+TigumCB7vnf0FJ6Kp/JryZRAE4GFQYrSTOJcvDDg3A4xcgE/H9KJhKlgNTEYxnCfJ+mwH50T6mip9lYeeMCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDRv1SWk4vA7k6U/iEwxqkSeSh+p5OhihjdRKHhopcg=;
 b=hGED1MeQ+TfMBXuF+TkiStVKNk6tXSats2zRM1z2LDpkzBbVhNQffWkDgSa4Cyi9tGNC9m5Vt+muoJ6NxMfbjbQ3+FVYdyi84stKXilW4Cihcp305a0nTqse1Dx5KE9CqrfP6asuTrqY49yq3B7yWIQqANEPFtn8VvUbMrZ2/OJTiEX+AqosK95gg3e42f1KMlqGWcCloxqgdKiv8lMUJ5GZCv62hGeBZe4IM4teS9GQPAh1Q4zgni1T/ASV24oVnSa7GSwE+0DbJcsEZvJlcI8ny0izDwtqu1QtuuJerWwhXUR+AL6lr9HA0OYUYM+f9SIUOSeGEhMpdGIe/rEa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDRv1SWk4vA7k6U/iEwxqkSeSh+p5OhihjdRKHhopcg=;
 b=nYSCw6cyDJjlfQPEO2Ci+ehgM8qNuFxg/US/44zPeonUMSzjIL3DRT2a7wAqg596SZJ4LUcG7+7mTFZwsC8rTGtJPbpwJV1OdRkriVQug4QuyKoZyg9ZODK6XDI/vblpHS5yerJ/cttZR7a4HoqcxzLwZ9nrlYm+7kUE15dczaedaPdFhS7KDBetY+EVeOrJlqU3yzZJiKjpQiiakm5du0CHFQsRXAAxaLHBV2/CZuJKmeWkLGubpOLOkux3YB+ay3IcCfBoqW/ops2o6pXVHqGp3a91dsJtc7OqKOYASy8AII/vxI+UL+qMETBvUBCuyECiGxGCMeNXWz1lWRnvKg==
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 11:21:25 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::91) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Wed, 29 May 2024 11:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 11:21:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:12 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:08 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>
Subject: [PATCH net-next 0/4] Allow configuration of multipath hash seed
Date: Wed, 29 May 2024 13:18:40 +0200
Message-ID: <20240529111844.13330-1-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: af3c5ba8-7ca2-4197-e234-08dc7fd17a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hpS3YqMl38u+bJhy+YcrbOIuFoRf8api02PigNvv729XGP0/vPXLUUrCU2Yf?=
 =?us-ascii?Q?8x7hH3dY1XbpioES9My2lKJrugA4SwFNgaWo3nJaBFPDgcSulk7p+nsioqa2?=
 =?us-ascii?Q?pi4j6IXeGv3NGtQniZ31+UXE+ns68PkX/cTV0hYOey7OcScg75p2B9O0EHeW?=
 =?us-ascii?Q?zL18mgE34dIRzZUWuL/6FS//ubojJS8vw63RSI8BSAhvj7PIj6/LgTPf+hsW?=
 =?us-ascii?Q?0WSFFn3cyvyv4k8BMaTm36OO0QZZtySFw23rLkAgdlX+W2fFT7+07b0lCaZx?=
 =?us-ascii?Q?4rPnjHo2mcIlU0D1zxVIS9zN/FzHyiNWMpDVpO8OJHL6putlBt/Xa8KpjhEw?=
 =?us-ascii?Q?TcTV6uWjVaMdeF7feDvSWCAXoDiK1uUXzj29zmCKdehzFMiv8ROrjaPywfgk?=
 =?us-ascii?Q?dYPa7gyZ0KTJR6hdLT9Fk7RJVjIwxqTOUxxtALSL5I4NmYaosZvtUSavFTMJ?=
 =?us-ascii?Q?nUGs2HDrJeryRskTEw2YyLYe5oPA0XFyY6pGDIPfp2Kh9e+H35v643JZlVOe?=
 =?us-ascii?Q?it0uLVvwr5V5Ix1xMQ/e+BsAaeWhsJfNi5RH5o5/dbEPQn+VLl2HGw+f7+7+?=
 =?us-ascii?Q?JMoR1U9vNqJavd5FJ4+zUXf3ZDYDVmAawVRRo5wlHfxVjvTQ65fugXPOTohz?=
 =?us-ascii?Q?+DbSOk1Mn77GR2Agkt6BYqRAAH4LR1nv27kBlY7C242Ohg7V6uQwEEN4nSpf?=
 =?us-ascii?Q?l66BxPpk30CZigImEM5xd1quNUhqWceG1T5ygYsekNi0hOXCC7wd40WxTwc6?=
 =?us-ascii?Q?ElDxZpOq6Dt0Yi4poNUYezhvgjFTPzUcOtTapdEbWfqozDqMddvTCut3KHtC?=
 =?us-ascii?Q?FeH53nAeUFwGrqWmYdhz7dOFtznVNMR5nF80Ao26qf5CE5xtlTNN5ybKHH5D?=
 =?us-ascii?Q?FVH6US3oUOzUdBuqN8Z5NMRiwbIGNztl0kjAc0yCdRMeOHpk8LXw4dourCtO?=
 =?us-ascii?Q?FAIVXw2BPYECXyEO7TxSyzOCQjIoaUFugmVIsqEl+Qu+LEe/lkzgWaQpkFQJ?=
 =?us-ascii?Q?AF+Swa5asEZ4lOohVMuh9ACsq7AsAQpEzEsF3s5j2To2gyys6gjdMKr6Lt5D?=
 =?us-ascii?Q?oHRriAzo3iTIKRCABy8JUiT8nWKNCIIyhlgC2ewUgdjENLMOeStKAT0Cv8bP?=
 =?us-ascii?Q?psqJhPXwbirLfNBnigeiU/prMq6zzp3CA5rdExfFrPGRVo7GXyQCsypLLw8e?=
 =?us-ascii?Q?/5Uj8YQ4Np5IlxyAcPVAHTD1qXm7oGyw/e3ug6znQB5avFtwE5IDF5Io+1b1?=
 =?us-ascii?Q?WT2tHjPfVHNxInF30OFOyBD8xak92QVl1fuumx0PK7MoEhTPLj71M/Mo+FDo?=
 =?us-ascii?Q?F86FnVTSFI05/vwqS17oAhOxoPfh5SjPeD7nERthkW9RaNsX8NMe06YSL70+?=
 =?us-ascii?Q?z8vkMmE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 11:21:25.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3c5ba8-7ca2-4197-e234-08dc7fd17a01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

Let me just quote the commit message of patch #2 here to inform the
motivation and some of the implementation:

    When calculating hashes for the purpose of multipath forwarding,
    both IPv4 and IPv6 code currently fall back on
    flow_hash_from_keys(). That uses a randomly-generated seed. That's a
    fine choice by default, but unfortunately some deployments may need
    a tighter control over the seed used.

    In this patchset, make the seed configurable by adding a new sysctl
    key, net.ipv4.fib_multipath_hash_seed to control the seed. This seed
    is used specifically for multipath forwarding and not for the other
    concerns that flow_hash_from_keys() is used for, such as queue
    selection. Expose the knob as sysctl because other such settings,
    such as headers to hash, are also handled that way.

    Despite being placed in the net.ipv4 namespace, the multipath seed
    sysctl is used for both IPv4 and IPv6, similarly to e.g. a number of
    TCP variables. Like those, the multipath hash seed is a per-netns
    variable.

    The new sysctl is added with permissions 0600 so that the hash is
    only readable and writable by root.

    The seed used by flow_hash_from_keys() is a 128-bit quantity.
    However it seems that usually the seed is a much more modest value.
    32 bits seem typical (Cisco, Cumulus), some systems go even lower.
    For that reason, and to decouple the user interface from
    implementation details, go with a 32-bit quantity, which is then
    quadruplicated to form the siphash key.

One example of use of this interface is avoiding hash polarization,
where two ECMP routers, one behind the other, happen to make consistent
hashing decisions, and as a result, part of the ECMP space of the latter
router is never used. Another is a load balancer where several machines
forward traffic to one of a number of leaves, and the forwarding
decisions need to be made consistently. (This is a case of a desired
hash polarization, mentioned e.g. in chapter 6.3 of [0].)

There has already been a proposal to include a hash seed control
interface in the past[1]. This patchset uses broadly the same ideas, but
limits the externally visible seed size to 32 bits.

- Patches #1-#2 contain the substance of the work
- Patch #3 is a mlxsw offload
- Patch #4 is a selftest

[0] https://www.usenix.org/system/files/conference/nsdi18/nsdi18-araujo.pdf
[1] https://lore.kernel.org/netdev/YIlVpYMCn%2F8WfE1P@rnd/

Petr Machata (4):
  net: ipv4,ipv6: Pass multipath hash computation through a helper
  net: ipv4: Add a sysctl to set multipath hash seed
  mlxsw: spectrum_router: Apply user-defined multipath hash seed
  selftests: forwarding: router_mpath_hash: Add a new selftest

 Documentation/networking/ip-sysctl.rst        |  10 +
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  14 +-
 include/net/flow_dissector.h                  |   2 +
 include/net/ip_fib.h                          |  24 ++
 include/net/netns/ipv4.h                      |  10 +
 net/core/flow_dissector.c                     |   7 +
 net/ipv4/route.c                              |  12 +-
 net/ipv4/sysctl_net_ipv4.c                    |  82 +++++
 net/ipv6/route.c                              |  12 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/router_mpath_seed.sh       | 322 ++++++++++++++++++
 11 files changed, 482 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/router_mpath_seed.sh

-- 
2.45.0


