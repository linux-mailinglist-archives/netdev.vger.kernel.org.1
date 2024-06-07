Return-Path: <netdev+bounces-101906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883790086A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D155E1F2230C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352A7190672;
	Fri,  7 Jun 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHbjrvMn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC215B134
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773295; cv=fail; b=NRrUw9/wgFKhL7T4lkhAIDDqIhmq//fsheA3OFlu4xKzlf11NgkBkkNLdaEFMR99aE4WKqE1gttwz/gVxF3hAzPwi7APld7/2sHzD6iZ0RLNGGxVD3mZ6uilWpGbLtDHWB9la+XKvWqZhYfNZBwW7pvmO1FIlBBEkUj37+X1PDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773295; c=relaxed/simple;
	bh=lP3HzfmDQK9XKzL0iivnON5++fNJZjtDzt761Om92fY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YiOqhaJNjFnEieODS7TG/gRpRiHhel28IlWFfxuw4CFZ9TssBVHgJGNFiQeEx/LtZcYpzPQ27swy6m40QYU3GyzPzjoAqlcnj8jgOGD+9T0J+QKH+57b5ypoZ4nYcTe0McCrRg2TZReMUYtfUmSa5PkygedhyDpBIpkhtnmyCJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHbjrvMn; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icZ04rD+OBaIMIajDvLLPKEtO256Nz+wih+5/+cWrfUPzq3GTrM0yakXJLadSIWNsa3iwHvNzaemOWr3zeZPa5K2gVWfq/rwYyam1k6uyJF5YeB8GShUVL1d82GXOszxKGsqjUBaYG66yKtss/Hf9UptW2/ubZBD3mbNwNo1qJEQih8NctfZ6M6+3uyc9czB1QkmEGMyD2Vt9gmmMDTOJOsIaM1do8VVvPe86LG6wtO9Y+x1x0zl2M26yYlo6BvQx7LKRgZmRbF2Qf+PkT5MDU0DvVsFnaIsUZOjEoO53ZYQCRQb0aYnUaI3y7wV8fipoNmVkoBDhFyE296EN1KjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6haTAhDygMeU33A14PVoEZGynrPj51kKQRbRNboEIdA=;
 b=YzmAH6KlyS1rdJi4DkSnPV8FJ5vg2mrneQ0BgSV74MSttBy6HbocAMQ7DgodICQpfbtEp7Xf/fBiHlmbW5Zer9qg6Ybrcv0fSLnXBnqDgFz1OfsvB9SgDz8siJAcjfWOaGCW21cFvxIj+hcY/Z+gQPmh5az7grjC45bEtEwB54ki68shelTXGfQEwxoBISnG/4xEqC7YImgkGJCKy/mdd736uuC75WlLco6/r/SlBG2tM7ELzze9xY7sFLwoZ8+7lSG4dkrVMtEKcABPPPVDDNhzPvz2W660rToZiEPLaWviG2OvF+hUJSicRDSKhd9rW+ovmTfQLLud/CYVlpZ8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6haTAhDygMeU33A14PVoEZGynrPj51kKQRbRNboEIdA=;
 b=AHbjrvMnRsKM3E3vrWb3SqvEcy2A42efUVVeBTQQFLABO78FjJjdAB2+SAXXQu21S+t+tkRb5bq4Trq3q4PDXbdtiyRXG5CZnxLuuzjd3EZ+S34WXext3XD9zCnuu5MVNdoDr2jfv+d7G1n+YRQRFCS1N44ZpYFeEc9lmDa/36ouHduptaQP/YzIFmyfV330LOooEiV0jTjV49EZQ1q7yVOeaLrEMkrOJI3mtgnhRq02QeF7fAd7dyCGutU9M5dpfkDeA9u2lOq/5rRUXVmAqGVi9gOz3B02mJ8vJUFxW6x9R2c7XbRu14N/Fy682j54dFjnKGqEZ/mxwmz6j9aQCQ==
Received: from SA9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::19)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 15:14:44 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::9) by SA9P221CA0014.outlook.office365.com
 (2603:10b6:806:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 15:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 15:14:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:30 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:26 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 0/5] Allow configuration of multipath hash seed
Date: Fri, 7 Jun 2024 17:13:52 +0200
Message-ID: <20240607151357.421181-1-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: d4db6b30-a62f-4968-0ea6-08dc87048fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfN2L0XhQz6estjgPW8aTEsQZ6yATu7ucd9XG0Wx6M0FA0C+lV+KRtfTUe6m?=
 =?us-ascii?Q?lU+DwbpO0EuYq6sQmOPYnINGDAnlMMI1wWO056VZ8ukFH+1D5xlF9S+HaN2u?=
 =?us-ascii?Q?0iJCB6T1wP/62ziKXSJF2Zdm9roB/CsxLe3JjZ+U+erjYhzjFkeCwlP4UxQP?=
 =?us-ascii?Q?AJdVmE4rbvCpr+6rFn+LkJ9tJHR3FE8xIAn0uHJmbGmsXgGiY7xuEa1vV88w?=
 =?us-ascii?Q?NbRR97VhTFICLlBjNeH+wNxZpNknfBsRPQdCo9S+qHoVYHDPOt7bKNFrbkUN?=
 =?us-ascii?Q?gd+B7CwJvbSW7YUq4WHd58HkE1ZesSb9l+xY4HKJ75GBMSnxoyihoSQf7XUP?=
 =?us-ascii?Q?gmfQhPJ3y2qCUvqCc73hOy6c3mmoJoXtnhlgBmtHjiY7JoYoeP8YKGY/sH52?=
 =?us-ascii?Q?1FxAl9C239xaaxvs4Se4W9Mx5EI4xzu0ssX1OsprLdJNHpny23G5LmAn0A+p?=
 =?us-ascii?Q?brBV1ulG8hy+GyGoYZcpeWrNzADguc9U+hlssAwMXpGJ8jK7W6FYEhZOwKgQ?=
 =?us-ascii?Q?udXDAghPJnqlwlL/XsBul+rtewX22VjPPA8EYSg+fnhEklhB1zCMhKO7A1DV?=
 =?us-ascii?Q?fSb2KlWJyJGfzJDFsyJbnuqkILem4RSiK6LI+FnLDkM+Ut6NcP1xyaL1z3b+?=
 =?us-ascii?Q?poe/3feq2EnPAytvZwhdSrsZt1UAXL8AuMkmd8Ab3B43mOuoJZ3IwQh9bAN0?=
 =?us-ascii?Q?ITl5uS4j653B5BRckr2sW69Fbyo5mN0ajiOkN9s5vgrhbzh8fOtb+Pf5thqS?=
 =?us-ascii?Q?7arw1thmtgDqpJl00xm5WIzbPLzfNV0QmHgRccXVMVg+7N4UZNoubENlpKAF?=
 =?us-ascii?Q?uFtoGe588sps59ETu2QT0iM6PEnntcw9E/R4CEQw8FjF25tDz2PmwK1nIkMb?=
 =?us-ascii?Q?/WKgST4btCW1Y6xkAdS2Mz2dqzpouSvBiklqBmx/XF5NUp1wZT38/CBwQmm6?=
 =?us-ascii?Q?X/zk5+mSzw+ToM+9lai5vRvwlDw8Poc0Ydpw0atgd9pX7HogWOEcvmjlSkNd?=
 =?us-ascii?Q?08lm1UstPQBawHO9gm1feRlZD0TExlowaXA1E4q0TlJUUxeyQoHwLV9BJJqT?=
 =?us-ascii?Q?AYVhjwYEzi0oLawazYGo6YFwXGq6VdS76s6dz5Lfx7bOH34gck/CFAFjr6L/?=
 =?us-ascii?Q?vKNUCv6XRsR20qpzkVCpRVpsTEZU5iadZs4gdQxllvgCCNHOcCOW90xeHqf8?=
 =?us-ascii?Q?xxwzR6xJ6bbFCZNtBgRWhXIBaARTjMjfIA3fdZ7Tfx/X14IEKxFqzsckxS/F?=
 =?us-ascii?Q?3xQbiJvclo+89SLRBG2EE8WAe7u8O+0tuYxHELeFLWD6bTXAEtCw3jhG9W8y?=
 =?us-ascii?Q?6PHJjm1bqXw+aaqkt7xBbrjuF90xBZc+NWu210KEJr4Me0yZdkvKYL2OEsCG?=
 =?us-ascii?Q?JLoxvAvYDdCia/yi/Z/79h7tij+PIamCakOgdbG7eaj9HdXyRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:14:44.0626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4db6b30-a62f-4968-0ea6-08dc87048fce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660

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
interface in the past[1].

- Patches #1-#2 contain the substance of the work
- Patch #3 is an mlxsw offload
- Patches #4 and #5 are a selftest

[0] https://www.usenix.org/system/files/conference/nsdi18/nsdi18-araujo.pdf
[1] https://lore.kernel.org/netdev/YIlVpYMCn%2F8WfE1P@rnd/

v2:
- Patch #2:
    - Instead of precomputing the siphash key, construct it in place
      of use thus obviating the need to use RCU.
    - Instead of dispatching to the flow dissector for cases where
      user seed is 0, maintain a separate random seed. Initialize it
      early so that we can avoid a branch at the seed reader.
    - In documentation, s/only valid/only present/ (when
      CONFIG_IP_ROUTE_MULTIPATH). Also mention the algorithm is
      unspecified and unstable in principle.
- Patch #3:
    - Update to match changes in patch #2.
- Patch #4:
    - New patch.
- Patch #5:
    - Do not set seed on test init and run the stability tests first to catch
      the cases of a missed pernet seed init.

Petr Machata (5):
  net: ipv4,ipv6: Pass multipath hash computation through a helper
  net: ipv4: Add a sysctl to set multipath hash seed
  mlxsw: spectrum_router: Apply user-defined multipath hash seed
  selftests: forwarding: lib: Split sysctl_save() out of sysctl_set()
  selftests: forwarding: router_mpath_hash: Add a new selftest

 Documentation/networking/ip-sysctl.rst        |  14 +
 .../ethernet/mellanox/mlxsw/spectrum_router.c |   6 +-
 include/net/flow_dissector.h                  |   2 +
 include/net/ip_fib.h                          |  28 ++
 include/net/netns/ipv4.h                      |   8 +
 net/core/flow_dissector.c                     |   7 +
 net/ipv4/route.c                              |  12 +-
 net/ipv4/sysctl_net_ipv4.c                    |  66 ++++
 net/ipv6/route.c                              |  12 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |   9 +-
 .../net/forwarding/router_mpath_seed.sh       | 333 ++++++++++++++++++
 12 files changed, 484 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/router_mpath_seed.sh

-- 
2.45.0


