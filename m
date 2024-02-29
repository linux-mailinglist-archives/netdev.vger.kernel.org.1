Return-Path: <netdev+bounces-76276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65EF86D1E8
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99661C21093
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C667757E6;
	Thu, 29 Feb 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wl/dI9la"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CDA3612E
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230813; cv=fail; b=gRDn1ChiIRuI7W20xG9RKqxlzNMtcXB38b2ZjDfkiZZ3gLJkuoGavUvcOER0fW0JSwBNcVZjw/WYJEEqSIGYCvFe1swLwA7mgY3Pt5U+ekISHTvhZpLjwqk2cyEM2G8SCQxA5y3Ff29lIKefbUp/rd3JGj1CYMR8ZiOFkhG3rjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230813; c=relaxed/simple;
	bh=pefRrTJg5LOL+8SnjBbPn2wnEHPSVjt1NdMurtT1y1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CBu7OGxX0VaeL3d6fAEq+L53XFFCTIvHoj2FUjHjHFX/S9a0IYW8Ii9c8hUAFLrkfZ2VlZjUgiZCz88T6MXAXut0bNpOK2RcEX8Vyu7nynMgufvpzU7O92A0sNP/uPNWGyf649aL6NA9QTUTORnY0gQzXCEVD1UwxgVuxmRC1Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wl/dI9la; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg3V+u2jlD1K5SM83Ua6wJBGyq8gEw3FO+6IsQmaAj0jxuP0urw0kXqGbtIBCKL02E04Ws2qj+HC9d8EBYJdqjND3rGgPLi8YqNWiv3bZ/LLJOW5YowXVa829SI3tcKxlcR+NhpWHPVaQcaWG/KxdtObBdRWvT1vvvWKypqb+C0c7IkvVDlqYDWGmzqApXmQKkdSlQQdVRBiXWpdUanLK6y6tpXpqb7g7PZQ3uOX5hLyZ7uypA2ueATIt7dsB8ZiU74CMBH+mGas85Zerr7kPe2mjQm+RIu1G79Ifp6iu1yYPlR2ZUczoSvOFHFVfpc8j8zOded3lHylElxYPfx+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE7LataQvtRnYBJcawLdM+euxq72WOKwHacQe1jdS/k=;
 b=br2Lupm3OiTrfgKJhrkpmCV2kslhUhtgotN/9tdcclB8ImjhhIQNZfumrU/KDRi3obw6Wc1fm1HAS2pm3PWRKwmHuDQ4qeaDk6+rZFKaGrlFw14D91/jgskra2pbD/TwejNbVo/NNW6QWivMHQwVd2tuLuKplhLXR7tRwAFZg8t76Hkg8cDNmfOLKw/p17jdLrs9JrcGVkuVbeMcbX+Lexk15xgITrCfDoHxSS4vc5BJYfsjQgh1FGXD+HXFqoX7tK1/Wr5N4Oy3eOvRn1QJNUUzK45XKPQgWzfFlrqAWJbDuXpV5f8gf58NVW3G4sa3imTKEhxSH0lm4xdEzObbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE7LataQvtRnYBJcawLdM+euxq72WOKwHacQe1jdS/k=;
 b=Wl/dI9laGL/07SKnuiuRvFjlwxgA5W2c5LCv3ZehJcKuzusArs6+feuu5zakK5verYJrrnveDYHRE9tRT7TPp1nyft/RWaG1qFFzaxpZZUPbB/aAwI5NXqfg+a/LqhG1VC4wferRayGWnZZB353J9xzcgt8tG3LEq8AIH4N5Gu/vdk/b1GkqU3uVaFq8/pN/akiBhfIeqfTRLD9JB3so41MwNTy5tn+9JmIjpTvalNj2uxN2jddeRywDcTHBrsdezf9znDHBwn4BebdnYkydafx21kEHHFYMJnKgO2hVZPTO/6iv7YSKh72vcnwYQ1HnpqMn4pG/mdiyFCJpKCNB4A==
Received: from MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::19)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 18:20:07 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::4b) by MW4P223CA0014.outlook.office365.com
 (2603:10b6:303:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 18:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 18:20:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 10:19:46 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 10:19:41 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 0/7] Support for nexthop group statistics
Date: Thu, 29 Feb 2024 19:16:33 +0100
Message-ID: <cover.1709217658.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 22021dd1-4cc3-49c7-b7d4-08dc39530e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x7NFqUE083EgMHpd36KiUfoF8U86dzxQ09cAtIjY3BJGNSbBB1k3b4YPsLV6VaPvoLamBlAPboKYPeQAZcBEmUTYO9jNZvi4Wr98GWNatKbH2bs+Hci61BjDrb6IkFncK3SFvQWoX8ITwKYta0n9AvcjVR8KvOHiePlb/fKg4a39W+yy0OlGmcGMXqZ3MlJtisP1drcMbzACQsCAiF+uIvXsbXeywNuMh5TuQSlqHNZdEyDREoF/MPyPvwQTRqbx1efGnWv2s84gK3IjvgrVMHJcn4OGJ9j/ilPGlt46xNuena2Sbis2yYBcXUzwHMxUoyiQKTAjaymCK/kN5m1St8voglCpf3icUP1KYr0ZwakU3bL21IWgsVJ1F/rUEoRbukwVQQIzr6ryKQGrL6PyMd8uWmhE6le6H87BNbzoFv1Y7UeiNJ76Pb5UbQAU+ETSCWjtdnxQ6cBh4WKdtSo6iCkFNkm7SjZNH1wWdG7Qxj6kcJcJa2AMdQBSkTQers2ClQ7G/5kIW9JHhd6xyQEqS2jAxOV6HvaFywNId3FLSj4FOJoDKlC5Dmcge8rnO5NBy73yvSTmzZpkv7DPW3e0TMycvj8MImf0R4wTrRXRe6/IzzrhqiOaq+dOobjnHFEGe7Qm3dUx1/R3b8J2MNUVChqK3Bu8fKjPii+i5fWOLKf/x3bH8Z8a4lJ/6n1bGnksj5qD69MUVij/jbXwQN+cc0hmnOEEsQVS+c7SuP/8Dyb2oGp/GwGyRDYk50UgiVBv
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:20:06.7105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22021dd1-4cc3-49c7-b7d4-08dc39530e8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

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

v2:
- Patch #2:
    - Change OP_FLAGS to u32, enforce through NLA_POLICY_MASK
- Patch #3:
    - Set err on nexthop_create_group() error path
- Patch #4:
    - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS
    - Rename jump target in nla_put_nh_group_stats() to avoid
      having to rename further in the patchset.
- Patch #7:
    - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS_HW
    - Do not cancel outside of nesting in nla_put_nh_group_stats()

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
 include/uapi/linux/nexthop.h |  45 +++++
 net/ipv4/nexthop.c           | 317 ++++++++++++++++++++++++++++++-----
 3 files changed, 351 insertions(+), 40 deletions(-)

-- 
2.43.0


