Return-Path: <netdev+bounces-137910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45309AB168
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FCC2854FF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C41A0737;
	Tue, 22 Oct 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s7PoM6j2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9400199939
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608680; cv=fail; b=ZhjqDKFoLkPqKmhxEaCt4kajYTwB2Y2Jgri5fOqPAJCTesul/ogtFAerlvYa+ehDc7+mIaTexONPlfFs8z070j3LasQUSGlknYdhtCfys4N1aocHdrSioOUOr560DuFTN5E6pYT9Cvl70DJgPkdfya1oMkGNFdOkcXRwDYXbN3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608680; c=relaxed/simple;
	bh=tbIJ673BTmN5XmvbuV2BAgMDPfIr3Eltwd+NN8xG20Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AYBvT+l8fyZc3+MCJSpTei7izDSbI/1+L+nDmQEy4wSRngeV6eazzM/V7ywvklbCANjOqhTRXDRkPD4XESXUOCvVCHKY6CpQroqNxivntetwWY9WYY723HcG8W27K540keXGues1Yq+fVuHbXFH6EFtfbpB5yG+DBSKFAAY3qiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s7PoM6j2; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/0BZyn00y8Ez0Abw8aovSPyMZetsEFm6Q9GfAiFGH0sYCc/NRw0n9Tsf/ASK3OiPTpuHp8xg4zmc9RwlD9aViWf04YUu3rnWHrJIVGbZT4UihzrfFy4tSU2fYS2fFiVCsOzVy4Yg6NgIYCu4yt76UXAJAcwh1DxoD9FEJLZ60KpJ0ufCQlAL8e59t0hz3AQaLXF0xVCBK7EPBlgxFZ/G5r/dDINBy3u+zPCyfCjtqG83zTlIMogKpnNb9pkVjnGFNQ43mWABfFrCR3uTVZBC7wkJCZWW5GtpUatsBOxSj2bKPiZTSDYK1/a7tlCO/c7KjuD0UQ1XbDDYPXVoLNauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgvYKnZ8/q9rWgJmEP1cYw6S/NSYGiUxK6PYiPlh82o=;
 b=w6fXHEbrI9aEl63L2BPDq/lmWtiyyxPNdE6IXwkfyVaeAIhPwGufwtU3kbkqxJR4XOjoF6glEDqC7IrqppTNVZZ9Zc5US9E9u/y0pvDntb+aSfuHbgdm4fyVo0nk5mCsleIWqDmbTXTqDHiTvlvEUhxcAsZTtPCTOvZcg3/JBBe4YiOJGuMDm1srcZzuD44WpHQPXLn7kRCIb6dyEN9WeBHvqjh7AI84XvOfwmScasDzhrSlL+H5KWy8GaPjV7859+oU9RkEx0HexA3VhbxOyrqoAe86ZmGPlR7Er0rdOOI3rv3kTPTqPUqgtFFVYnMjBXza9XsgH5RLBA6eYej5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgvYKnZ8/q9rWgJmEP1cYw6S/NSYGiUxK6PYiPlh82o=;
 b=s7PoM6j2UgcnFAn3ZyI0uEanZ0BzP1BimC0PN9UMPYJvqEi2I/4Wm5TgIJ2f+KgBDYFfCHTEpTdD3Cfw5uokw4VZkeAgXEoINI9z5BPjHFvueZPhWX+Q3Ezrkjfz21YFxlevR8nCm11py3WnEcr7YxUBj2bBOnaD9NBLBHBQVY5URD1Pd1tnZUJ0kD78VVa5Mtzr8IYh43ADhu+ge5hHDMYpDMMAqEmcapEUCsoGuU6FQFtoqQ2tkgICkZWVXmexGTbwb2v2HRerkMbq0nVhmtLCB2nhANTTIc9nTjulmP01vRZRwNbeQkvoshQcxb8Slqp7ANy8FGqBiP08yp734Q==
Received: from SJ0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:a03:2c2::30)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 22 Oct
 2024 14:51:12 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::1b) by SJ0PR13CA0055.outlook.office365.com
 (2603:10b6:a03:2c2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Tue, 22 Oct 2024 14:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Tue, 22 Oct 2024 14:51:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:50:57 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:50:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 0/8] net: Shift responsibility for FDB notifications to drivers
Date: Tue, 22 Oct 2024 16:50:11 +0200
Message-ID: <cover.1729607879.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 3041e4a1-f717-44ec-89d5-08dcf2a8f876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aelz9qPBtSW+jDFlsn6uuybNp8bL7YdN6U5f5xlSkag0TcY1YbaxlB085xgC?=
 =?us-ascii?Q?8aTbWlH2W/dFCv9UxjsVv6twdXuI8dbbdf2NY/reZwo3J0ESLBbdxfamHbYI?=
 =?us-ascii?Q?m139OxzW9WmYtN9WkB81VKikbgyBeXq9/BLg0wLfdiEPW9ybGhyS5xAP1QVw?=
 =?us-ascii?Q?z1aaX4tJbngwzS2Gls/jPYB2pfwMNVH4X4G5NmieBvLGWMJO43FVQvAIVNJH?=
 =?us-ascii?Q?1Rsz0kBQwT9zyazBunpwsEHcY1T8+5gL3dVD0vgKV+yzcWwSIeIyBQ/kCdQL?=
 =?us-ascii?Q?B16EKHJvqmSva7A/P03BcK7b5AcTVMmEnmFIK3mFpV+PdRerDpYUupMWlYuI?=
 =?us-ascii?Q?yqMC25LG7ZSZgYwTBMIwGR/ZxXzYW/lzAIyR9lRCUCCFhEMoRLcu1uWaY7mP?=
 =?us-ascii?Q?bypkYDwQj1mcZUdfCWUqOETIfxM2jp/97N6js6t3T04yoP0mIXmi26ZWksjA?=
 =?us-ascii?Q?ZRBwG72qEWYdf9tAnG//TtH1CU1VhDdMDlOxweutQLv0spPx/URFh+kPzT0P?=
 =?us-ascii?Q?1DGpmzMGunv4+n36W3rUajGz5xRSdCUklhuyNPbH/mVnw062S0YNn8V9JTnu?=
 =?us-ascii?Q?KpsghiedVskURlBVRgkYOxPaCNBekTlUdD5UGAkjgemAf9WdTGNES3Z6cE/R?=
 =?us-ascii?Q?H4oYWnerQsH0JCUlzhB/r71dgzufWEi8KNqIaac66RftZ01802mQltoLMzKC?=
 =?us-ascii?Q?THmYZafR7unVRfBn+61KSbbaoWlKs0ls0fCNJHp6/WNiusududW8RT3PdoCR?=
 =?us-ascii?Q?nCARoCRWkpe5C7q51bo98ovYAXgNBRm5REkgAxelD2rhOhmnCleHdVYbe4QJ?=
 =?us-ascii?Q?lR9Kv3GbJZV5FY9MTb2eD4Q3bT8Qc1LAxi0JHpro/mGg4S6nBrYo3pICPdR/?=
 =?us-ascii?Q?sa6cpFS/VBLwdHljGo8/xFjIJljexC8pTAi4/uN5wHQ0S9yKF4V0gnlKpHdb?=
 =?us-ascii?Q?dHAksKwtWRaLsALDqVPUrOLsHGDodIyg8wPGWxuWIUQClF9msHP3sNATQGMq?=
 =?us-ascii?Q?x/waMJ6Meosi29EpY9QBkfYRz0J8rV8JeA/1Yq1qs2ln8nl1o19oxCL63lpV?=
 =?us-ascii?Q?Q6pLDYxlgoaXQWWr3/HzR+Di25fNNFYBzOpiGHn4p2NycIsAVJfURLK59+Xz?=
 =?us-ascii?Q?8YP7luV9IEN7h83X3NUt5OwqrEpFYMKTYMzGOGAt6EJsNbiKS8UWx2Cb7Rnr?=
 =?us-ascii?Q?/bhT/jO/kIZdNPPHI0LLYvMRL8ZmJrji5AQ8ihaJD5QtVEopJ1ic8ziHdLW0?=
 =?us-ascii?Q?Ijqx86ILVfTzm6eSibCSZtsF1zUT73FeC/QVvP+GZqnKUK0zVEgF7cE31q+u?=
 =?us-ascii?Q?iiVaupCUiRJu3DUy1wNOfG7JuHVnVmdRkTw/HTGPZl3Wd8Df5ydi+IBQPuC9?=
 =?us-ascii?Q?tWwYs1HA976Asze9T9jGKp1dQexTocuGDgQawKUULY7cg4RknQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:51:11.5463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3041e4a1-f717-44ec-89d5-08dcf2a8f876
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

Currently when FDB entries are added to or deleted from a VXLAN netdevice,
the VXLAN driver emits one notification, including the VXLAN-specific
attributes. The core however always sends a notification as well, a generic
one. Thus two notifications are unnecessarily sent for these operations. A
similar situation comes up with bridge driver, which also emits
notifications on its own.

 # ip link add name vx type vxlan id 1000 dstport 4789
 # bridge monitor fdb &
 [1] 1981693
 # bridge fdb add de:ad:be:ef:13:37 dev vx self dst 192.0.2.1
 de:ad:be:ef:13:37 dev vx dst 192.0.2.1 self permanent
 de:ad:be:ef:13:37 dev vx self permanent

In order to prevent this duplicity, shift the responsibility to send the
notification always to the drivers. Only where the default FDB add / del
operations are used does the core emit notifications. If fdb_add and
fdb_del are overridden, the driver should do that instead.

To facilitate upholding this new responsibility, export rtnl_fdb_notify()
for drivers to use.

Besides this approach, we considered just passing a boolean back from the
driver, which would indicate whether the notification was done. But the
approach presented here seems cleaner.

Patches #1 to #3 are concerned with the above.

In the remaining patches, #4 to #8, add a selftest. This takes place across
several patches. Many of the helpers we would like to use for the test are
in forwarding/lib.sh, whereas net/ is a more suitable place for the test,
so the libraries need to be massaged a bit first.


Petr Machata (8):
  net: rtnetlink: Publish rtnl_fdb_notify()
  ndo_fdb_add: Shift responsibility for notifying to drivers
  ndo_fdb_del: Shift responsibility for notifying to drivers
  selftests: net: lib: Move logging from forwarding/lib.sh here
  selftests: net: lib: Move tests_run from forwarding/lib.sh here
  selftests: net: lib: Move checks from forwarding/lib.sh here
  selftests: net: lib: Add kill_process
  selftests: net: fdb_notify: Add a test for FDB notifications

 drivers/net/ethernet/intel/i40e/i40e_main.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +
 drivers/net/ethernet/mscc/ocelot_net.c        |  16 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  10 +-
 drivers/net/macvlan.c                         |   6 +
 include/linux/netdevice.h                     |   5 +
 include/linux/rtnetlink.h                     |   2 +
 net/core/rtnetlink.c                          |  24 +-
 .../drivers/net/mlxsw/devlink_trap.sh         |   2 +-
 .../net/mlxsw/devlink_trap_l3_drops.sh        |   4 +-
 .../net/mlxsw/devlink_trap_l3_exceptions.sh   |  12 +-
 .../net/mlxsw/devlink_trap_tunnel_ipip.sh     |   4 +-
 .../net/mlxsw/devlink_trap_tunnel_ipip6.sh    |   4 +-
 .../net/mlxsw/devlink_trap_tunnel_vxlan.sh    |   4 +-
 .../mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh   |   4 +-
 .../selftests/drivers/net/mlxsw/tc_sample.sh  |   4 +-
 .../net/netdevsim/fib_notifications.sh        |   6 +-
 tools/testing/selftests/net/Makefile          |   2 +-
 .../selftests/net/drop_monitor_tests.sh       |   2 +-
 tools/testing/selftests/net/fdb_notify.sh     |  95 ++++++++
 tools/testing/selftests/net/fib_tests.sh      |   8 +-
 .../selftests/net/forwarding/devlink_lib.sh   |   2 +-
 tools/testing/selftests/net/forwarding/lib.sh | 199 +---------------
 .../selftests/net/forwarding/tc_police.sh     |   8 +-
 tools/testing/selftests/net/lib.sh            | 223 ++++++++++++++++++
 25 files changed, 409 insertions(+), 246 deletions(-)
 create mode 100755 tools/testing/selftests/net/fdb_notify.sh

-- 
2.45.0


