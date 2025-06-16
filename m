Return-Path: <netdev+bounces-198059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E833ADB1D8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD4716A836
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2FD2F3624;
	Mon, 16 Jun 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j6+pd5qx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21002DBF41
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080383; cv=fail; b=MoIbo/SCbGViSwi3CfSeqc5EMqyJ+XtPKJtV5bnilPVCfI28pP2qRiyB5a8SUCEHfLhPgdtCJ3xHoymVL7COYHmcr5hNReuz8Z53h8Z8tSdYMYfHmZo4zb1o22cRYBvq7AMqRicoDUgiiX3vsNAUI2+kDxbb0g+ojVgg+PedLAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080383; c=relaxed/simple;
	bh=aMmhvA4KvPo+jyvsoZANrv5aXuaW0qlUD8T0lTJ4UpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwDIIMLLQiP/4mIeIF98zNEVLjR8c7yeoXm5MiFo5K6q8BP9XVOWrHHx/XKYU2BYqAkYw82OEF/sW3T5jMScl0sIbGI4qNRib4Gpx+cU6Uk5iAURKPtIhUwopTs/zZspANlW3zDpLR1WU91DZaGhc52KrcZul8JiXMvxxMKyE0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j6+pd5qx; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mq2K+7Q9rdAGCcZ7b3L1ok5KmYo9qQ841zQz/+P4Ba5HnK8lIjsoKIVfM+T/Nvq0sqa1i3r2mb0xvZ4kW7jpnoXVxNl68J1iLAHvvVyi7Wp0QfAf3TR895cePpTapaJ9p9dPUX6gyFkptbWtXaN4py82fyF/ar55+k2Fxm/OOKG/WjYvzk1lUok0vE5wLK2lMnJ5dxr4t9tsr58UuTkC7ZVeKrkivBgUFEL4kbONKk3uqz5taYX5+zYbocpPw/mWx7tWL9n3iKMnpWl08A1Sv5DIiv26H1JE+kLRCqjOquIOzKKkKpkXCxdTVfpzVdeqDZoxEiWRzP6tOKUO3yvOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3w1rAcuNqv+qWvemP7v5trz6l1Sx/mc+a3t1WeU80o=;
 b=SPl3Q2IXxv2bvXx9z5+5uNcp+pyUsaMCFighfCWc/2IrtKebdOGcW2HsgcojWgdFlPySJ0DyhJjmhTgK2MFmTcSFrOqSwrLKt3wf7ORrwyBskIY09GojxiyhjnkhtFsjmy0uLK0dJ+RNruoQzuHx3DITRVXEmUCGJXjuAAo3CziwZ3id+QCGFaTcdaGw3YnoZ/D5AS4dcdTU5PqTHv6WXp0Pfaq2bEojVGwhHFj9YAmxtlYz8YLr1s+Pu3vBiTZv7XUiLtQUn8oCWibd35Zhq/XAZ7hxCOb/POwN8mCSAlXqA8kMivWIc5/DqEspNYHELUaFc0KcdV0rGbezSNF9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3w1rAcuNqv+qWvemP7v5trz6l1Sx/mc+a3t1WeU80o=;
 b=j6+pd5qxtGyj8BwMKsuFSdatX/l/X2AUtraZCASCh/kDe2P9wFzHWwqfElvIL5O2p2zlwg4CL1+VXpB60Wsy5UgDy95abxAF+OiBv5gO32KEMNNUEAiC9Jmvl1T/+UsLe3NQpzJNtZy5KOv/xbFSvGRHJ/fEhl6G/WbWx0Dl0O2YHiTHMUvyujS/PSVU147eEM54QSJQyZPNf038Qao5V0K+YcLAs4pecjaIzd7XEluH4OD1kw3B9T01Q3C9XOfNZY9/G6kkrXPJso4gYbrgtZTEglFOUniCg2xPAdF003Ot4vnhFmR4WMRErv1r9uh1yq6ofsFXZ3CpqkocCS/lXQ==
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 13:26:18 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::ca) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Mon,
 16 Jun 2025 13:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 13:26:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 06:26:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 06:26:00 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 16
 Jun 2025 06:25:58 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next v2 1/3] net: vlan: Make is_vlan_dev() a stub when VLAN is not configured
Date: Mon, 16 Jun 2025 16:26:24 +0300
Message-ID: <20250616132626.1749331-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250616132626.1749331-1-gal@nvidia.com>
References: <20250616132626.1749331-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d962480-ad82-43d7-d5ea-08ddacd96004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oYcpn+kN9e24FyIZWbJHDcMT/3HSOcqPBq8BXZs58eHk6GgZksCy5zaR7Cjr?=
 =?us-ascii?Q?ataNdquGwMTR+ee3O5m/SwSp4XkdnBe/ykwJ2XvtHdLcSgEFVtxHMfSffisj?=
 =?us-ascii?Q?QjMNEk4nuTpydOcp85XNIDr2qs5ZjAdVlpbc1whvXP/UPnE/EB+VuREc+Dg+?=
 =?us-ascii?Q?2ofNSEF+8XlxrKPV8SJnVeaqE+O4kDe4iJnbtjboDrwMhtCsjT0bkEZ8Xict?=
 =?us-ascii?Q?uj5kDwdXZ2j6WopyhKOgh+CZKxWV4GZzEBVoR9t/NaumHpnCVnYZhnyOjjnh?=
 =?us-ascii?Q?W0B8J9FC2SOethMWo/cu92A+tio8srlZIeDkU1gqXiex5gCuQu151JzvOYNY?=
 =?us-ascii?Q?qc+U5rlfaAeVworC5XaQ6f8FVhhDTSP/fUII9h3v2oyx/3pg3mHTveCNbWOT?=
 =?us-ascii?Q?utuUdQI5lNWOzN5xl/dleC7ds+thC7toxsTozYTcxL+htvDPxqNIgRvDXD94?=
 =?us-ascii?Q?X5rwEWJHjsYDlxrmrNOkhIN2HIvHICYfqoqS44e5opOfibZscg5yOWdHbfNz?=
 =?us-ascii?Q?7J4vY4/qHgkte0ienHaQySTLvKDt1Vd3HmbSlFfxGfrSHiFxtrroTEaHogDm?=
 =?us-ascii?Q?PcKrX+5zap9s2si90oBmUD2e9pV+RwEf/tId4KoYdFCPEJiOcFSvSUy3NpET?=
 =?us-ascii?Q?FyoZPDCksoG5vbDn+LaNmO9myJYn4YTDfCyxZfu2s2KmhuKEibviPmpG3rH4?=
 =?us-ascii?Q?zDKweU3upqbFilFulB2pWymvYOAM5A6YZ79wmBemdAFlSkiu7cxwrwJzoZu9?=
 =?us-ascii?Q?8tmDHhWdbIoja5fA692eSR/GHgqcGs5j+qIaJ1NfNMRJzZuOKEm6P78VYY2H?=
 =?us-ascii?Q?dDHwNzt35YowapJS1RnorbQXrfk4Wof8cuIypSn0+cTnmGxXWRU6IWptV6qm?=
 =?us-ascii?Q?J5jIBzHAlXfjaqtN1tGl7pl+7xzwa6ts2Bgu3iDN322UCZnSXvXZO4iKXo5O?=
 =?us-ascii?Q?Zke6l21ep2JIx4xlliMlj0y+ezpvULYa1yXn8si2Z/S+j0S3NNCqlZckuHA1?=
 =?us-ascii?Q?QHXlaheGyeLafY1H79p+cjAnwUY/QBwsqZL7ooYEJe1JO3bpfBx3hU8Dhcpn?=
 =?us-ascii?Q?dBuM+/TWUtp1h1bfONylKAfxZsJTKfzE2C8eNn5dgTVKL4uNo/3HD8iVAQgx?=
 =?us-ascii?Q?xzn9Zj1gJLe0CJGl6KIypqycf1DnCUIvpvithhMuVf6mw+sAMr2fAQPxEd+N?=
 =?us-ascii?Q?dO30VeYYKKpX5c7LXraE7HjP9jMyX9w1o4kA+hapiE0ikqKKvr2k+UW2nG13?=
 =?us-ascii?Q?vlwHohKESKjA5aMq4M62lrGrRGwk9ffAJUiuQLyYcY0bMjnI4tdOCWgxnz20?=
 =?us-ascii?Q?zQyKFzDw43HftUzqJkvtrAkgWlJFyvHToO/X2DYaTX9XniSXYAx/ObGZ3BuP?=
 =?us-ascii?Q?2QE9oxorJUe+WbCo122VGnCZIYL3vpY6IxIcrul4KR7wXZ/394SWoKUBacVV?=
 =?us-ascii?Q?XppSU7IzJ755e1b3dYCzhc8KpnDqc9dlrXKCZx/KkBK3TSWdPOap380k0L27?=
 =?us-ascii?Q?0XsbjYGdj0KuuGt0h5Yr3TM3fjNipa7PJu7S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:26:17.3215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d962480-ad82-43d7-d5ea-08ddacd96004
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

Add a stub implementation of is_vlan_dev() that returns false when
VLAN support is not compiled in (CONFIG_VLAN_8021Q=n).

This allows us to compile-out VLAN-dependent dead code when it is not
needed.

This also resolves the following compilation error when:
* CONFIG_VLAN_8021Q=n
* CONFIG_OBJTOOL=y
* CONFIG_OBJTOOL_WERROR=y

drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.o: error: objtool: parse_mirred.isra.0+0x370: mlx5e_tc_act_vlan_add_push_action() missing __noreturn in .c/.h or NORETURN() in noreturns.h

The error occurs because objtool cannot determine that unreachable BUG()
(which doesn't return) calls in VLAN code paths are actually dead code
when VLAN support is disabled.

Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/linux/if_vlan.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 38456b42cdb5..618a973ff8ee 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -79,11 +79,6 @@ static inline struct vlan_ethhdr *skb_vlan_eth_hdr(const struct sk_buff *skb)
 /* found in socket.c */
 extern void vlan_ioctl_set(int (*hook)(struct net *, void __user *));
 
-static inline bool is_vlan_dev(const struct net_device *dev)
-{
-        return dev->priv_flags & IFF_802_1Q_VLAN;
-}
-
 #define skb_vlan_tag_present(__skb)	(!!(__skb)->vlan_all)
 #define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci)
 #define skb_vlan_tag_get_id(__skb)	((__skb)->vlan_tci & VLAN_VID_MASK)
@@ -200,6 +195,11 @@ struct vlan_dev_priv {
 #endif
 };
 
+static inline bool is_vlan_dev(const struct net_device *dev)
+{
+	return dev->priv_flags & IFF_802_1Q_VLAN;
+}
+
 static inline struct vlan_dev_priv *vlan_dev_priv(const struct net_device *dev)
 {
 	return netdev_priv(dev);
@@ -237,6 +237,11 @@ extern void vlan_vids_del_by_dev(struct net_device *dev,
 extern bool vlan_uses_dev(const struct net_device *dev);
 
 #else
+static inline bool is_vlan_dev(const struct net_device *dev)
+{
+	return false;
+}
+
 static inline struct net_device *
 __vlan_find_dev_deep_rcu(struct net_device *real_dev,
 		     __be16 vlan_proto, u16 vlan_id)
-- 
2.40.1


