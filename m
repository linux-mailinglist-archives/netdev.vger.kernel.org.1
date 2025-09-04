Return-Path: <netdev+bounces-220035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF75B443FD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A333BEEC1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A547B31282D;
	Thu,  4 Sep 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMEeKP1c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151763126DB
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005761; cv=fail; b=sGhN9zhEjh0piRjFZYhfq7MIZqN+35hF9hv0ZRcDHcW6kptze9lsmzjgCxrsOkVuGHGSwYpV3joBFKIXQyNG7nMCMUuEZzv383HvBUyFbzFYo7xRT6JHDydOnjFpBDTFwElufNgObqg4eU4k/AhAMglnTmFkp88Ud61vTUIRbYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005761; c=relaxed/simple;
	bh=Ec4eeOVQe2qtHBziQLH5QUikcJb/mWL0CjdYkY5Jnls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qX+IjPTasuVey752fj3iW/jjhDcNNIlsbwF3wieM+KUA9/fk7cnL/O/pReKhRGoBXexU3byIk8a/w9eJk40zxh6jdsnT7iZYUQAg2M21dJXnLWFPbeNDnw1964fYsDjJU39WGbuwXu2FH7nNrz5I5/HmRePPVDkIJWQcxk72c0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uMEeKP1c; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSD9XESm11l5g4VRsQYTUrys1Uaj8w/Ky4hdP9C73NW8IbqzQVC21x9JU25ME81TMwaMoALBbbw5fqxd0+Z0x6bfMAA0WB4iNAJN8Wq2wWAPu63BekJSdnsTPMNbb/0LpnGguQnCWq0ULKe/AzBs7gnQt6vMhG1FmzrAes01Ydk+asH24z/61qCW9OBYIlqlSUV+5gOhjpM4Q+SNIssMlU1QhVoJ4CVKfTm6mjfWVxBzXwn4s8C6yOLBOhgqUIWDNkRPc4e8/a4+pXSsBWU8MESrnBUVjOXS7oabP7nhocLIOyOL/dNoPADCpKqj9TzxHRBCU0fxzhRMBxuAXslB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7brMdGYVpSzTDE/jO+JkWpyy95YrcKErSknezaltAM=;
 b=s+henuz2vQfgA3CCLTIdaZogOGCZVJwBvZPMe6Mvvx6nFBke2mzx1UVaTmApMZ9iAtXr2ON3hcWQRYjnG7PpymNQpxEyeVnHJOOYE0SOtr/v4X45vRW3wxQmU3PFFksGwc3q3MPMfIkaYtaOD2XTgbcGKfx1OQlXDkg+BHvxQXg9gN9/WVCvXWnnOw9WV/e63iRpY/Exvit9SVl4D/H6R8yivoF8H6mG4TRP/2s82mjxLoSPTx9/rYKXYXwEciKrxK2EjAKeH5o27la/9cjby5goYmPrFs5/KKncxDQZ3aLWVfFq9Xo0oEQ9yWw5shxGZmvhqi5T3SNq8aNozeKTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7brMdGYVpSzTDE/jO+JkWpyy95YrcKErSknezaltAM=;
 b=uMEeKP1cvNAlcFkK2TmT8OkJ0Tv+mmU13NVLV7ONE4tOe+dcKB/DfFJLSeHnuYP7VZzQ2+iApvUKzcTaa2VWXlcmeB8ziwWE528RrD3uOAiRvBsFZuZud81CdqkeVaxOcqZtMotcAADD+Vq9IWfLBI9KjBf++psSyvcGfxn2YWxeW+1tpWsvXWJmWbrqAmZ6C3Ut1oPxX+4iX/f3Bba/8TnNXnmQbx4kU5KpYjRK3GKvRIXDQHqBDmt1pO2q5pckbyzcm1WjeUiJBSOkYWp2dXJZ6iE062neeyl+wyBkSdrseJgfVp9fpvStnFCMvV5JNE4rcoYKDiueAhBaWxs2hQ==
Received: from CH0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:610:e5::16)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 17:09:16 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::b0) by CH0PR03CA0251.outlook.office365.com
 (2603:10b6:610:e5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 17:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:08:56 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:08:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 02/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0: Look up FDB on VLAN 0 on miss
Date: Thu, 4 Sep 2025 19:07:19 +0200
Message-ID: <8087475009dce360fb68d873b1ed9c80827da302.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dd0d87-64b5-4329-89ea-08ddebd5c6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1sn/uoOeQK0cFXN5bhiSxJxZ2D4BsEwPNd+vCOXWI2BscH2Bclkfme+Aes+?=
 =?us-ascii?Q?WghC8UxQQhtZPODfw02uwP7HpCfZbP1zHC9EZ4f5eUXlv37Z8X5J+Soh/GAf?=
 =?us-ascii?Q?cftHoUqDA4MQNZJRB4ne8cco8jIIft2vnTNiiaNOChSvzLT6gwzEUYxnIqVe?=
 =?us-ascii?Q?2I6kOWhbG+yvhjbmHya7gvdMxaecAfgbo8CHhwm0Vh7CUMmUYq1YlJfR/Eyl?=
 =?us-ascii?Q?X/lRTJoCNHV0DwQuRT5qPUbDBi4aryTjQfEXcZ7teh1XzJtWUMpWiLeNMQXR?=
 =?us-ascii?Q?cnElEwJ0aclTo3G/I7/mlkWcZFIRlR/SuyXr3ZeIpjGecirvwxLK5hI48OcG?=
 =?us-ascii?Q?DhF94QenXnUTnSgPxoHRkvNU9GXSzLWRGOOrjBeyPzgLPikA3bBLLuNC7D2c?=
 =?us-ascii?Q?7FWp04YHNwqcgAnUWkuKk/GUumlfSdEr7PlijuU0uj+2aoS2Abz6m21taW27?=
 =?us-ascii?Q?6nbZCimw8BMtykFDKwKfw9GYbtc6AcIZmKrzYOFNmBjmhZNQpSMV1cFZVOMk?=
 =?us-ascii?Q?04RJryXdKB+7E38bhPaQxFDbYW+0gdv6injJ0IEloqU+X/s/POxJLqzKJjFf?=
 =?us-ascii?Q?6bJDNIobyLV1OOQYkx3kT8bZn3ogj+8RRPt7NO3L5YNmKZGl9yD5KaTBjm6Y?=
 =?us-ascii?Q?Ua9LfyKhl97sq3pA763kkD+CqFkxN3eHUaXif6hF6IPGW4NPEAnDyO7Vwawu?=
 =?us-ascii?Q?DfRg9ZJ/rW8ChEWgbH2AnSC4npfp0zmgaWshkW4d5cFAO4J8lwPmcpSO6oo7?=
 =?us-ascii?Q?a2t4KQD0BJuw8qmkwWuIBFmtX0WVef+UYz5OxnsBsejsVgtKUgY+7axtSlXX?=
 =?us-ascii?Q?x0JapRdR4PGrO1/9J08+HxJTkVyf99Tus1jb7YmTbEHLZB07zNnLpgw1SZDv?=
 =?us-ascii?Q?IYV1O9Ikb+HVEnUP4qNeXJj77Dmr2RnpJ/MkkRYKcdn+yLWWzqyGKzsFwvcW?=
 =?us-ascii?Q?hOn7ZHi0j4i+9AkJ/aHgyMlqTaDps9XzkUL6XwVPN2PfVgI8C07GlT8AhiiN?=
 =?us-ascii?Q?NPzPHCTalJEjjoIZIcTkDUVmB6HZ1edCm6h11S6kzMuaT5MTr7q5AL5hP1Sa?=
 =?us-ascii?Q?8QiGLZOJyIiJQ6jSxJQiDesDIgMz37LzKKufOtp7I6bVo5EMPz7icXnlxUGC?=
 =?us-ascii?Q?ngpEH5pcDiDp732HyYBPzjb8wfjq/NqXTeL1Vn4FZdtLMYZyNeixuGbYBmG0?=
 =?us-ascii?Q?7tTqUwQSpvCplZTvNK/nwfz9wlQFGHwEE6Hv+CUSjirofYjK7d6hhDqEfkhO?=
 =?us-ascii?Q?0oULoZJD3Xnp7SV1gflwmftPxJsU8wpoassP4IF1dn8g/+w+Pwb7cp6zXkvg?=
 =?us-ascii?Q?RH7U4/SI4X4PpoC8GjFktP4Knyz45Mj/BtxWBs20rOVIMBmc4bBk6PBMrtPG?=
 =?us-ascii?Q?11RLvBJvdBZ3qlgtN4jniQTk5Knsj3tZQvg5FE/ZuWhSZ/FRrCvPoxrJ1ziI?=
 =?us-ascii?Q?H/IkIylrUiY9TvkGqQzBkODOrYhiWtkeE6XZtSdIetVNuUc3G2LHOEx1Ch7C?=
 =?us-ascii?Q?Srm/oTCIX9zdSZASlMsco8ubcUMJb4I1O8eA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:15.3819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dd0d87-64b5-4329-89ea-08ddebd5c6fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

When BROPT_FDB_LOCAL_VLAN_0 is enabled, the local FDB entries for the
member ports as well as the bridge itself should not be created per-VLAN,
but instead only on VLAN 0.

That means that br_handle_frame_finish() needs to make two lookups: the
primary lookup on an appropriate VLAN, and when that misses, a lookup on
VLAN 0.

Have the second lookup only accept local MAC addresses. Turning this into a
generic second-lookup feature is not the goal.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_input.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 5f6ac9bf1527..67b4c905e49a 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -202,6 +202,14 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		break;
 	case BR_PKT_UNICAST:
 		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
+		if (unlikely(!dst && vid &&
+			     br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0))) {
+			dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, 0);
+			if (dst &&
+			    (!test_bit(BR_FDB_LOCAL, &dst->flags) ||
+			     test_bit(BR_FDB_ADDED_BY_USER, &dst->flags)))
+				dst = NULL;
+		}
 		break;
 	default:
 		break;
-- 
2.49.0


