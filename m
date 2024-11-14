Return-Path: <netdev+bounces-144925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCB09C8C8B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8061F21704
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A672A1D1;
	Thu, 14 Nov 2024 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCnnikJ7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3949BA53
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593530; cv=fail; b=mWosM2jXua/92Nrm+6KJdeZjCMzU7g9yj7p+jGrl/VkdnmwwlL+JCXigMdWw5JothlYU/y/d6ZaeOkVd8RoyildT92/c4ckaB9HITXZBf98i3dhwyKGZ2+EJXVQItlFk9RWvIKgwUTQZyKF09JvY8ThQc2Q9D2UnOC0c4jC3X+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593530; c=relaxed/simple;
	bh=oxOMQv8hjiSPAXN3QCnAd0yVFqO0BT18X/lHyK6FLTU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jjUiGCA6IWf0kzHlUgtdFZd7ld2TWUw3aAZTTrWu+7DlRlpXgRMmiX7UGkD0D7KASAh0jQg6L6+ZB8ii3TFWjWdEUcGuH7kkQXJuL7RNo4Fw+SkzpLZMotRbff/ZRnbCHpCaj/VV+BEJrxfY3I3fIDFznW+N8RfQbg76iqs77Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCnnikJ7; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9E899JsAMKjXrpTxG/PHSxpdvwa30rOVd2Jn4Bfm++KHSwN0x/xhXjfm7bQmIVJl21RTG5UAACfyerMJqcLJ/uhSNr/MUFuOJG5ixNdOfbJakFFSuu9nqH1D/rz3+OJ+zo7C0UCmK+251MhqOU8jdyMwEORlSTrB664nt0wU+YAC7AQmx/whlPX95LEKLdzcyWeokK4QV7Nv0dvMwJOpH1Pk/ZjlNayp3DLUJ4nxMFvf9cMlEhhZmbLzKgnHsQDNwVt0/Br2qMum678iM5kW1ktEXTBvppd275Q0CJ3UzQDMc1XrhTCEeDqppgjpi8jOE6+9TiAmn3N8q6LPQi2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81YRp/FXhHAFXKNvu6+fjl6iZpwxvSjig2JTj+w8o2E=;
 b=oLSzn36jYmdCijrMjETDRjsQXDTX3GVtlIO1WPQcxaSqLHjw11PRYyuSIO98CV0CoffTFk56l8dlpacTdZVXumQXOIWjd+6wQGuiZsbr6xiw0YTBOR9mNDtkyH+hi50/Gosan8s7rjd5LbSXg9aroYrTVdanROQaMB3Jd0xVXapbpLVtf35Zt3lpeKwYRa+jpwg6fB32SIhYhQT+4f6iaDEZkijlguw+6yubwiL4heSqJSgWid6i66+Os4/08ifNTYGPzzQrzvg6UTcN7uLaRMdvowJv+ulEHsyf1INVHQ0I/FQ6kCRBu7FWFbagv8fMgXi36Vl9ZmRIRJOKMfkK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81YRp/FXhHAFXKNvu6+fjl6iZpwxvSjig2JTj+w8o2E=;
 b=VCnnikJ7GnQMBuCaWQ6ZMwf9oSgEwoxmxxa9uZCmtqHow1RljqLf37L0w6YG2dcNRKRElUj/ZWSKfUqLJirD3KZ48RNDMTR+oSPIxdIhKmMct8/dYP3YqPUUx4JWkzOcVeTTGCBnQlRpYzpILYzMNwJ7jeZFXz2vskVYon0Tpjg64t6qDJgBnMkTyWeNouZJp3Mzna94vS0qktVtcqcfBek7sC3/5yvNVeig7I1dhYVCj+ON5mn3mrGHFOTOnszNsHrjo6c6RJ/kVcA2IVT9R5szlLft4Y42iaWJAhDk0WOPhl8IGI2pRQDJLcjeoOzqqHgLcKVdMUPhlJaJti/r3A==
Received: from DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16) by
 SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 14:12:04 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::ea) by DM6PR01CA0011.outlook.office365.com
 (2603:10b6:5:296::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 14:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 14:12:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:11:49 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:11:44 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v4 0/7] net: ndo_fdb_add/del: Have drivers report whether they notified
Date: Thu, 14 Nov 2024 15:09:52 +0100
Message-ID: <cover.1731589511.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: c44b4ae4-f0ef-45aa-1c43-08dd04b6509d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wJm9OPV9VCU30MInye6F9IBWukaJae5DX5pvyYTKJwd/i7pkwlkAe1lsTwA/?=
 =?us-ascii?Q?9tHIKcgwGgCvwH3GZZndmSD1ozQPRzovKkCk5Ph/aGXCRKxjOIHcrNdH0B+9?=
 =?us-ascii?Q?sVpANyAEipxSIc6pEmMnVxQgIGduaRd8UOjnTL2C+GuRAcbnL/cpObSTfA4p?=
 =?us-ascii?Q?2KpAPPbzkRvEQYmtboIAsHFWN4xaKan7ef8p2drOXnudLP7H1m/4XYRxIunM?=
 =?us-ascii?Q?V2+kCBKIslZtlCDwpaPaAqQBkmFZnmcGWVW5x39W+Fc4j83WofhdA4F5Drdf?=
 =?us-ascii?Q?PwQMK3TILddxYHYS+YQbbJoRWJBKpKlQ420xC7ZTsEa45SfeXZ/blPpPSpbO?=
 =?us-ascii?Q?HtVhziHWcKp1Ab9uEe/dr4GORXhcbMWzqtMm3Xn1LLCNRXdH1D+dCy1/RB/Q?=
 =?us-ascii?Q?6vz8oXgUfShWoeX89dYqS4xkoAfBFh2/Sya0LbHc89SCbePx35vKSW82p8jN?=
 =?us-ascii?Q?r0VJT6N2ccK28DnLvQ9Ut1I1iXcezGFTAJAsJZyxMTP++DdDWqwVHFvn5FV1?=
 =?us-ascii?Q?YCZCjW8Tity0S0mimXly12lTfbwxupAdw7uqr5KLyD/mJKJLAsYd6Ui7zLDV?=
 =?us-ascii?Q?cQfO/uZp3B+mvor6vcvlnT9r19l3yxwBUhLGdLNLh3zXSJMqRQgxtEM9RoV1?=
 =?us-ascii?Q?tHFse2EbV4Bdf6qMF4aI/odiHhzTyzlcltzlx+Qz2zfujQWEl+qNoOqL5Czw?=
 =?us-ascii?Q?AmlPJtw6JmZb/u6qXxTZRHBhvb5vWgV8gQP5QjZulRWPWm5L55Yq1w3oUtIv?=
 =?us-ascii?Q?RLhsZwHpKttpKYbFPBl+N1aIGbSIONHJ7XaQoptC5rvQIN5TFlPYm8mFqLWM?=
 =?us-ascii?Q?4eDLAWSBBT0pdehEkOZz3aqzrWFb7MTYHA59bzP+w380n5FhtCKZeyD+YCUF?=
 =?us-ascii?Q?pEI1u92A9eRmWc+GctvH2DBVIJnsWfiXH/pr3xADJvi15IN34fO+uF/d6Dbu?=
 =?us-ascii?Q?DJW0knm42w8ztR0ql+r5XGZpmI1xuYkkjaklQ6a/Kou0f0dfRIaZQ42v9s4h?=
 =?us-ascii?Q?l2+v2EMjnCRXzWPZLJeIY62WoCeiVcNYOwtX+QpOhfRwjd/THGMmg2+2Ab2+?=
 =?us-ascii?Q?wzPxYM9r0N19kqxwygTwV3Oe1stimexvTQWDImUj9EjzzcSGGXsmd5y21htv?=
 =?us-ascii?Q?W+n5Qomlmc7g2qUhIMme617n/YgVbPXwj6dqFgYNUEZSKXrB3jtC0LHqd8Me?=
 =?us-ascii?Q?/3dw3EG7UVr2g8PqQ7zphlkVxQhnHXJquUDkPzT0bNzBqQwc/M6rKs0mwJu7?=
 =?us-ascii?Q?KNx1hlKPGibinj5z0c6gWqEA0ZFg+ux4pazrdeh1fWZyIZCOdMwLCWfK3MQp?=
 =?us-ascii?Q?dFNPTuOMdAGATI51RN/mxlqv1XyhmgrXsze8fTJFpqZd45S+TuPLDyihIxWQ?=
 =?us-ascii?Q?iCJBQp+fClTbHhfPzSyGoDu7C5BGHXMkoMrnnN8Rlv9/6zY00w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 14:12:03.8104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c44b4ae4-f0ef-45aa-1c43-08dd04b6509d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839

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

v4:
- Patch #7:
    - Adjust the sleep around the FDB op

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
 tools/testing/selftests/net/fdb_notify.sh     |  96 ++++++++
 tools/testing/selftests/net/fib_tests.sh      |   8 +-
 .../selftests/net/forwarding/devlink_lib.sh   |   2 +-
 tools/testing/selftests/net/forwarding/lib.sh | 199 +---------------
 .../selftests/net/forwarding/tc_police.sh     |   8 +-
 tools/testing/selftests/net/lib.sh            | 223 ++++++++++++++++++
 29 files changed, 419 insertions(+), 267 deletions(-)
 create mode 100755 tools/testing/selftests/net/fdb_notify.sh

-- 
2.45.0


