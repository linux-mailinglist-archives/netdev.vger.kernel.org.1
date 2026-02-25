Return-Path: <netdev+bounces-260994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKlfNvwKn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:45:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F685198E89
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1733C31A60B6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F7B3B95FB;
	Wed, 25 Feb 2026 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AjG8iZNT"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611743B52EB;
	Wed, 25 Feb 2026 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030445; cv=fail; b=JihhBJephPyQ0Mf5Q2JTlDen22OMrZTqmurUZDYpIboQGXZx5mBVrVtgT6YL+/NHGe26wP1jWlI5jGJfUtSLOAsv1tFqXonKZ09PlfSSH0S8QYCBcgATgIYfaMTecKQVK3K4loAUIRb5bxoqKcotgcGQJLe8TSkaV1s2xvr4ONM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030445; c=relaxed/simple;
	bh=p7QHWj1n1eVx7yzCBH354UxaB21QnU/YgjxlVGmUzuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVCLLBIkZA7oTYomndT/D9H64VRXgRrGQxofLF6Db3mHSiWNJzOqELyC5YSUN6uodzWzY9ow+dLUnTLFttcAn1KLNDn5hQlFFCMajQT3WMQGnjdPkRBCjEE3tXUBRADG41z0Ef+QFo3krwBHaucefHdSkOc2k+Mxj8QhHDtERDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AjG8iZNT; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szOeVRUk/NKJmFUsrIWjPkouMQ0vEs2S5VwOuqcjUmuHNK7AJ2Tw7LXOcp176opdR7yt4m4cTNwskuP/1wkmO5gCk1pRi7JPB4TMyDshoGngsT6IPkYoi7exbWAHySCwoKJ9BnT4LRtvsCFeMcWNkAPYUXzQTAvF0AFBxCEK5vij9KatkfTeaWq8MSHOIEdITnLkaFTPpMlkg9ubo6NOnlCggMW12GPEaTFLX9wrQaMcEjBk0f2zK7Cg8DXoxAR4LIQXxe/WNaRZud5XOYHvn6gfRXYerjQ2uaa7EEc3O47csx60PyS5hVB4nZt0B1V/Ouz1qMU/fvhPO93K3sdt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBqUDBv4aMKu1Eq2U4nkkLO0WiklC2YECs5MMLV2JiE=;
 b=I1LnhHjh5Lf4L79p88f7opZVuzmEPJoQR4zTUU8mvNZzz3TciK++jUEyKq5OFk9UBsQnJk8i5FGsIuyKYNXarBjm3A6x4qazEpl/PMtsVNcbL4hG4zfK0ZtLscOUYDDebr7yi2deAPvIG4z19Faof4QcNgkVYrJK7gEymtypJ67j8mCVv/7P6BP5w/y6W7fpAk6UN8YKozRcla2RFytZX1GCHIWRpMMsmrwKYia2zM8/W7R1ntb6BWCfEYUPi3Z+2pdRXtaGc+rhlHEVTCMjBGyJMEBT6h47WBuu3GU6Yu9tcnCuHWodYUXvixVHvcfY6FmCMUrvpfPN+zqpotidwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBqUDBv4aMKu1Eq2U4nkkLO0WiklC2YECs5MMLV2JiE=;
 b=AjG8iZNT+oIvr5ZDoL38bKAif0CGCFeUe5q/Jv094HWB3Kh2mHNgk+9mSF4EDrszwSxzAYZDh/lQjrM+vu836sAzqcIPrDiFoyvYGWpueFfPpsBvCZX/t3RNEqt12yH6/AscsYrxBMUX+ILAP3/V4mLR1tzUsNW0e9Fawrph2RmeVg6nN4skOCdccso2x5zLj6CbclQMoLGClOrj2X4vySN0mVYbWyt8d2fB3Uy9tXhDeK3hOWiLM0nOLh4hajF9W8wxxgPdEiPalUyyT4FwTrJUN+eFKRHUzWpcyF9ZfUzVr/3s5/KGV1OW+BFoOnnjOgby3palBNRu54fYj7W7aA==
Received: from MN2PR04CA0030.namprd04.prod.outlook.com (2603:10b6:208:d4::43)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 14:40:40 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::82) by MN2PR04CA0030.outlook.office365.com
 (2603:10b6:208:d4::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 14:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 14:40:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 06:40:17 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Feb 2026 06:40:13 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net v2 1/2] bridge: Check relevant per-VLAN options in VLAN range grouping
Date: Wed, 25 Feb 2026 16:39:55 +0200
Message-ID: <20260225143956.3995415-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225143956.3995415-1-danieller@nvidia.com>
References: <20260225143956.3995415-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d201c68-e50e-4f63-6249-08de747bd8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	dROl9FMZH4piOHodokwO29MkCgL2UII+e1VFd47S4f2n6L+SKlx+YQrmHWL4kg2bwrZbOEdjTOkVuidUOEogl1Plz/hH3U+/V8Zrd2yGC4kuDpVDm5kb4062NNViR5ITh9BvUkgr+Z6mu4yXVXQnXOs1oGtEkzcla2lDlrwQn8E2X0HMRcapVC5liTwYHzaJcIIWDoK0J6OzCVaj883ja1l2EzSPE/nwpnOIwNjB+c2iDi39pN8nMU/tYKLHo6enPjcWe522LlHAlU4Ke2zHihKNlG4DQ9Du/UcKzWgtC7vkXZp5LuvDSiZv5y1hDiPQSqGEzeIKq5AsL2i9icLFu3/pWgIxe89wxyWQUG5au4YkogLQ9kPMy0qB7LYQFoszZXExFa7t3/aEUTrgVYm0NPhMMS5ugCdhpzt0x0336ut1oHqIffkT5Po2Q2gBPAg19yKX0A06nLelmPIIfQX1uBvJpCXMXy8Cu5mpWHpdxw0hWwB2yH+I90Z3dsbK9CqS6CLeRC+DPxDjYZJxXzNBKcTN3HVleEj+fF9eqmrVK8ikoEsU9W0JgDdTXX8fsjiTf6zBjEe0DvN+J2oCZ8bjuuWh8Z+vgtAt17mUbaV06GHjVlyedhHqpN+TvXctGRn2fT4D5P7GCwFb/eKGX4ffLoAlTSA0LD9ZPCMH/Dbt/6h1rSvsfO87tBf8d0G6eW6QVrQctizw1N3jrTLVjjtMjIELsUrSJB/6NsaOK5JErzgblif7AlKoi/Knl3ktB1zbeswqO07iQzf728u7HbZwlVsWCcl79ywxDf7T42FJ/DyWdF4b4RJcRrkk61uI6J/KvEJ9iAdl0gRk5gfeXozYiA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y6ubcSoeqwR+7Ig2o0ABM7aNhwsd6ZIOAPqY2ioDXSGCcRGrwR629ZKKU6yIIZnD6DxsrNSNW4fQ2MD4sqzBr3agN8JqDE1PgjqD5KY7TPCzR9X8whNOzIqj5pRhX4ac9MPqMoyB45cJGeD2YMrriGyIKZ3gz7m1SbzEoiMyuSzap+pcRNlAEHtXO90ttuRUDQ1XuFWb3N5bNzWq60XTF2ZR5kXqVJhes93iufORsbYy96w6ZGVeQHMflM3wsjdHmmC0oddN22GKOCExxDDeOXrl2zfJJyKWBSZJkyMc47ZiOspICs86zgpITSWl7vzo3fuScV782qw8EPGFEKx9FDdbkMeGrenswbdDyLv5piDH+2dCah31lFwYb1iqlZhSpxqrYVrWFUhxmA8V4Tab24MEDJNGXhMk5vPTvk+xYvc5bseQnYWBSfnVcphB1F78
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:40:40.0793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d201c68-e50e-4f63-6249-08de747bd8f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
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
	TAGGED_FROM(0.00)[bounces-260994-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,blackwall.org:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3F685198E89
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
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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


