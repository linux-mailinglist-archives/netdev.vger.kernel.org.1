Return-Path: <netdev+bounces-249780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96BD1DC05
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB87D3012BF6
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5737F8DC;
	Wed, 14 Jan 2026 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hui2z470"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731A324B3A
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384585; cv=fail; b=QCNX7aHmFMrAQU7g1Llm+k67cVJ9dx7KOBEoz3cxnY8LczLTA9a76hZz7J9fML8z4Fvoc42xn6jdpWYMEkTF9mgSgs/t9GwnUA11n+7OjG/R3zz6+uLHZPkR9KzCtT3ROQDD+9WDZR1c7iW/o71B3beCJRS7NL/wqmX4gU7v7tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384585; c=relaxed/simple;
	bh=ATV//7ZhipOMV4NwHdwYmmgml2ymtF1ID/Q2Fsc4QXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+wOaRaAK81EHnT2KdKPShghlkNCCl57T7P2N8olmvzHIxf1vpKgFPSEb2nbihtZCxWIJmqEKb+QJ/eUv2kuz/OnP9aNWGoKPuNEc0VB1ohVYlOQIEdD2hd9F19DA3Oodr/howUh+4eXReznJDN2pvRqLzdHV1iewURIfiilsBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hui2z470; arc=fail smtp.client-ip=52.101.85.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3snjea+ej/n0HfM+r3U5MoMx9j1Z93wdu44L6nYVEzd5hvk89GEclqdbWdoRqQMig9nz3MQICerG8FGntNLSw0UkPwMAuk7MNGdPaZWOj9kxZpcIDnTTq/PqP5jrgfrVfT+Z6lY++wkDhL8ohobzWn1jcglBTykDpUkwfQvkbHauqAMQGtPDk8spx6j2M9lDA+3f+Q7UA0Dpd3vcFHBSa2XiJbRU4I0b/EnzPgaADVRXdJ2JQIpqIv2vYuOQWPBiUWF9adDFTLTi/kzs2h2bWCn5+3xHeH0IwXOjFuP2r3kxy5BO3MnrGSkvcM9l1OPuIL9rWKS47gscvKjb2GE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZTx9FwwpEyD0IondamR0MW5kMeCNp+JzQTKLbNUj/M=;
 b=QMO+irKXILkVe/DaJogEpl/R5if8XxJDO9+GOtkKyIQxDMh1OiHjXXIAat8oUFI1kmFbIdKiAm+96NqM1uepKcGUdhTchjgtj6zvxTdOyaJhAXEdrlB70L+Cklqridq9MFxz+n2HepcLDAdqgigLMke2JFAH84m+vHfZAmnjf9DaMIwSaUhg1HrY7Hrb9JWd5r1cy2NXXQtNVe2TkkrkY0W+MzvDVKLj0sJ3CUmEu7EeNR9fxBqUCQ19kYmuChF4DIHGcXowXBCLmDN8fbiZVNfjtE9yOPz8DfwsO3H0IRL55bga/8gkBrA1VquzxBmMCRw1zaIuwSm77/M/sA8jWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZTx9FwwpEyD0IondamR0MW5kMeCNp+JzQTKLbNUj/M=;
 b=Hui2z470RtG0j+z23SLXzZVa4+Y4Y+l6XwtM6KX5TVx0wYJSPRMYPui2ztIlOScDTuDRI7E8qnol3qKUVk3EqoiVGp5GVPs4BmmhEfVa3KsgwghaKJ9v2NucM1h+Bmtk7YJ5/oY8WnmeqBMMlP3WpehrBYdD2qTrBj9IlqayeMvmWz9jJjg09YlDqFtwF9/Ai0xlxSanC7R7bFoyt+yYydzOfo4JsfazT1RX6lbjc/HLnHp2uhCD1QCGUQ/tnrRpfHc4bOXbSTwLIFh9WbcYatblJhe6uZ9S6BGRLiUGOiTGEmLenf1RYo31nLo+jDLkUee+6r6T9UYwVfNX7S7GOQ==
Received: from SA0PR11CA0126.namprd11.prod.outlook.com (2603:10b6:806:131::11)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 09:56:17 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::60) by SA0PR11CA0126.outlook.office365.com
 (2603:10b6:806:131::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:56:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:56:04 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:55:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 5/8] net: core: neighbour: Inline neigh_update_notify() calls
Date: Wed, 14 Jan 2026 10:54:48 +0100
Message-ID: <e1528224375ebd8789994668a286fb3105dbb2c4.1768225160.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768225160.git.petrm@nvidia.com>
References: <cover.1768225160.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc06288-e3e0-44c0-6022-08de53532972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5s51oYVsMOPbKEe7KnH3NLcrTN7sBcVkUSSZuaBu9DYn0Y5E6gtFYYO7YqLI?=
 =?us-ascii?Q?Hb74Nns1PniULkbkocc6X9WmQkAoaoMAwlK/SnhRqB51fMMONbQFesSH2Vj7?=
 =?us-ascii?Q?N/UKqAlfVHPPtzz+AE7X4C9QNh8YnEvuAaXW3VXwpYxSnLzCI035BjzWxjEq?=
 =?us-ascii?Q?Vano5Pz2Vn+Ir8/RzzK2jG6tJ3D1j+4UY467GGEbgU7U/atCZ7cQqo4Upezc?=
 =?us-ascii?Q?7++4ZrQgCWLwpvEga2wLKKElvL14bLInF72cspEqUUJ8Z4CKyhbKxVwphHbK?=
 =?us-ascii?Q?HEwgfbM6YnGsBDdejjQXohtWCYSRnJHOMb35XLz0HecMHo1GHaDBt8U7aMdx?=
 =?us-ascii?Q?peyBeYzCLQFoaLYdnhxBNCmrM4acI6QgfGf45F+h6J90qfmeP46ebpDMshuk?=
 =?us-ascii?Q?LBcFCKvksnRhbJmFQ3hfGYHE/MIgwcsSk20X8yd3UClYKnWcupmm+J8qHhNT?=
 =?us-ascii?Q?zpY9qDfA+vOgFRpYwkkqjKTtHAeKqQky6h/24RwfS39WzkgWx8k8lm8DjM4L?=
 =?us-ascii?Q?HAkKuga8k9fEKFGRmOZda5dK5a1wVmDQPqZc7oDRgRYIyOhw5OqS90ZsuVuS?=
 =?us-ascii?Q?Fsqk6BBeSTGXIigkF3TpiPFYkUJUX51/Ycnr/Rkz7Urxu+GCkyh8jo4ql50O?=
 =?us-ascii?Q?7fSC1jr2ANKw3sfCVPyAWSn/ADprooSPb/j01MZkIrRI1WTlzNFJ1QbzOKMw?=
 =?us-ascii?Q?/n99H0IYz5YLZ165TGZ/WGiUAhxoNSQkUTGMoYypdtMw7Y4LWu6onMVPXQlS?=
 =?us-ascii?Q?AmaWrPbvW5cPL3Zt0vstpqUMjAQNasRZxBq21R/EBU/qbUrDzWqqolYlWWar?=
 =?us-ascii?Q?Juy1MfOYOAUEDNx9AxmP6Y5DOpzc5nO7qk1Sp+akGQSvWEHN9EoDfaJJ4tAm?=
 =?us-ascii?Q?j2xR8kHgy2HAvRsBvyQ8gwX/mvqawPVJfgYVTlJURaj9Zfzke+a6BmpcR/ob?=
 =?us-ascii?Q?Y6gWJDH4V2xPIyHQIjRxj8noBEuwYFSsEE9kawxk14gIsy95wY3O1jNdwgcw?=
 =?us-ascii?Q?UbxZ8FSnt21ue8bNUgesqn9/50Wqf3LWIyaBox3yV7+Safo9Gy5nrJ3VlUOw?=
 =?us-ascii?Q?FEJjv8LLIURWAxRnh+NtFgWe7gUU6jBLxvogLpZ7zG+CBswd86OGduu4EDY4?=
 =?us-ascii?Q?aAq9pAMsxvEVMlkEdip7FG/lFtwPZzHN/IuzTrR4dbIvbFB44ERkKvw7c7v/?=
 =?us-ascii?Q?ayAlGSrA+fUbtyo+9/+DCho6xCTrKSvQMPHPtXA5ohB2UPYz1GwN58eeEY9v?=
 =?us-ascii?Q?SivEVhf411xQJAuIMroF4uMdAl/iUxvFYFBFMKteldguIeDwqbMtz5B8n8z2?=
 =?us-ascii?Q?2Cog7eE2MEWsmHh9qetwXi0qewl6g3GInxrv0dzT6FrYIsZnOSp5Xx/JOBfD?=
 =?us-ascii?Q?GFcdLIvszho8viYLaPliskjbuTf7T4hxrsZo+ohAU06mMvEqM875hv9/BT9O?=
 =?us-ascii?Q?ocXHZeEkTTQVZAhn95tQhQNPGSDtVfYzi1I+54lThLbWhIVjlTzZL5oPSGVA?=
 =?us-ascii?Q?QoCEAq/FSmmHdd8A69611eUDYlhkZ1P98Bv76NryFvtXFovaRdFxbYMZj8nD?=
 =?us-ascii?Q?rIhLKBWhJHiSlpV77s4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:56:17.4458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc06288-e3e0-44c0-6022-08de53532972
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

The obvious idea behind the helper is to keep together the two bits that
should be done either both or neither: the internal notifier chain message,
and the netlink notification.

To make sure that the notification sent reflects the change being made, the
netlink message needs to be send inside the critical section where the
neighbor is changed. But for the notifier chain, there is no such need: the
listeners do not assume lock, and often in fact just schedule a delayed
work to act on the neighbor later. At least one in fact also takes the
neighbor lock. Therefore these two items have each different locking needs.

Now we could unlock inside the helper, but I find that error prone, and the
fact that the notification is conditional in the first place does not help
to make the call site obvious.

So in this patch, the helper is instead removed and the body, which is just
these two calls, inlined. That way we can use each notifier independently.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f3290385db68..e37db91c5339 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -52,7 +52,6 @@ do {						\
 
 static void neigh_timer_handler(struct timer_list *t);
 static void neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
-static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm);
 
@@ -1187,8 +1186,10 @@ static void neigh_timer_handler(struct timer_list *t)
 		write_unlock(&neigh->lock);
 	}
 
-	if (notify)
-		neigh_update_notify(neigh, 0);
+	if (notify) {
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
+		neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
+	}
 
 	trace_neigh_timer_handler(neigh, 0);
 
@@ -1520,8 +1521,12 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 		neigh_update_gc_list(neigh);
 	if (managed_update)
 		neigh_update_managed_list(neigh);
-	if (notify)
-		neigh_update_notify(neigh, nlmsg_pid);
+
+	if (notify) {
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
+		neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+	}
+
 	trace_neigh_update_done(neigh, err);
 	return err;
 }
@@ -2750,12 +2755,6 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 	return -EMSGSIZE;
 }
 
-static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid)
-{
-	call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-	neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
-}
-
 static bool neigh_master_filtered(struct net_device *dev, int master_idx)
 {
 	struct net_device *master;
-- 
2.51.1


