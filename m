Return-Path: <netdev+bounces-143790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58EE9C433E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7466228223B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD271A08C2;
	Mon, 11 Nov 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MCuXR/eJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD313C80D
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345104; cv=fail; b=QagO6vFrm+CXPLR5jiCcxYcpqOSf8yU43jKKIu5b3p5Qwl+UGS5j30zZqajEvSo590wSxqeAkZLifomHhg1eE/lLMlM+WGDAeKaqjShAQ0kwOrZ9r4ILTTeIOVPDs431KfdLuiasbs4f/J9lz5ktvtAEANSJ2JYyA5Pyjc7j+Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345104; c=relaxed/simple;
	bh=VIB5Mv4nHyiHHPWjaRAI5Qi1Toj2on51s2tf77w+MZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4xkdobVW4BBeyLHR90dD3LRv0lDbrk30UpGG8vTq+p1HZo6cNcZyHdUUkKfGIxx7oeuacltL1rpFJIZ8S6rbNN8jws7mW9hRQbeknmaSYPH5JXrIkA0jYK8FwPztxF0dz0LNws++9Y8YuJjieoIN3eMQE+Oi6lQhQp04wU2Blk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MCuXR/eJ; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEKPXxVjiyMXzzppoTpmulJom9TWiAW3xOG1DbYvi19LEU89vol4iv9neu6MFl4pppbml/LvTpoeFkUi3OsUcAXQUT/8osgzV66kTQHMWBa+xu55Mbo3n18Mj/3g/Eu5pe0arExQsKIdx1DHieQsjOK8Qi477NAZU/IfbiCsgofLCHVDrIdFog/YobuGcJR5WNbYQ2B+a2Ww2lZ65Bt8oBcvA9+Dbk5RgrhMdauzrABFFoKnA6VodCH87OHEpnK6qOdU/u1rky20E+lTR/AwBj6ZQ8eBm78EC9w4CAy/KRdmE1k/0mkOWcKIlL1Yoyr00TzMgJdB5Mk2FAhnVX9ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBE4EpTTNqkf+2jkZ5PGSFlBHOxJLDS+TUmazC5SMKQ=;
 b=jR+XHHnNVyiruf8TeGrXxcM+nCGw6jTAHKeD1fQUVDHtM99uo21bO1VjI5FiadWZUPr40nMJX7hkTLI9YENnGWcQbnvA7A2k4byqY6TkaGqeBzubG9JfhvO6Ln4N1VWfKEQoAx9cnS5hcD6zREjv01bhgRUbLaDCS7TNgkUU6uDRrTIapfA+R8TyGcwn2eNrlofRFrBfHub5KuQhyaNJooVu/PYmSVejdCLo/9ieiZlm70nDT1H6OAprgGKvnboXltehN4SflikW/0chwXnWG1pSsu7Btok5JG2kSt0LNJPBuxwliTsbBf5PfuUdEUqHWTaSuFmPmu1hQ4GoYpT1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBE4EpTTNqkf+2jkZ5PGSFlBHOxJLDS+TUmazC5SMKQ=;
 b=MCuXR/eJB99+ceCltT3HSP3I56qlSrnUB0rAS+BUXVxe8kfN93iIuPiFhpuPuP0TvF4iFJLmYHdqTTgVqyGNB0fqj3PpHdixCuHfHpTYkWMgVBKxI39V7JhT8BLTliRhHb91yaqLFMA017ZmKaF2y3rX/b2B1UhVFE+goY2B+EDibkzVBZZHxZj6btiIiQq5ixkhezlirhyY/lfiPhI4jlp57lpWiOSfCjujf4YCvWz81otXfgqp/bYkU+qikrY/RWKfp5WDkiwsc25J11T9CzHjcewEETv1DRLkAOcpLTt4P9eDYMMCtZiUwVSgOo9xxbAVvgjwNzbx8u4VINTRUQ==
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 17:11:38 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::50) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 17:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 17:11:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:20 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:15 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v3 0/7] net: ndo_fdb_add/del: Have drivers report whether they notified
Date: Mon, 11 Nov 2024 18:08:54 +0100
Message-ID: <cover.1731342342.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e43311-0883-467a-b6db-08dd0273e751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agO98+ZjtnwLz5uGyeGMM0hNH4M+zDf+K1EAFUB2XdDXhreS1POXVFzrZOtE?=
 =?us-ascii?Q?jpq4wI4gkvGepU4X4hF3rTm86sbcnMLADXZmnhQ03jkgfSQmOHAE0TZEl85j?=
 =?us-ascii?Q?1OH2lDLaPkmUgQRjTS7Yjy1Jij7rMvSR8dJoy0hcRTs4TE4PxRofGw0/GAZx?=
 =?us-ascii?Q?fiyocnYzzGWkAj4hpAkPAzJEvlwxEPkCHuIg9xmBBRZcLnhB2dFlMqebHYI2?=
 =?us-ascii?Q?7KXEtUDLi7eIfBFyblvEltXATkb5tIqz7wDwCOIYG8KLxF5thYq9ELLStG3r?=
 =?us-ascii?Q?rmrFNFr6y+LRjS+Yy693xvEObSv63jh2awazPhYFoqjtFXwfHs22HdJd5aU8?=
 =?us-ascii?Q?deo5VTgUlCqN6x4upPdXLrGYZ8kxYiHcs0OV7PAizLlfka7Y4GcHbu8zYYRM?=
 =?us-ascii?Q?3XZV8dp+pjyZ3aAp45wj/f+UjHB2oioRwPlrW9kvxlV5tCdS6we/9sCbKUTs?=
 =?us-ascii?Q?ZBGumVYkzkh/qRkGVaZnd33ceToJK3IGvpxNBP9sMTt6ItD16v8i2YuIL4Lx?=
 =?us-ascii?Q?7QUMhZAy8MXjvEz2kaoCZZg9hfT1/T3YDgEcCaANHw2YkwN8WnjnZ8Un/+wf?=
 =?us-ascii?Q?i3forAUVh7WmJwYFAIji7JPloeYjdeDuuH4sb1KsXMP7EMjjuB0lEg4VZq47?=
 =?us-ascii?Q?m2ZTzFjvPe546GeR4YZLb1ORkg9gQe1rqWO3nURJqbXQA+sxqY1qjNlixGPg?=
 =?us-ascii?Q?h81NHNYBYOKiRXv/iCH8gYdLwbZ8tCFMaAQm07xpf/o8wzt4pJna7c6jyAOG?=
 =?us-ascii?Q?2DvPY1Ig9z73V7AaJ4MwVJecZuQPRkio8fgKekMmDv2ZFrhNCpLzxfb58zX/?=
 =?us-ascii?Q?3Vc0ImwnN6akU9JzatbS/rJR9otgky8jMAXGUUzFougzrZB4nWTssdiCqJDk?=
 =?us-ascii?Q?/xy7TkAApsJ4I7twelMAWEJNeYaw79o+Gr2OFWwAetyBhupJYG5c1b/+bVEL?=
 =?us-ascii?Q?7LU5nrZAgsyR+sY+p7oz/RjJlLBsw8Hl+ayy0oLaaoV5t7GaF7AA5aTj7cVF?=
 =?us-ascii?Q?Rn2mHPwnS2oEuLMJh2UMMKf7s43NuNMzn7i2OFbEFo/ZwUg2mJF2ykoOhyxC?=
 =?us-ascii?Q?LMAXsSqKba/NIc+ms9HVn46BGiNfCLLg2rySGBpB3XMJS4YVubJqQ1yK+G81?=
 =?us-ascii?Q?26KnfaaGSjUgCUtmti6V3NYA3iGzKJUPIPysgJI7KsXHoaWXECPStDK0Xmqn?=
 =?us-ascii?Q?lgsoJ4zO9Kw4YJrm0eqjs3uLoBD9D0UPb/li1Oc+3L81CpMR7ydzTxw+pKIJ?=
 =?us-ascii?Q?7lzkH8YdJv4PY8x7J7irUBqcwAKzvXFb6laE96ycz5YmlsKh1nuOeQ5VSmmE?=
 =?us-ascii?Q?brptxFBNPCz7UawvCKA0hHbpAdEmPg9yNPl7E8ZNoA1MS5dRiJc26xhVBw7n?=
 =?us-ascii?Q?gF2toznVakKbwV2xEgaAJfSmMbftJO7TIyuipS8SyNjlF01JgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:11:38.0302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e43311-0883-467a-b6db-08dd0273e751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

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

In order to prevent this duplicity, add a parameter, bool *notified, to
ndo_fdb_add and ndo_fdb_del. The flag is primed to false, and if the callee
sends a notification on its own, it sets the flag to true, thus informing
the core that it should not generate another notification.

Patches #1 to #2 are concerned with the above.

In the remaining patches, #3 to #7, add a selftest. This takes place across
several patches. Many of the helpers we would like to use for the test are
in forwarding/lib.sh, whereas net/ is a more suitable place for the test,
so the libraries need to be massaged a bit first.

v3:
- v1 and v2 differed from this version mainly because they outright shifted
  the responsibility for notifying to the callee.
- Both substance patches were reworked, patch #1 was dropped.
  Selftest patches stayed intact.

v2:
- Patches #2, #3:
    - Fix qlcnic build

Petr Machata (7):
  ndo_fdb_add: Add a parameter to report whether notification was sent
  ndo_fdb_del: Add a parameter to report whether notification was sent
  selftests: net: lib: Move logging from forwarding/lib.sh here
  selftests: net: lib: Move tests_run from forwarding/lib.sh here
  selftests: net: lib: Move checks from forwarding/lib.sh here
  selftests: net: lib: Add kill_process
  selftests: net: fdb_notify: Add a test for FDB notifications

 drivers/net/ethernet/intel/i40e/i40e_main.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   8 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |   4 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |   4 +-
 drivers/net/macvlan.c                         |   4 +-
 drivers/net/vxlan/vxlan_core.c                |  10 +-
 include/linux/netdevice.h                     |  14 +-
 net/bridge/br_fdb.c                           |  27 ++-
 net/bridge/br_private.h                       |   4 +-
 net/core/rtnetlink.c                          |  20 +-
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
 29 files changed, 418 insertions(+), 267 deletions(-)
 create mode 100755 tools/testing/selftests/net/fdb_notify.sh

-- 
2.45.0


