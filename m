Return-Path: <netdev+bounces-75435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6657869EEE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1356E1C27A1A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479B1487E7;
	Tue, 27 Feb 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cM9slu0M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C978145346
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057901; cv=fail; b=l0m6W02GxSuKYcd5I0c2FQ/i7C8KJKS8S0uw0rJa8BmKeA+WOZscT7/YB1Dalicr2HBel566tTaqXnh0Nn4X5wfVRaeOqJyhIL9I081UvmbaRrSCvV6ass1m0pVHqc7WPHo1jbnqbErWX/YbajhDHHXuBP00lhuhIaPGNedHqak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057901; c=relaxed/simple;
	bh=ATSjgQBbRlYUa2zliwOCfxbo5YDvUBJ4zdOEjJTnuBM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VSljiRwT3beLf6pSSBwDPCHW3KI6hYrmBrFSzE9XZy/qRApTI8HeiJnq4ZLjPKvtSxrtFRIGt5pkLoCfUA+cypDaJs8F86Ps6mFF7iFXocfQIj54EJIMbx9LoFWxeZ/uizvFNL5Jlk5tjF+YB73dZdAx/4IlkKtvZP/VRln0rGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cM9slu0M; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNn5kUA8JTUukisoQOqpLIt+3+jqT9HGKqzd4WebY8YDObnkyXNtTCp69T5z1lv+aqrSSR6OFyRW5hQQvza6laHtEqYaOaU1tLW5edKA4BNVYVYyhBtljpW0/9mkQJRbczQQR7DUwyjbbZXJvlGO2RIssOslOXao4fGKLdJveIPshWcQB46LRFo24A5BxLunDi3Rak/qT9j+NvtFL2fbNddI4t0dfSW5K932WQNCqmJ5RDMUOg+PpUR5G/TmU4R2WKmCQ/fjoPbN7yvTBFDBpjWNYqIqLLPtXxWiYJZdnNTUWbIJj6Wp7OcAmodsW+lKmoNZAIbAo6OtUC23i06l2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFJM9uO/grZRL3hWuGYOVbYVD04VZawyYaDawyTCyEM=;
 b=htjQSt9M0sonxKgY0EQ30GxGqC9xvmDgACI/fiPA1FfSYqb9/SHfAN8OeSkPTDxNk6vPeNnZXavqlAfH0/JTrzL94tSxxT7K+bilim47Qcwqwv1Bc+w6IyOY4kFccmKgzVkbWy3MJPDlCJFTaE6rGRK4lhr6lVrkmSwmHpmpFOhrlM+N4dMdA5Y2V29Th2rS96VgTahU+ghg8G3QQb6/1+BUOwl5bClmcjufJ8tkqqNDOyUJjF7cXDbdsug8PhNPZvW6WnZqRxllcMY0WCaZQXu/0FGpvg2zhdb1NvA5l2F2TUecJeLz1u0naM3uMRSqsEv+t2u8UX0iN71JHkNyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFJM9uO/grZRL3hWuGYOVbYVD04VZawyYaDawyTCyEM=;
 b=cM9slu0Mdny570fOaeUx2LZpWeJER7Ka17JyqrjdwixTusZmy5NZRgXxiylkEY/0QyBNHMNDqqLIcnC79vGEqFrgOJiAnnKt7cnTgBWSn5zFgf/lEbzAny0RVrfRnxWYbRUvLU/hAT7n3AhjdGjF0N5V5lKJKzNf7ieglqjX5RhAHfdDg4ZYCeHKzH/cnejmKuw7WCpBzP5bU310liZ8a/QzXUrnW09+69AgxCi9X6pr86QH7SUYp0/q3coH+HfkY6U0lFQ1xDGvmBzSrru6PB6RqBeVMTnmkVaspWKArW1kbR89lVyyykIWOsgfxPMdReX9UD4fJeKhJ0XjBzjHKA==
Received: from PH0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:510:5::10)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 18:18:13 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::2b) by PH0PR07CA0005.outlook.office365.com
 (2603:10b6:510:5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 18:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:18:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 10:17:52 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 10:17:49 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/7] Support for nexthop group statistics
Date: Tue, 27 Feb 2024 19:17:25 +0100
Message-ID: <cover.1709057158.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d4760c-ec2f-441e-c349-08dc37c075cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rF9QYzBx3K/wnoE0nR1/KEu5TXgL6y2LyJN7eW379x8ujmDwAqHuGLk/m7tLQVDM+vdvuNxtiVFFn5CzAesm8Y3z1iceoIbSAdZV6SbXcNNPIQwqR3J12nBga4Ffa0nFygW05vIYu80Z8zb60K3qSbaars43xcSue5Nm/MHE+BD2/CYlQ6LHDR3vZYK2qVLH4KyR0GouDiXvnp2u4jZ7HmZcSblynkLnI6wmvV/B41ZoIfWaS8zs89P4gBY2p6KUijWiMhri9fKB1cDNV1P4WHyHTdAXEMnKmKmrk40sGDmFInnSfQpasymxvOsyas1Sb5gbIHIcORgJOlDPV79HScevDd9X2tVnzpHj6a8hmkg2c+ED3DvQHUMd5hCckNPVbzJS1CCXSB7HlRSfEjFtFnwxwgI38X70HhgoLBePTKqFK4bPsyhvzAWBFE6d4xpOD0n6Bd1qXzCJRGyKEWzHb+2oKBy3yxNsH9TGFD3opl3KhCdniUpeWqMKIzRaVkNnsaLlQb7RGrsjfiRwzCOBqY3gtfye9ZbRZAK3TCY7kfpKT7UELDgNdbJUo+N+lMTm0erPWuqwLRevr9TrZyw+sStnPJpDpORngchfJT+4F0L+JERg7FxFPZKshT3rUFgEsxObuz1JOoZrY6sTHLqpcNLy7mL6FTfq2A2izjC/PF9QxgHSbpRspHvO2G0VYj33SrkgOptVO9KynY8ChplhTz4AokQ/dkG4k0Sr/aWx5ywsdpJ482ebpgGif0H5a40V
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:18:12.7963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d4760c-ec2f-441e-c349-08dc37c075cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411

ECMP is a fundamental component in L3 designs. However, it's fragile. Many
factors influence whether an ECMP group will operate as intended: hash
policy (i.e. the set of fields that contribute to ECMP hash calculation),
neighbor validity, hash seed (which might lead to polarization) or the type
of ECMP group used (hash-threshold or resilient).

At the same time, collection of statistics that would help an operator
determine that the group performs as desired, is difficult.

A solution that we present in this patchset is to add counters to next hop
group entries. For SW-datapath deployments, this will on its own allow
collection and evaluation of relevant statistics. For HW-datapath
deployments, we further add a way to request that HW counters be installed
for a given group, in-kernel interfaces to collect the HW statistics, and
netlink interfaces to query them.

For example:

    # ip nexthop replace id 4000 group 4001/4002 hw_stats on

    # ip -s -d nexthop show id 4000
    id 4000 group 4001/4002 scope global proto unspec offload hw_stats on used on
      stats:
        id 4001 packets 5002 packets_hw 5000
        id 4002 packets 4999 packets_hw 4999

The point of the patchset is visibility of ECMP balance, and that is
influenced by packet headers, not their payload. Correspondingly, we only
include packet counters in the statistics, not byte counters.

We also decided to model HW statistics as a nexthop group attribute, not an
arbitrary nexthop one. The latter would count any traffic going through a
given nexthop, regardless of which ECMP group it is in, or any at all. The
reason is again hat the point of the patchset is ECMP balance visibility,
not arbitrary inspection of how busy a particular nexthop is.
Implementation of individual-nexthop statistics is certainly possible, and
could well follow the general approach we are taking in this patchset.
For resilient groups, per-bucket statistics could be done in a similar
manner as well.

This patchset contains the core code. mlxsw support will be sent in a
follow-up patch set.

This patchset progresses as follows:

- Patches #1 and #2 add support for a new next-hop object attribute,
  NHA_OP_FLAGS. That is meant to carry various op-specific signaling, in
  particular whether SW- and HW-collected nexthop stats should be part of
  the get or dump response. The idea is to avoid wasting message space, and
  time for collection of HW statistics, when the values are not needed.

- Patches #3 and #4 add SW-datapath stats and corresponding UAPI.

- Patches #5, #6 and #7 add support fro HW-datapath stats and UAPI.
  Individual drivers still need to contribute the appropriate HW-specific
  support code.

Ido Schimmel (5):
  net: nexthop: Add nexthop group entry stats
  net: nexthop: Expose nexthop group stats to user space
  net: nexthop: Add hardware statistics notifications
  net: nexthop: Add ability to enable / disable hardware statistics
  net: nexthop: Expose nexthop group HW stats to user space

Petr Machata (2):
  net: nexthop: Adjust netlink policy parsing for a new attribute
  net: nexthop: Add NHA_OP_FLAGS

 include/net/nexthop.h        |  29 ++++
 include/uapi/linux/nexthop.h |  47 ++++++
 net/ipv4/nexthop.c           | 314 ++++++++++++++++++++++++++++++-----
 3 files changed, 350 insertions(+), 40 deletions(-)

-- 
2.43.0


