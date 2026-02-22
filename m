Return-Path: <netdev+bounces-259864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JdUOHDEmmlHiQMAu9opvQ
	(envelope-from <netdev+bounces-259864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:55:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2716EB89
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE217302768F
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FC020B80B;
	Sun, 22 Feb 2026 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F+WPGjgw"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774D1F4CA9;
	Sun, 22 Feb 2026 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750471; cv=fail; b=ievYppt3Q52Zulp9jtszAtvZg2fb0jxuaEQlXoq+lYvFysuwesRkITVpiD4PmxG4ZR3cbYpbqyjFqwbDbbfICDTpJfgilvpYLgWAYm7LPooAIJW+Op5GhEPGDahCFoPwojNavcEKODfdY1H0p7JtDoo5Fsa00FV5DHL7B862BNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750471; c=relaxed/simple;
	bh=M90T8kG61rgM+OSqLdYcv+h/dMD5KQJe0mzyJrWSRyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnmI5AGUpWq5WbTvbue2ShUO3oRlMv5hONCodlsxiE1lnNWcTjH75Z8bMGy5ygaD+TdZ1d3T5K6WMua5w/HMWIz2Nv7ZSx8KJU2IYZCi/THS02kr+h320osQbH3DQilDjE59wQWa/zRVShW5BQrGY42iA8U9PDK5F9KDPpzFBe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F+WPGjgw; arc=fail smtp.client-ip=40.107.209.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv5uGaCYkeX40lk6/SFVkCAq8TtJG8ciaZ16GuLjo4pMe0vBoRR3OAdksS6YEBqHmx9Ak/m1AmOrL47ZuLcjL77k3AZ+ULl0W8Ni8aF/Ac6whBYY74AU13xM/MAE7qPkfzR1uSC+rz8SYDNHfFtHR/SpMVe6EnfWeaPpSpeKgIFQsiKypyEHHyjMZ8iAwmX9ZVJ+BXGK0fTb5eRkjAwlVZTcpADLSL/XlmOPPw369uye12pwr0+V+eD9HeXfJsCAYQM+r0U52Jq6HnnTZF+zfEZLTg22qVJqbe09wlCKgW2uj4zzQXZFXeHdw8uTcV1N+ilh3HCptatH4KuMPAu4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8C4bnywWWWFG+xhK6FYIwkDjx37HOTkPj8s+PRtAAI=;
 b=t79u6YLA0wEahrDTIfzPC2KHSxEesKrr4ColdMsyfZp1GGUr3K5ZuYk8fvnJrfkfEBQZI8hVY5v5P13klhxE6S1RkT2mixG4yVrez2lRQYIUGZMCiBdbjIpNxq+CTyeReF25+6pax/3me0kJdLJIeYQz31Ku8Od1IXtHAkV+hYHRhaDbB3nbeimNE1xhlAf909oHusNIgRlvI3pNhcXuQaYUZtl/GjcOHjE1lJ7OgCeigs5916sSQJsgGdLrknQwPhPKk72qmOrRcRTn3/Kf9kerToi/eEHTiwedNq9+nF0Fi2TLyfB/eDvOk8zp5xhrsWI09oADxsxxGtoE/j7plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8C4bnywWWWFG+xhK6FYIwkDjx37HOTkPj8s+PRtAAI=;
 b=F+WPGjgwST+HjaMmX7aLAcpC8uLlrTr85GjZ0iWrY1Isyy2v6mpkiIRBIBkXo/z7aplLKYP2nKU9ReWxwTjTKS9uD0e3TqAGRbAkS1kUF7hyLCVrDO5/P+ZqF5uJQM423ycmlZqtyN98qpjKkWNjiJP6ZqHatBUjKnJixroubF3JEiYSkeYw7Y2Ho3vQ5X2SzDGxRAnoVeOfFJpvj9DAU+2RDjpl8zp8dO7d8p9VgrASM2ISRRrWxTw3Pvxqwc84Ixt9VLrrGg1jO8g//gVFnSIYdnwyoFCU8RuSkajALvB9YpXqRMpvk7dfOZtfLgcJxrcpY3sZYEzcnc96+47OIA==
Received: from DS7PR03CA0247.namprd03.prod.outlook.com (2603:10b6:5:3b3::12)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sun, 22 Feb
 2026 08:54:25 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::a7) by DS7PR03CA0247.outlook.office365.com
 (2603:10b6:5:3b3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Sun,
 22 Feb 2026 08:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 08:54:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 00:54:13 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 22 Feb 2026 00:54:09 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net 1/2] bridge: Check relevant per-VLAN options in VLAN range grouping
Date: Sun, 22 Feb 2026 10:53:37 +0200
Message-ID: <20260222085338.3143823-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222085338.3143823-1-danieller@nvidia.com>
References: <20260222085338.3143823-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c4ef4d-f083-41f1-8502-08de71effac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f0s1rzy6oQxnwnX+IdaX8KvSrktbnwOBLkYwiqiopAnHTJnkPm5nI9tOXgm5?=
 =?us-ascii?Q?TqDwnB2P6UFfbmYPaJA3s6tHFiqpTYgbzGwLSuBBWTiVZH4qwWWdSjocN3nM?=
 =?us-ascii?Q?3jdLqDJOR8YxjUw3oozZ4gGvII6/KDKBhUkpQw+I+wlYk+SZXQGgXA2/PuXo?=
 =?us-ascii?Q?xWi/0ezww0vz8mef3REZUxlmG1PrDVgiGotFsQIAH04bIVWqN1jOy9I9owBc?=
 =?us-ascii?Q?q0/b8RcnP/xD3s4abSp9Yh4MNNjhhrh8aIVkOfoiN7tlxH6A6A7TRcexHXIp?=
 =?us-ascii?Q?M18T/dDD9M41bUIbckWOuDn3CXYJ5EaE+PTRi0Z0Sv8EyTzRerT11D77C/Cz?=
 =?us-ascii?Q?LNKXQf4wxoj7aaV6CN5JTLbcpWZb9MsBduA/jFRNJeYG46B42lLGeeJmAkJ/?=
 =?us-ascii?Q?spdkduSKU1iFNSE2SBZRdAABUAXI4kmInionPRB2HZ+Smh0IB/gXJ9H747mt?=
 =?us-ascii?Q?R+9iuNux3CQw2/NvI/otj4f/jtAf1gXJIQuB6hmQbws9vsfnBXH/uBRMvVow?=
 =?us-ascii?Q?MsGEyPy+TNMpqDOwliD4EVj3m6w8RAYL/Hj++0zVxos/6JCbtVF5Enx+RNCx?=
 =?us-ascii?Q?TsOeo2yxUI++mN35kZ4EpFnNHYA6jZsuKN7+PXyHH1fFqsTdAt/iaYnBIv2N?=
 =?us-ascii?Q?7+vp7wkg3cazxrTF6NUOmXeOvANjTR7+03bs5cw1K1ZTGue2McLL5ky5xAFU?=
 =?us-ascii?Q?xISlMzqy4PCa8x8ryZG4XLn1OjwXAINiUuXJ+8B5aJGkMfKZgJk5zhQb37lO?=
 =?us-ascii?Q?LgpYVrbhYSnU9DQPwlPtqM35qgDX9FsV3yVQ/L27sXIBnFbzRLQMDQqsad92?=
 =?us-ascii?Q?UT3wC+yGH+8XR0RH+SFzPnWPPVUeVpT3meQzAD+IyB/1o7EpZ1T2D6nm3yd1?=
 =?us-ascii?Q?Y+LU1nv7Zdixe2RmJ7e7KpGtfEsc+iW/3eg3LhcLQLVJ+DqX6zTVSQKCZKKw?=
 =?us-ascii?Q?h+oakpibvpJlqtCODipxfmDKvLkJVEIuN+A8ez2EEVGWGBDLxlSn24A7oCZE?=
 =?us-ascii?Q?6CAzhyuQ6G/2T6jbwRqJsEHTxjZ7oIrqBbnhGTqmGTT5vBZnQeLAq4TW6ups?=
 =?us-ascii?Q?LPPaKqb2FdUUG0v/xHshyVAfxMPkQJ+gKR4XxNjT86OZL5aILt/9iiJ+BDjG?=
 =?us-ascii?Q?0wFnLudWsz0a0jHULHdBFQwgqWBhX5ISsd0y7dxQiwQGKdXa0ckL8SwiUMli?=
 =?us-ascii?Q?duYe6QZcT8ZpN3Y8dCXhLIZBt1Radx7DvJJZBix+iv5a0c5CEvqvCUhf2m5b?=
 =?us-ascii?Q?lYEFupa9ICEpPGuYbRnd14tgdOvjhf5Oo4XvW03StLAx69vVLFAOPgcNYjRv?=
 =?us-ascii?Q?QQs8nrqCFcNkw4nQcTNCWBOk+tfIv8/zu3OHBotjxrYBfSuBl3woXS8R6bOc?=
 =?us-ascii?Q?pnS2VJAjiJAI3qZqK/8ws5VoFFgEm1D7ntR//uahhCPbAhKCfUZDKcAwQ5+Q?=
 =?us-ascii?Q?IOCExboEBbprrynEa5/KX1zjN3AdKc7Z3yPNm/Rpn8GlXCl1z/GyseaR08hb?=
 =?us-ascii?Q?W2uTD7pR746ooRfZDAQuBErpLMoA7I4WOF6VNYGOBka3qAmc7ZHmsXDb51jk?=
 =?us-ascii?Q?bCl2pad2C8nPVkM7uu2AIR2tWWvEcmOvKnQna5BT29qskVG/kIzJmL7/bM+P?=
 =?us-ascii?Q?WjkobjDfa5sPGLqPePaP0P86ZXlWwyu8RTAvUeiWCM6wlIEczkjdnX2se/d3?=
 =?us-ascii?Q?QeQmPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N3g/wgoPIKycHOA7d0T9Zfm2noOlwb56qHfxU/AZixZHScXoD8U1htJj8nvyewR9WnEMgfTGRb54HNN4ZHAtzA9ce2ZPtNhmtl6voIxE73fFNGwZqxBMR1Ws1rAnZXyG3xNBuJ8XpAGgHIRr90UiX/wCNsYhueZP6bsS40EPejEzOmZRxzhFS370r+KYfmR8vjhIr6qZishbX0+RrMrfImRejnZkQOU4ROGkFvr79GTxb2C/U67J6MKo3jy3gfTmfY5q0L8luNJCd6pBflKgn3d5+zq2qUBFxjuv9sp4MtwfAMyZLBE51zJ6MknVxjSGJMGgYTG8NUepfKQj/EXcdNXlxp02TTULSbvC/1x4fpYfDW4VQzAsD3dKj0Li1/tYkJruhrn0Ty04ErDT3NJOp47tCAN79vmM6HRvI+exNAGzDfvpBz1QlXwfau8JzHtX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 08:54:24.9972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c4ef4d-f083-41f1-8502-08de71effac3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259864-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 78E2716EB89
X-Rspamd-Action: no action

The br_vlan_opts_eq_range() function determines if consecutive VLANs can
be grouped together in a range for compact netlink notifications. It
currently checks state, tunnel info, and multicast router configuration,
but misses two categories of per-VLAN options that affect the output:
1. User-visible priv_flags (neigh_suppress, mcast_enabled)
2. Port multicast context (mcast_max_groups, mcast_n_groups)

When VLANs have different settings for these options, they are incorrectly
grouped into ranges, causing netlink notifications to report only one
VLAN's settings for the entire range.

Fix by checking priv_flags equality, but only for flags that affect netlink
output (BR_VLFLAG_NEIGH_SUPPRESS_ENABLED and BR_VLFLAG_MCAST_ENABLED),
and comparing multicast context (mcast_max_groups and mcast_n_groups).

Example showing the bugs before the fix:

$ bridge vlan set vid 10 dev dummy1 neigh_suppress on
$ bridge vlan set vid 11 dev dummy1 neigh_suppress off
$ bridge -d vlan show dev dummy1
  port             vlan-id
  dummy1           10-11
                      ... neigh_suppress on

$ bridge vlan set vid 10 dev dummy1 mcast_max_groups 100
$ bridge vlan set vid 11 dev dummy1 mcast_max_groups 200
$ bridge -d vlan show dev dummy1
  port             vlan-id
  dummy1           10-11
                      ... mcast_max_groups 100

After the fix, VLANs 10 and 11 are shown as separate entries with their
correct individual settings.

Fixes: a1aee20d5db2 ("net: bridge: Add netlink knobs for number / maximum MDB entries")
Fixes: 83f6d600796c ("bridge: vlan: Allow setting VLAN neighbor suppression state")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_private.h      | 10 ++++++++++
 net/bridge/br_vlan_options.c | 26 +++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b9b2981c4841..9b55d38ea9ed 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1344,6 +1344,16 @@ br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
 	       true;
 }
 
+static inline bool
+br_multicast_port_ctx_options_equal(const struct net_bridge_mcast_port *pmctx1,
+				    const struct net_bridge_mcast_port *pmctx2)
+{
+	return br_multicast_ngroups_get(pmctx1) ==
+	       br_multicast_ngroups_get(pmctx2) &&
+	       br_multicast_ngroups_get_max(pmctx1) ==
+	       br_multicast_ngroups_get_max(pmctx2);
+}
+
 static inline bool
 br_multicast_ctx_matches_vlan_snooping(const struct net_bridge_mcast *brmctx)
 {
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 8fa89b04ee94..5514e1fc8d1f 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -43,9 +43,29 @@ bool br_vlan_opts_eq_range(const struct net_bridge_vlan *v_curr,
 	u8 range_mc_rtr = br_vlan_multicast_router(range_end);
 	u8 curr_mc_rtr = br_vlan_multicast_router(v_curr);
 
-	return v_curr->state == range_end->state &&
-	       __vlan_tun_can_enter_range(v_curr, range_end) &&
-	       curr_mc_rtr == range_mc_rtr;
+	if (v_curr->state != range_end->state)
+		return false;
+
+	if (!__vlan_tun_can_enter_range(v_curr, range_end))
+		return false;
+
+	if (curr_mc_rtr != range_mc_rtr)
+		return false;
+
+	/* Check user-visible priv_flags that affect output */
+	if ((v_curr->priv_flags ^ range_end->priv_flags) &
+	    (BR_VLFLAG_NEIGH_SUPPRESS_ENABLED | BR_VLFLAG_MCAST_ENABLED))
+		return false;
+
+#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
+	if (!br_vlan_is_master(v_curr) &&
+	    !br_multicast_port_ctx_vlan_disabled(&v_curr->port_mcast_ctx) &&
+	    !br_multicast_port_ctx_options_equal(&v_curr->port_mcast_ctx,
+						 &range_end->port_mcast_ctx))
+		return false;
+#endif
+
+	return true;
 }
 
 bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v,
-- 
2.51.0


