Return-Path: <netdev+bounces-91687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA48B3761
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569EB2831A9
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B798146006;
	Fri, 26 Apr 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GkREImJs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA71FC4
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135510; cv=fail; b=O5AhmvCtPcuVNuAdtVLqV276huLvDjmmV7aP9KIiU792Jv83PgTcx0c0hvj9cRGVR6dRMZxGdKwFkzoPL2mHXZBRDXsKXgUGrJ2r66ke9EOUGrzqIqwt+aqJ9UWCE2ZpjoAsU6wqD236ep+0vJ1UlZeRf0p9TQsucWCQJczNza4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135510; c=relaxed/simple;
	bh=9q6w0CF/+coubu6gIG2uKEYKoLyO7nOySblb88V82pI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kykxdtD3uuDCljUHtZa7brS8yRYqAk1M1JR2MDfS3qFrTuu9vCRd5EztpNrV/ByMH0P7Ud9+sUF5jsUuBx1UT+qFJ5Z6bhggqzA2JAb4U85FDUmWYIGuH3wvV/urVfkEs/inVMZLO9JbUSZPDCOHwtNXUZ1jBb9XbzgX07G+9iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GkREImJs; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYHDAdLY196CG2V+TjFVT5G13wM67AohT+5V5ULPHcfoLfaHTt9/CsrCnqQCO/7/nDwQWnZyGs6Y1Mp6KdNwzkb2wlCBK0u8A+tD2emIFSzPwH5nxMaX9gYroVdUvSc7v5Wx+DzGhKZ4EgeHbUeDQt+3fnTfwymbsBT80KxMel8beLHy6Ny3zRY3dtir5XIXXiohUiS0paulbpRXxxswNhVbC/TAlSFzs/BYtZKUXI8LP8s74/4UWJyQgmugYzF2QgmPWV26e5ehoojRQNXx8VFZUOHKpD7SSiSPzSInt1gHKIeDVEgBdkNlce8jttwClgG1g2NsYpShMMindtxYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+z5IKNuHL1dlSN/2qbuIWCc98UFX16J2bVrUdMqwX8=;
 b=Aw7dgxDnQW41T+uBMd65wuDAlI9SpHkoUHGrJNSqJyaLOne+l1JWIR88QMn6r40DbIT4A/XTykoO52OMyi9MQCkOkakcPtGrj8Aon+7VfO46q+q5eTT7HC2V0Zy+sXyp0byTBVXvzFGx84LADF5iwJw4L6msda1ZBUC9B9gkgzY9jRl7mdDN7S9Y+XmmgmqY1y8kVZOsRw937zeMtONA0LLn5s1eRbBH2bKrAfwNq9XPwk4Eq1pMlDzWo9CpDE7Jv0mdN9USl/T7RupeXCJviF3V8Gh0v8eJCRV6ynqzFi9m+ikg5X9qSYTx4OG+z06uet0BTLoDemymRbDXLo9mAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+z5IKNuHL1dlSN/2qbuIWCc98UFX16J2bVrUdMqwX8=;
 b=GkREImJs5gc0qsJRYB9WyU8A9+sPGDwyWV4UM1t1vJrrzB/UdnBYluy9oYYGo1RicSee5qzi3g2LN1n8qAy/VEdQ7RrHP3VKgrarY8dTjBnqs/F8u/YTTdO0gmdJ3hWyU6/J3YfaszrvkBUZLtppTjiyd0CxLk6fu4Vcm/MRjsYZBkpWQ9JHMWvsV5de1nTAe3vfbs1xrpFgkqorDfgu7exYyg9Yy2bh258tSIuV/IVuI4lqs1EiOBWS9dpgGxA2d4px4TcaWvKesqLmJMWbbyhuVoXvUEDjxG5Xq7v28SD9LncP6iNEnazkVYsEiOgQ6msmW73yObli/dX7oFD8rQ==
Received: from PH2PEPF0000384B.namprd17.prod.outlook.com (2603:10b6:518:1::68)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 12:45:05 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f913::) by PH2PEPF0000384B.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 12:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 12:45:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:44:48 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:44:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/5] mlxsw: Improve events processing performance
Date: Fri, 26 Apr 2024 14:42:21 +0200
Message-ID: <cover.1714134205.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b59ad5-682c-4b1c-701c-08dc65eeb1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JapXjpQkZGi8X3aUBCpwd7ADeuuCpYKIHPOlDm3bjVYeD6/Vy7uI2rxUI4XF?=
 =?us-ascii?Q?rilAzuOcWMfibv/c86/0xzKNubbjV8fZJ3iJyHl3dQ1NF807n3GdhxSuCGmE?=
 =?us-ascii?Q?WPDuTVO5JuZ5EyZ0KguwTi7m8FZja4k7M6UVKhkrPRvy8uT65OfkZUgixwGC?=
 =?us-ascii?Q?ZscXrb5fbfFsOvg/btAOIgdp/fMOCz9lg2RoLiuslpFWz0J5z1qD+72xWJqO?=
 =?us-ascii?Q?mHZiVQueuzmelCJ0Ru8Uc8CLyL8WGEoB8FmOP86UXUKe0S6pjHSypiG5sOge?=
 =?us-ascii?Q?B4d+IwR9M/iQm6Z6yxCHGR+eYxy4KbUgoYFYXht6deE20mMJkEQqxUKWEXLr?=
 =?us-ascii?Q?o0OfryuCNlQybpNwY2ibJzMEVjj5oCiLVfcEzlkT+CClpH1aXrvWMdkbpKaZ?=
 =?us-ascii?Q?5N9jsvcQ96RbtMv3xCwWppBvrRYRQz3ypPB94GnmPQZRCiUHAs6Ed6Gq0Q8q?=
 =?us-ascii?Q?i9lrA/G7OOgAS0kAQ7SpmhpdOtMUr07FRWR0RebUk1SweeAmSn2Mz6dTZsPS?=
 =?us-ascii?Q?A1kHfmLu1u6fG4hIkFYBAhVEOVZb1k2O7VPHqMjNsN/ShU2WMw+3qIq7Elr7?=
 =?us-ascii?Q?VOGrgFeBgrZEt8V9sYf44VX4sjAfvJ3f95HvMOpOHYOfP+VYC9PGzQOv/gbE?=
 =?us-ascii?Q?yRX4FtYx6hIRS82bJpjZWEqqRoOSb7X8FqdW+uvdAaqn1WTVpYv3Coib+e+s?=
 =?us-ascii?Q?k6cKNe7yqiihc4YY9/4AOhei91E7Rrv5ZAEFgIKkRrEECgImPTPni3WEHZLy?=
 =?us-ascii?Q?MFWGhhf4MAHM7+H6jOzwE2GDbuD9L8uLUNYD7wzuWxwJL5Xs29qiEGoJz8kL?=
 =?us-ascii?Q?qimbTrMHS9RfB/7yQ93RnYco4WsMLpqbgZy2bP8aa+OnA7EPoGxI3Dz1fTZZ?=
 =?us-ascii?Q?+RcIzKCg1yTfCknWdnkbbE1woFUUgA0FPqPjxUe0qtuazvTa3g+7f+l6FVZT?=
 =?us-ascii?Q?nPPo52G9G7+3HHUpQkpKBY6F2EBUEOb3VRN+z8862HaHiKQY6+EMc47642BR?=
 =?us-ascii?Q?JnuUxsLbTDQ5P91pHlirAzCw/53DXl8y8tKRN/rj3uNigGsxs5A8dcDyuV2V?=
 =?us-ascii?Q?gKdhv4jI2nFNyskB9Z7fqOMHyZgjHesR04fkC5EWuVh/BAjkCLasYrH8B9SV?=
 =?us-ascii?Q?oGewCK+bTaE+qooZTsWj78qYM2b4hz0Gyx29TH12X4+CKJ5m30BpaZgk31Bd?=
 =?us-ascii?Q?5g6AQ5cyGNa8/91vtjdfrSaYmgfZ1TGGQpF4HJRr9gekj4OreF2Uvf5T53kE?=
 =?us-ascii?Q?D69Ilesut5AtPb1ykX8HhhAEqiqnFZZrpFkXtpoqx6rxOyrxVYLIuWGV6i7n?=
 =?us-ascii?Q?6B9YVZpfU9mVhtbMMCeQJT0DHwFrU8xw57mUDsFVR6Ntr++Pq78sMZVt2BnX?=
 =?us-ascii?Q?PUEbH1E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 12:45:03.8941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b59ad5-682c-4b1c-701c-08dc65eeb1d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

Amit Cohen writes:

Spectrum ASICs only support a single interrupt, it means that all the
events are handled by one IRQ (interrupt request) handler.

Currently, we schedule a tasklet to handle events in EQ, then we also use
tasklet for CQ, SDQ and RDQ. Tasklet runs in softIRQ (software IRQ)
context, and will be run on the same CPU which scheduled it. It means that
today we have one CPU which handles all the packets (both network packets
and EMADs) from hardware.

The existing implementation is not efficient and can be improved.

Measuring latency of EMADs in the driver (without the time in FW) shows
that latency is increased by factor of 28 (x28) when network traffic is
handled by the driver.

Measuring throughput in CPU shows that CPU can handle ~35% less packets
of specific flow when corrupted packets are also handled by the driver.
There are cases that these values even worse, we measure decrease of ~44%
packet rate.

This can be improved if network packet and EMADs will be handled in
parallel by several CPUs, and more than that, if different types of traffic
will be handled in parallel. We can achieve this using NAPI.

This set converts the driver to process completions from hardware via NAPI.
The idea is to add NAPI instance per CQ (which is mapped 1:1 to SDQ/RDQ),
which means that each DQ can be handled separately. we have DQ for EMADs
and DQs for each trap group (like LLDP, BGP, L3 drops, etc..). See more
details in commit messages.

An additional improvement which is done as part of this set is related to
doorbells' ring. The idea is to handle small chunks of Rx packets (which
is also recommended using NAPI) and ring doorbells once per chunk. This
reduces the access to hardware which is expensive (time wise) and might
take time because of memory barriers.

With this set we can see better performance.
To summerize:

EMADs latency:
+------------------------------------------------------------------------+
|                  | Before this set           | Now                     |
|------------------|---------------------------|-------------------------|
| Increased factor | x28                       | x1.5                    |
+------------------------------------------------------------------------+
Note that we can see even measurements that show better latency when
traffic is handled by the driver.

Throughput:
+------------------------------------------------------------------------+
|             | Before this set            | Now                         |
|-------------|----------------------------|-----------------------------|
| Reduced     | 35%                        | 6%                          |
| packet rate |                            |                             |
+------------------------------------------------------------------------+

Additional improvements are planned - use page pool for buffer allocations
and avoid cache miss of each SKB using napi_build_skb().

Patch set overview:
Patches #1-#2 improve access to hardware by reducing dorbells' rings
Patch #3-#4 are preaparations for NAPI usage
Patch #5 converts the driver to use NAPI

Amit Cohen (5):
  mlxsw: pci: Handle up to 64 Rx completions in tasklet
  mlxsw: pci: Ring RDQ and CQ doorbells once per several completions
  mlxsw: pci: Initialize dummy net devices for NAPI
  mlxsw: pci: Reorganize 'mlxsw_pci_queue' structure
  mlxsw: pci: Use NAPI for event processing

 drivers/net/ethernet/mellanox/mlxsw/pci.c | 204 ++++++++++++++++------
 1 file changed, 150 insertions(+), 54 deletions(-)

-- 
2.43.0


