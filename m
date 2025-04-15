Return-Path: <netdev+bounces-182748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F044A89D3E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74F918951ED
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB02951CB;
	Tue, 15 Apr 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k2tTRmFK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B092951B1
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719145; cv=fail; b=LAnUsYLXMXxvLz29FC4PlBercJO9LapwSDJr7oVpsapaO9nHxU54di48QJDdx1jw73ZuILALH630CD/gjUzzXrVlCMwegGMaMim9ctKPKdvaWG9wCqhE1o288EEQa8ExDj8Cbpie3zjDj3nSbxZiudVNxHQOQi+5do77GICFl2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719145; c=relaxed/simple;
	bh=Q7QguSIgZFL7fzBUCRqYhINZ4zmEmbEaPsyzmK113q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrP0MMawIKP8sBrUnpT7VOLQx0Ju8ppBAb3QL7ykjM+G7vnvqnfV7uj6GrmArZmGyQocaq7ERodHabu+h1GuuMgwuigphHtKNZgsE6d1vbIj+4b4ABSi2tGqhdvVHgnXlZ8jNG09bdsuU9zg3prRMDBQ96J2fySrSaFNwhxh92E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k2tTRmFK; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMaQHdkRH34zXc+60Zw4BF8/WdnROdrfaULVH4I5Xk8LEQshY/SDwld41lg8TEwkFDy/53zXonR83tmkTZbXqBlITirGcL8ISvyzG0pGQNmTwr1VUkrY5TXXEw6UFgRTR+z2M7XMfQxffRAeEszhjpoKzjuYeGqRh4vOAiJgmPWpFWQF61ALnJWzTJDSLQGmeSG7ZEzTl/um2gXnoCuhbWmJbu3sdPT9k7uW2tEJ4ysjLT4CLkRfcKePGZy3WIians++jEdxPtXjBt6qH0L8y2aXuKUc2g+gnNob1qA/BKdtm8fXxEX8Ff1mvdsRsI2MLOH5p1QIsrOQNp8UG7EjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/NBF1zADAugI+NaFwKil80Q5zeplYf8phLCudmlod0=;
 b=chEX5IoP/A2eiWHYed74G+0gzT+1sdSYJYj4m8t7jtbgKRm+RS8z/e2kFlDKyZg5qMeB56Osk4riw/k80EghrZ6+SY3y9uzAWm9bOAh5X3gZdYRmq+LdwPq/txWYHylyiET+HirnAEwXm7BitZFPznK5CNlqmPbZcJzzXAUeq54dl3yFSJo14RXHgxMezo3fQHLdEY3V6S/HKp06kz7+/TQKj/BpVs+J4027BT6xhQPKGKwsNFHGHb1dSBWM8Qjyf6KAe9jTczRXz3G4ifGYjL8pKxwYACnw2LxWa3hXOhxD0fjbpNGjIX/5OFWaGWMv0w8yfaIRptl43m1TNmPXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/NBF1zADAugI+NaFwKil80Q5zeplYf8phLCudmlod0=;
 b=k2tTRmFKF1/rShO3ul6E9AP6zZ3KspuxXMYJEbjL5ihbrMB/nGfzvYmn9QPUy2e7HtFrQFbRA0vSpWT0xresBO6i9i1L9LU8+Yk3tHLEY0LvFW9JYczHGIGNLvKK5SO65VWRLfFGQMgdIMOzpxxYh2NsZk5YODEeKwtZbnP5CItMo8ZuLbABPqt1Vjok8c2i521J5Vjtv7Jo+XEhReX5ZYPn19lrmmka0B//MCBiCJsLXUukmiiyhgyF847kV2Tu+iJnjfLJPaUrEhx24VqTn9HQFDLERlz54JDJM3R86GYAe6La4UZ7+/VRt7OKTGbCstqOuoo+aTTxrO3/PsUlpQ==
Received: from PH0PR07CA0096.namprd07.prod.outlook.com (2603:10b6:510:4::11)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 12:12:19 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::82) by PH0PR07CA0096.outlook.office365.com
 (2603:10b6:510:4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 12:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:05 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:01 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 01/15] vxlan: Add RCU read-side critical sections in the Tx path
Date: Tue, 15 Apr 2025 15:11:29 +0300
Message-ID: <20250415121143.345227-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: a955a9cc-324c-4171-a0c8-08dd7c16c50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A+3lyOyfbOgW8qyuAQ4LtiiWI2G3Uu4EppclIa/ehHuyRV8JuiBBkDfRUxFO?=
 =?us-ascii?Q?a2dsRd8HzzTw4o8iDmdnYRa2rAVE1xBM1h9VaqknjsFdHzSu/GGeDdkk9P4z?=
 =?us-ascii?Q?XM1ajCUA1yPNOJbqMLQMFKaccs8sbz3ai6LidOFqAqbY8y13zIPJbEDGKcpZ?=
 =?us-ascii?Q?V/78BF8NryHCQxu0E5d0KKv6gRR+a+7THTLRwywK6Uy+g55bmO4WoTayA50W?=
 =?us-ascii?Q?dv+AJ6TE1b8IID7280nKwqN7pOZ15qfp+5adFrKqHAL92z/LeV8Ky56pq7hY?=
 =?us-ascii?Q?a2tk0xLul0Q4rvSwi8gHuNcxRMTq23WViCAczB/nNdk67Vs6itldzpeyuPK9?=
 =?us-ascii?Q?bcOHlNC7pfXRzxisynwqrMgs28eGhEkv1iJw3hX7qdE79XaYSOkAMK6R4IpL?=
 =?us-ascii?Q?59N1M9nHxSmyxki25iGIH5aULHgikfdCGaJKqu+CnELfwgolymrpGfgB+Lye?=
 =?us-ascii?Q?1ARB2TB/4qgGspyymepbZsooWsSCTJKla7pOyW9soTueoxCzekfgFK/rNFlk?=
 =?us-ascii?Q?7OY/Q92sX/d1kE82NH1s2D9n9ju8AolORyUfN7XARED/uvQYatJUK+d5q7N3?=
 =?us-ascii?Q?rI1mnv9Kvp69k0TjmIUn7FRvrosuRXTfMKdwlbLMFoAK70F9iykCGhM2Y0/x?=
 =?us-ascii?Q?7PZSusRbOGleXS07AqZ0GjFi4iKWb5vV2yRv3har7JzQ4S+TqudcZCv+mEij?=
 =?us-ascii?Q?DNo5lpCUewgbGzRAbz6yfXWGq3Mc2My4cwmWfKaM4AnCfLrKuXes0Fkkz69b?=
 =?us-ascii?Q?U56c+JO4ovchexFLqTg8CAGXp0Hdt8+hxMR30/7lnxai0Pddf0d15atORZHI?=
 =?us-ascii?Q?2PVUB+f2rIGVPKBJNvOdAVyDVDpiYgLC3tSjfGP262598qrD502awvwPcdvi?=
 =?us-ascii?Q?er7IJNpR4NdxDoh63x5pq5yizOq1DGvJXmZew2paCZgeCXpapiijYhglPP/6?=
 =?us-ascii?Q?Ney/4ozfwExY2O7w4gQ9GdfRb3GhsNHc6ZpR3GOhUWk9Ga8J248UJRIYIuch?=
 =?us-ascii?Q?kdDX4nSuUwn4eFCuRArT4LCUUl5J06NAhaapm/gJJiK5s5vDAlFDQDJTlW9v?=
 =?us-ascii?Q?jJKPSVrXDHm7uWxs6I7JTozIziFRuZBnROMUIynp2LXPW4bPGjqzI0Y4MaLI?=
 =?us-ascii?Q?EnMx9Ee5B/BPns+bZUrvw6kCA7IwcdyOl8Q0pEPlTdGLPdEguPo0xII0nZie?=
 =?us-ascii?Q?V5ZyWxOCQJk7Nid0S2CAv979dkY+ksaqoA95UT0VUjPuTvlg5I87SFZePlE6?=
 =?us-ascii?Q?aTKMVCH17IDPcxecy18ELe3thoIk5jvEoDEtipVGALT90IHJr1nsVwl7xfeT?=
 =?us-ascii?Q?tLlmREBeIFoPtIh5IMboiXJAsHsE8eg0iyYnzPi5kh+tBYlxSLLvBO7BQwoZ?=
 =?us-ascii?Q?RBG+9y/6s3/dMdFlPb7Spms3fNcb4Y81AK11sE2H4e/eW7DugroNkQflx6Hi?=
 =?us-ascii?Q?cD/UK1jriPysEUxd/PFmpqBV2GeNaz9icxp33uxoUwGRJygFsmrAeuZI9NBx?=
 =?us-ascii?Q?lNvWljtBAXFKKMt3VR+L7DH+RN+svRQ1RcHR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:19.2332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a955a9cc-324c-4171-a0c8-08dd7c16c50f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

The Tx path does not run from an RCU read-side critical section which
makes the current lockless accesses to FDB entries invalid. As far as I
am aware, this has not been a problem in practice, but traces will be
generated once we transition the FDB lookup to rhashtable_lookup().

Add rcu_read_{lock,unlock}() around the handling of FDB entries in the
Tx path. Remove the RCU read-side critical section from vxlan_xmit_nh()
as now the function is always called from an RCU read-side critical
section.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 56aee539c235..7872b85e890e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1916,12 +1916,15 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
+		rcu_read_lock();
 		f = vxlan_find_mac(vxlan, n->ha, vni);
 		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
 			/* bridge-local neighbor */
 			neigh_release(n);
+			rcu_read_unlock();
 			goto out;
 		}
+		rcu_read_unlock();
 
 		reply = arp_create(ARPOP_REPLY, ETH_P_ARP, sip, dev, tip, sha,
 				n->ha, sha);
@@ -2648,14 +2651,10 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	memset(&nh_rdst, 0, sizeof(struct vxlan_rdst));
 	hash = skb_get_hash(skb);
 
-	rcu_read_lock();
 	nh = rcu_dereference(f->nh);
-	if (!nh) {
-		rcu_read_unlock();
+	if (!nh)
 		goto drop;
-	}
 	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
-	rcu_read_unlock();
 
 	if (likely(do_xmit))
 		vxlan_xmit_one(skb, dev, vni, &nh_rdst, did_rsc);
@@ -2782,6 +2781,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	eth = eth_hdr(skb);
+	rcu_read_lock();
 	f = vxlan_find_mac(vxlan, eth->h_dest, vni);
 	did_rsc = false;
 
@@ -2804,7 +2804,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
 			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
-			return NETDEV_TX_OK;
+			goto out;
 		}
 	}
 
@@ -2829,6 +2829,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 	}
 
+out:
+	rcu_read_unlock();
 	return NETDEV_TX_OK;
 }
 
-- 
2.49.0


