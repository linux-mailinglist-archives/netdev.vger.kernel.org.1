Return-Path: <netdev+bounces-183775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841FA91E57
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0102B177A86
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70424E009;
	Thu, 17 Apr 2025 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFEdsWzl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24E24E005
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897444; cv=fail; b=t/hMBzR9I5GflzuMeXW8slOXtKYdo3Su9u0YM5gFKpM4quimYu8bNAqzbgdmjHTLH488m02hVxezCjLZpBbp8pko9PjmVdbamsveV6gWM2bkg7AdaxcsOl0KVjQrpkdl7WuFBgLG6jFQLNBDsaNf2g0vu/z/kbCpHdbdGRu3a24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897444; c=relaxed/simple;
	bh=bnSBzLGDf9DvBjatyMWrhAhVUtnHngjE0+y6Hi67pHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rti85dUSWOMkYieQWljNjSUJuffeSgyzhncdTevDC81bhJYHvtzbLd4GPmTt7/ukrwrRuAwKCOk6jLy8pbTUw9ZehBpfyiidM8XKm0kQL2+MDUv3e18QeWYStst8tnutuXhJmIijZDVP0AjPEWjD8Sc09qsSW3HrEKCW+pt4LMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFEdsWzl; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fICYFjfwI1kGW1g7dprnn2bPtBlXHRNYE+RXEX9BIKV2/z4TePRZcVyzNoK4DRPvvT065GI7Ojenb9D1DcS5MrlUY6whkqqJM6U6ihzzDoUZfWeBLocaFh0+UmUjNA4K8Oo8k6eUzj2zQwXlYXBF+u3ohIikGV5z9RepPGeAJ10X8CRnaGVseyJ9/1Ph4eSeRPie9dwBT2GNiQDO8QTnQ5cpaDRtMRl1JgzQ+DQXMKUN0yA5aGrD3KfaDhmMb3mhX98sbV8H81tDpCv3wudRiq4NuHJi0rB7MQDYkxgBwMHCAlyMlZLxw/9oub8CJtgURNq5FGQc99TxbIh8syG3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVr8BPr/uprDgzgjnMwdM5dBhKtvvEtxBydkyTZk/WA=;
 b=pNAwNG8u12XissGtlaEha5sQrzgH4X7dgXbqKpXn6gNc44xq+LUeLoiaPkpz5TX9QKFnhtrtHmr1DqT46BtXXDwTvhk4HOdyiSwBJMfCHAlOG7JB0KQfuXp/ZkTCAFGN8UzpC1sCSPgDtZ2yfcPzGc2z1cljTIuCizfs3InTjgz/HOD2tJDioGtgnVFJSjlNplcWXRqKr6NlHNd7h3DYcBoVWc9ayJ7/hVab8r84xmLSFG5Ld0B9qB5EBb5SvPo6P4AXre8y9hrZJHZwPdMenPUwzA/PHKrnCf8smGmJ0tjdCkf50xhjTy5+3w1l3cdWmyiR0EKyj2Co0i9ExNdnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVr8BPr/uprDgzgjnMwdM5dBhKtvvEtxBydkyTZk/WA=;
 b=fFEdsWzlvqg2kkuKAeLPT1B0rRG6mhErfkVxG6Y0NjTrL7EnAV0oC02X+1quJd7cG5WVg5gaVdcCVcvow/tU/BR/pO34/FXt7yNEeRJlk3GG3xFOSNVzGL8uQjbI8L0sG2XPxhzhkKcx8wOpQ7So1fG7VtFEl0Qy6YGvGFQuPD6cOOyJV9udaYr2xxrW1sQxU/qiS2g1fUaUlrZsx1sYo6KNNXkfkO3/DPYCipHyEyUKtOfyz9g8nj+lKvmXMbvCEk5n3TgjZ4oLSwuIdBXkQxYWZD3M0ju8SwQ29PDvTeZQu4QkIvK+YpcHXFTkcDegQ/NSfgVpeTmvRar1LiD1Yg==
Received: from DM6PR05CA0040.namprd05.prod.outlook.com (2603:10b6:5:335::9) by
 SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 13:43:56 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::10) by DM6PR05CA0040.outlook.office365.com
 (2603:10b6:5:335::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.13 via Frontend Transport; Thu,
 17 Apr 2025 13:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 13:43:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Apr
 2025 06:43:40 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Apr
 2025 06:43:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux.dev>, Yong Wang
	<yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/3] bridge: multicast: per vlan query improvement when port or vlan state changes
Date: Thu, 17 Apr 2025 15:43:11 +0200
Message-ID: <cover.1744896433.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e734fb-992e-4e6b-b81b-08dd7db5e5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FEpsFm0m1YxrIVftGRg/rAxi3vbVF07HmZXwty626QKLeeo7BwwYo/Rb6Ctx?=
 =?us-ascii?Q?KMYUNoY5ap0L/uqRtwQi9PMYxBS6q5mPfF91h5JbcQRCR/qmX7KfuOysaYVm?=
 =?us-ascii?Q?Vsi3NbRroDQ2AxC+Ld11eOOLuYP2MeIX2iy0YQq6hsD+dsTUwHu6dyztBbKX?=
 =?us-ascii?Q?MEYVNnqnEF/zCU3ohDMtM2wkRWe52y+3Sn3z9G+AXymXB5lnvDrPZJg6BdCt?=
 =?us-ascii?Q?jnWPHzF77U5fvZtQg6rXkhzQnfIotrbJ+hoiYNQsYNmNxyxCk5hg2B5vLMeh?=
 =?us-ascii?Q?VvNQlutYc2X0g//Nszs2bm4mWv7kUmc94p7BOyUGDRcWB+WkI1dYYQw/9hce?=
 =?us-ascii?Q?NBdSvdzDE3j5DUejes9ZWnUlpKMprER5E1Ib6DwYFONGPCepS7UZfiu4s9Lk?=
 =?us-ascii?Q?AJ1t5b40HkpgxPKTuWCNk6xnLzZw8QRMH8iYT/zurh3UXkgWZXpvGORLu1oK?=
 =?us-ascii?Q?TP7WN1v0A302CnfzJyqB3fZmdCizt381eWG/XA8qPNvzq7xBITja0mJP5ae9?=
 =?us-ascii?Q?y1J28RAea4pNA7KHsNmpMGqeMjojb7sRQqgqy9CRz1R/Ge/gz8zzf6UdP/xV?=
 =?us-ascii?Q?V4sn92PMIwcFUIwYqXUkxiv1EG2rGW+S+/Tvy6UlHkPyIn8J/JFLl1rvMwP5?=
 =?us-ascii?Q?uK3EFtu32Cld5T7BpCaumUPhEy9HyfbzkSfjEluzeU1EsIwgq96Kkm6CBs5e?=
 =?us-ascii?Q?gpMikjf8mbHGOTPQm/bStPUyMilXRgNhpwJnvw++qH/05PRv96zHARQyx7Zh?=
 =?us-ascii?Q?gsRVtV+WMjmRcL+O+q+PuIFHGy6oplSEGjQ+OH/424+yoLuY79Wa9Oi2AHuT?=
 =?us-ascii?Q?T5bq4XPx38NBqGt0JQ6YYsC2CWSoWsZDm02poP/G//D3aPVy6I48IG9mbbUB?=
 =?us-ascii?Q?Xa9QWe5v9VGcwbW9KWBU32bV5lKhAOXNXE+JlpDlUs/ohZXe0NbzY91/O/Cz?=
 =?us-ascii?Q?q0bDn6PI9nkjxxm5pdVegWRSogWD53PkXqBsBqydarZuZcd+KErhGRD/Ryqy?=
 =?us-ascii?Q?DH0ce0fv/eVoNz172rDTZk9cunI5Nl+yXQgFTCRYoGaugl99CwGFE8Y3skkh?=
 =?us-ascii?Q?F18eENiHt49/RFUhSpn7enqUGvrFCFqENigoKWr3AjVN7XMcRjHdZOXQa5hj?=
 =?us-ascii?Q?coutw7DKTKRZpEqgPCXAUck0+xj7/hLBWuzORB1+mIqaIFP3VHounnzvvopi?=
 =?us-ascii?Q?KuhfPY5di0LlkniYg2IMWrPNwILtevsJkAoGtFQ9tarhdGA0EDOagGm0TAJD?=
 =?us-ascii?Q?hVr8hDKbHCG+HfUp1eA1ZdrIHXn2MdwnVJGyEqCjtibhRo8HhrxOn0uzVFiS?=
 =?us-ascii?Q?qky5wQwciacSzarH3sDCBtjL8Vi9HeHEKukFo2yd2hZ5WCubsF9hqlRFF1Z0?=
 =?us-ascii?Q?rzCjzlXS8rVDoY11lmAFqbbkD79MLmjGkLd5B0Wa9Lz7V1XRjyRw9rNo4Joc?=
 =?us-ascii?Q?TAEceFxheGomOCIbRnbpqLVR11WPApRoIbPpmisN1FL+lBvgMvUTFZ+MXDzX?=
 =?us-ascii?Q?uxXGdNMl1ZArbu5rIHMzCQ75MAsk32tolVM3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:43:55.4440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e734fb-992e-4e6b-b81b-08dd7db5e5e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

From: Yong Wang <yongwang@nvidia.com>

The current implementation of br_multicast_enable_port() only operates on
port's multicast context, which doesn't take into account in case of vlan
snooping, one downside is the port's igmp query timer will NOT resume when
port state gets changed from BR_STATE_BLOCKING to BR_STATE_FORWARDING etc.

Such code flow will briefly look like:
1.vlan snooping
  --> br_multicast_port_query_expired with per vlan port_mcast_ctx
  --> port in BR_STATE_BLOCKING state --> then one-shot timer discontinued

The port state could be changed by STP daemon or kernel STP, taking mstpd
as example:

2.mstpd --> netlink_sendmsg --> br_setlink --> br_set_port_state with non
  blocking states, i.e. BR_STATE_LEARNING or BR_STATE_FORWARDING
  --> br_port_state_selection --> br_multicast_enable_port
  --> enable multicast with port's multicast_ctx

Here for per vlan snooping, the vlan context of the port should be used
instead of port's multicast_ctx. The first patch corrects such behavior.

Similarly, vlan state change also impacts multicast behavior, the 2nd patch
adds function to update the corresponding multicast context when vlan state
changes.

The 3rd patch adds the selftests to confirm that IGMP/MLD query does happen
when the STP state becomes forwarding.

Yong Wang (3):
  net: bridge: mcast: re-implement br_multicast_{enable, disable}_port
    functions
  net: bridge: mcast: update multicast contex when vlan state is changed
  selftests: net/bridge : add tests for per vlan snooping with stp state
    changes

 net/bridge/br_mst.c                           |   4 +-
 net/bridge/br_multicast.c                     | 103 ++++++++++++++++--
 net/bridge/br_private.h                       |  11 +-
 .../selftests/net/forwarding/bridge_igmp.sh   |  80 +++++++++++++-
 .../selftests/net/forwarding/bridge_mld.sh    |  81 +++++++++++++-
 tools/testing/selftests/net/forwarding/config |   1 +
 6 files changed, 261 insertions(+), 19 deletions(-)

-- 
2.49.0


