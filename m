Return-Path: <netdev+bounces-103248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A139074BB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA841F22BF0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D92145FF1;
	Thu, 13 Jun 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lpH/zh0l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206B145B3F
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287868; cv=fail; b=bDGB94iwIjPYQ93shGK8KAN2/pS22PtW3bgE0Tunt620O9LJpjq0Wjq3UB9xGzDZTd5IspSedIldirfCODOdbLiYhUtJUhY74DVTCqj1dszdIvvhkakBOh/S+sF2I+h2mkfjJpWp6Fu1I+hQlWpqlgajbRwLCCL5F2zWfewywV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287868; c=relaxed/simple;
	bh=FCo6FeKxllqqh4TMyUN01laSzWwnEN5Comu22lgl7lE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEqR60/2QzQG7Q1qacsssd6gBRtreb9FmbogC6UqYf9gN33HIQmFomkgUZlDSlGEkRtfYo1fNogsEm5cGVP3uuipE/BojzjlYjaHRBUdbVX/Ws5nmg8924pWiJEkrUbH9Wlt7SnjMA2cARKNxk1PjTaqUZW5n5odhswERSPZO+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lpH/zh0l; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUe5DHSPZZoFUh4YeugYA+wTJHzqd28NSvKE162GE1UqpRfLyMnipkvq8Bh2dke7SpkY2ItLJHw3rQF34o8ZqmAemQCMNmvbq4LrZ+1mj0M5Dy7Bg8U+xgJ721CFzKrJSeb0lA2/IsqiX4AuMXWemV2XxNS73/CjyyDCD0PmFgHs8hbBS2GXNpybT3yU0KNjm48hIv+SCVc5Bnf/WrV9YFBUOwqVqMbHLWAfE3YgXtLmtLPucuiu2aJxOexW8OKL268l1E4pt1oV5CVhSQXBAtsZsId5VPQ6crPurwpIW/uSTrTo9uhFa8VXAZ38furLEn6yBIdOMgcgxX65V84luA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tYSlXRPFsDAcLjUod9C6N9ofZCX+wOLCveq/Xze94M=;
 b=MBKSun9jEGGDZyhB2mjS2SlrGjvA6v2jQsD6s0vfxD26oTJfKe51ReQqvAp4XHcxN6RDab+qN7Bg5ioUUjc2AaanCui6tBRA5tsXFCyY4orhKKdnDFnz6/MKCD2DwS/Q4fMA7uxAmAN6FY6nzDUgUMCELWZ3OLDu+SeibbSVILRWKu9ZEP9mvJQ3E1HOPcTSvQSeGuaPT/nVFB8qpkYRWKzfu4bH1Is1pyPAFRHgq3lSf7nMOjXvS38EVMXZxr7zadKoeEKW4d+HzSdZYgLiViQPn9+R8W3zjKut8Ch/DdMNVP6km0AhjYDgPUFk+lIYMv7uL5XGIBK7XiLxk0Rpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tYSlXRPFsDAcLjUod9C6N9ofZCX+wOLCveq/Xze94M=;
 b=lpH/zh0lf9OJNlYm0RxBIySKSfbHZbUQSv8b75Yxbax6rot7yp3lpe6IuhxOrc3SzMluhWrNmVHtXAMhMX8uOHMWZRA6bOYqodshZFbswOfLYPPBsIDyjQ1/lwf7xJctubHNQnBgbK8Fbe922UCYzCbcqR2d1FODMxYY5a75GjHhBBSVMLRwgqzkjmQ6PTYpfrdY5HyZvSdzyptyel4Nk7ulqPsXLobliFkuUNHBe++1rY9PF9iFMlyWYKd1A5VG93/iIYRDF5bTFeTT5GxQ9l3jDVQcmg+nOVxKnmH1EVXlYXQgUoIJ3jsTuz7mnVtZAmCZ5gjaHWxRdgizaTqs1Q==
Received: from MN2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:208:1a0::28)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 14:11:02 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::1c) by MN2PR07CA0018.outlook.office365.com
 (2603:10b6:208:1a0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 14:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 14:11:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:39 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:34 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/5] mlxsw: Adjust MTU value to hardware check
Date: Thu, 13 Jun 2024 16:07:55 +0200
Message-ID: <f3203c2477bb8ed18b1e79642fa3e3713e1e55bb.1718275854.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718275854.git.petrm@nvidia.com>
References: <cover.1718275854.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: d491395e-f247-48a0-af84-08dc8bb2a7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WrYsNJ1tUzbEISMkTQ0YhTHAGutC9lA+UP6icLMLPz+iKnBAZrvSMQAS02gZ?=
 =?us-ascii?Q?8Xjw93wws8b2c0Lcq6vuWYCKom0wZMlsjdDZigfqFESM1HbCxOy0vWpvmPvE?=
 =?us-ascii?Q?okF2vdqFgJTWfX0g/62Dr/Gu0eatmmvqQoFV2qJi3gp23dbwq2o6Swf9Q7kj?=
 =?us-ascii?Q?JorxtEoFyth5LshkcOH/ocWeh/uusc9Fk4UvJqffbJCaefVKubSyx5msmObM?=
 =?us-ascii?Q?z226t9QcQl/VcM+nMrOeeLpAhIDoT/Y766yd7HUrbiRMoNvNPU7iCukJrMEa?=
 =?us-ascii?Q?jdiXVJ90tE+RrWqqcsbnqhTzQYeYJ5M1VErOWZhLdpwqbQ8LvvFBbBWaFzAZ?=
 =?us-ascii?Q?UF/3Mz+PRZEYMQh1+Wnasb1iOigCXeHQ3/2sY1M2e7zXX+qCWMruSIyOaLaz?=
 =?us-ascii?Q?H41mR4axDRba6rj3w/zTMZNL34mpe9Rxd6hUJ+UU6kWPMJJPXffg6fXWm6RT?=
 =?us-ascii?Q?4AVie8gANC1/cSvKqR/+pxxbOhacsweFo1xZ9x2wPSw8K9mxtn9MU94SwPir?=
 =?us-ascii?Q?b9jkgH5BE9oZC8jfSSCDLl1KVC1hjdYd3WhjMVcx1KfJ7O8U3ssMXeDAseWw?=
 =?us-ascii?Q?1sNNH8U+hzsni9oRTWhoTzPEF00jv6J3bA1BmMgjWCxsOFClNJP9YUMGf9cb?=
 =?us-ascii?Q?0uY6jn/FKsEe048hwPFxJs4qZsV+bW07YlUk94mMJZsxAsKnDgJoa4QOah9V?=
 =?us-ascii?Q?XTgq/KKc91YISomI3dH+rNaZ48Ctb/lPAr2OPp0CY0w/dutQy/lbA83UgQ8/?=
 =?us-ascii?Q?RFDmm1QHjd6PUFlmPLcEWnsQgoCUCxC+ysgFOQCSfPfGQEOB5Hcza7zB5T74?=
 =?us-ascii?Q?EYbKVq2aO+c2XrYrT0xwLosRkcJ/KSwrUWLowpoqXMDe5F55cZKeK5KWc4qm?=
 =?us-ascii?Q?XFWCFZrnR35NyIQyNx0M2UkMLbmdaIKTot8QO5P4xeSOwi2FlXbc18xMa8Cb?=
 =?us-ascii?Q?nQii7KG3KOjY75Gx1PxltLZd7Zp3P4T1NTFAFv39WifejNqNE9vV+wj9/crn?=
 =?us-ascii?Q?drcjUP+KnwG+6QMpK7PHO28sW0WG8tQTtohgmFnrHEfTMTrNAPWl1eqbWj0s?=
 =?us-ascii?Q?FpQfNfisF341Mwu8sITdHdkqsNQK6klBpTx5UjCYhbPeaGVVH5MlfqoKR1Rk?=
 =?us-ascii?Q?+rBR6lk1Seq6sQXgZl9c+/Af+VzDcLWdUeK4p81Wc/NvBSwSHupYp15nOiSq?=
 =?us-ascii?Q?8Kpmsy21LUKZKVyzKoy7OjWufNjq2toRf5A0WSMYYy5ObO7j5Qo0r9MiqVrB?=
 =?us-ascii?Q?+2OrIVzT373T/ZRK86kUwd8c17N7d21yUGedy9DBkyy6AB8pAZyx2tHMwpZC?=
 =?us-ascii?Q?d2L+XvI2C5rZ1dmD/SZ7bK4HjfK4b97WsNG0kl+zBpM23DCCF1uAIObgB+ti?=
 =?us-ascii?Q?rWhiTyKj+cG/8XvY1LFgt3CdksRv8wSzFONaC5OA4DTFdSwjog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:11:01.3647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d491395e-f247-48a0-af84-08dc8bb2a7d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254

From: Amit Cohen <amcohen@nvidia.com>

Ethernet frame consists of - Ethernet header, payload, FCS. The MTU value
which is used by user is the size of the payload, which means that when
user sets MTU to X, the total frame size will be larger due to the addition
of the Ethernet header and FCS.

Spectrum ASICs take into account Ethernet header and FCS as part of packet
size for MTU check. Adjust MTU value when user sets MTU, to configure the
MTU size which is required by hardware. The Tx header length which was used
by the driver is not relevant for such calculation, take into account
Ethernet header (with VLAN extension) and FCS.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/port.h     | 1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/port.h b/drivers/net/ethernet/mellanox/mlxsw/port.h
index aa309615eff3..0a73b1a4526e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/port.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/port.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 
 #define MLXSW_PORT_MAX_MTU		(10 * 1024)
+#define MLXSW_PORT_ETH_FRAME_HDR	(ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
 
 #define MLXSW_PORT_DEFAULT_VID		1
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 030ed71f945d..879daa18ccca 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -425,7 +425,7 @@ static int mlxsw_sp_port_mtu_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 mtu)
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 	char pmtu_pl[MLXSW_REG_PMTU_LEN];
 
-	mtu += MLXSW_TXHDR_LEN + ETH_HLEN;
+	mtu += MLXSW_PORT_ETH_FRAME_HDR;
 	if (mtu > mlxsw_sp_port->max_mtu)
 		return -EINVAL;
 
-- 
2.45.0


