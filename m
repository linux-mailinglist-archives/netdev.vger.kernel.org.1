Return-Path: <netdev+bounces-249778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B87D1DBF5
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E30243008DE1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439CA3816F1;
	Wed, 14 Jan 2026 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXVumgE8"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8337F734
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384574; cv=fail; b=pV9y9CmPrFjtpUJxjSYezZeK0Gq0t3k6D9c3oXCF+AXusT7lAbeLxn6G9QvAkKDuoCXf12FHeSm6EOveGmJwCFBvL1/pTFDQM0flzKeUvD8zeL6bbR5+swjiPFpaScxa36Nik9DprI3E3RGw9NYitzH1PurvhiR4cv7EwT4uRus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384574; c=relaxed/simple;
	bh=8Goty9WWH1va0AERA+Y1VxFoLTlgffe9hy5yU5N7oxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwlLXlYZuvD+aqKtlbB8OicKxuOC8uLvi693/qaty6UegvWrhgGIG6crafemfBrsS5kTL5sUJA1WrdiQm2ohvH2ayqHCYrgzvt31K1W5aALbOCru0hZTM37ouzNY5n4vWwUzVaWewFjZGAxcU/vk8MiCctPlr0Wi6VcPRxnl0Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LXVumgE8; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aw53Z44U1KmxudaygCMQ9WHk6p4WevCZ7iymN134hEX8epovRR+C+HgP6y+nZTAXoIfzMInJjGU9EN5eQUSq1ylZF9y+JYYeJKPC4gfRf/2rq0cZdmjpRMpGz9PJ+O+051EjUZdv0unopD5bJfAsnbCiuXjO6GqHqEAx6DSYE1IVtHJ3u1BtBjeCPk0daXwHNI33xdmg31Q5iokM2XuvsMCdMWeRSrNCZsw4524J+mKD3fdmKBKBCkzvRqvyWvDJ9B0r9+ZLNdB7pkBrIg3X6+oX9x09T2NUN4Rhc1JhXKGk8O4cuMo9AhU8L/J2/A4j+qx/EwyzonJ49ZXZzm26zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps6qPvE3IR365MaWSfpmG1Yg4yOv9Ow6F4G4jm8S4cg=;
 b=OJMd51udw/0E1d1kdbW+eMrQvJBcQgv9DNDG02VwP96Wuardb/qYSsjldJ/mH6AHDM9eiR7XJqVEtCEBSfthtmtFaYKsZ7SM9ENIUUOvsimdaqgksOBN0Vm7xPrYHSM60cszA3D4uVGxyNtLbuUlGa78nc6/9eYOHVh7GIgt/MAtXWpwYRaIn7cDt2v+EeGJzsRFnYZ5+O8CRMTOfEJ7FYTZWXbdnQ2whDncjOeemNKD6hhPJ5OwZ0gU8ev6s9dNMH5YspTxjvvWTmbJt3iHfyTSD9Ibe+7j70fyn8bcxbI5/Bnn3fPj0IEBvmmij83sIffS6dKRnITQ8rVbkhBW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps6qPvE3IR365MaWSfpmG1Yg4yOv9Ow6F4G4jm8S4cg=;
 b=LXVumgE8v7J7rLu54+r20vLTjGFufXDv1KmW7588t6II9KqEXZWyoS705x19z7Y8iaJWhX5UiWIPF3xfwdOe77j98I/WYM7Z+iSr2Im2bgue2VtEJDSv9+vuxolOx7qhlM0lrvSHhtVv4cBAVG9lAFPosZBdZKpEa9Co84l6/dMK5v0TjqRMSpGq7dUXDLuXq/Qmu5bVO2ZHIMx5rhosMRwJqYtkYFm4cgpUJ8lT3DiPXNDGX0ZbEecZdfQqKXCdLTDo/tgzfqrXFWcnOQE55Yf66IBZjgQsRokgaW4592lnE8cxOkfvnUgnLzGj+fugh1WWLfXgtFRxAenjFGKkYQ==
Received: from SN7PR04CA0166.namprd04.prod.outlook.com (2603:10b6:806:125::21)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 09:56:08 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::5e) by SN7PR04CA0166.outlook.office365.com
 (2603:10b6:806:125::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 09:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:56:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:55:51 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:55:44 -0800
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
Subject: [PATCH net-next 3/8] net: core: neighbour: Extract ARP queue processing to a helper function
Date: Wed, 14 Jan 2026 10:54:46 +0100
Message-ID: <0792175c4a7593137530eb793c8e016930552010.1768225160.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b81d1be3-9a1f-41f0-d9e5-08de5353235b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7mbq91pkCymAhRL1W7W8TSVeHzmoebMDpzne72QCpt3PMOj0rCieS9qI5ZeS?=
 =?us-ascii?Q?r7FZLqMuBm7KYEjc7H8dwcXFFhtXypshFRPkgcULJc80+Jb6kVjAjiSf7uwT?=
 =?us-ascii?Q?04RsMLgz0n/dN/p5VpmdLzbIXhYxgBtIxsjuqEZF53c0DcpuV/IyO/YJ/E9C?=
 =?us-ascii?Q?DSQXgqpwAJ3x/wz/IppfrZBcyKsZnSNDgUErGII7WZYTcEsYw2O8g58zCiyw?=
 =?us-ascii?Q?LAqOPD8e1QxGvtYF+iQJEQ1HM3jZ7zbWxsicWFvk/5/plUFfz6HaYpeYssMO?=
 =?us-ascii?Q?iPzMbdEeAroM42Ag/3ILaQK3zQyBv98hUOmRDJ2QBMEKqvvBsCikOF7anDcN?=
 =?us-ascii?Q?r8itBl7OCI0arwkbJ0FXHmDzoDn6dsEeyMfIrqO7JLofqUvxTEdPFYZCvWQV?=
 =?us-ascii?Q?FPlYFLjYepJfV49wD/UBHFa9py4EpHk+tjy3vx1nTiZOxshiaJctmjWR0Hdf?=
 =?us-ascii?Q?OxkzVXGOfztLbEuUg6MHkq4XRqy7ERIJvGYIVBtsMnlYQ7ThiaHFclMrnfUt?=
 =?us-ascii?Q?rsD6hxdmTHgrjR7MjcMwb42wxx1h8vvXH3kpIloI2lbeufxOmCotSwGy+ih1?=
 =?us-ascii?Q?6IiNTcv4IdoOioHbkLtzeVcnPJ91Ry/k9UwlTFEOM9Oyu7+nF8jzMFWPTasM?=
 =?us-ascii?Q?1X4bx6X24qGpUC/PTguBk5AptV4S1ONGiHpXmrdk7TJKJyC1uTbxvQBaAB+T?=
 =?us-ascii?Q?3DFjximcS0D9OTy3V9wzUYOOcJXh+7owY72Rxe/9ninjgmZZTOSCGcpExcqX?=
 =?us-ascii?Q?p7l6S0fZRKST88HBgEkpuRB2mBd+yr1T8h9zA8Jq58/jGENDSke8xCW2WLFo?=
 =?us-ascii?Q?VI2iyWggDjGYltfBBYNq1ohpYOVwxS3qVnHFpubNKQqkOoXRxVi0NUtQXjuF?=
 =?us-ascii?Q?nYB5IB8TxKsGafo2ZdwGmVwQn6GSipRisGpy6i2Nr2mPxFsbssBF8Fd9ALls?=
 =?us-ascii?Q?IBgpNzzPA9v6cKuk939kprZPGpBgpTbRtDtzyfxOWtSVFrGSfUVSqq7gkF11?=
 =?us-ascii?Q?kbuZb5SWXvfXNSxX87JAoScnUdeu4MJz2IhXGPuTo8tQoJOTbdNq66YMQb/U?=
 =?us-ascii?Q?VuqchLCdiy7oudlhJOP9fmKU+dznyF2Mgllt+KnjVPUfZfpl75Ihy7g0+c1d?=
 =?us-ascii?Q?nRsPRTzq9A8Gwxf25l/1xZCM51oey9vPpabDThBKsc5ne7SwINsLl8G8Pr45?=
 =?us-ascii?Q?vtXmDctwpYe/0eKhgSMvsw2WXltuZ+MrIZCuxRdkB+4rIgVLZ2O5aLDEW5vc?=
 =?us-ascii?Q?z0yxAKZbTpJ7XJxphRZVrEUw0g+El3vrvhswY+hYRSPSlO60D8E6kELAVv3S?=
 =?us-ascii?Q?gP06EI/A+ddctwibm9lwybT38Qa3o5ldQMAIKu0t58mT7WyjJgb71fIyZBtM?=
 =?us-ascii?Q?C7bJq5zknK18XqOgCGEAp4IMSCmr9/Z+q3mCq8kYlwbIECdWylh3pZYRe7QV?=
 =?us-ascii?Q?fKSzo0pcAvAeuCEuiwdInnCEX96d4GF3stRn5rx2+UrK5eSxnbDgkaPLeIaR?=
 =?us-ascii?Q?AWh1d0IkTgpR3fs75SC2k/ZiqLXW5l3KBDEnd8pzivqD32N5buDMX/K6nq4L?=
 =?us-ascii?Q?rtUU3aVNFtpOS+pwm4g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:56:07.2311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81d1be3-9a1f-41f0-d9e5-08de5353235b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

In order to make manipulation with this bit of code clearer, extract it
to a helper function, neigh_update_process_arp_queue().

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 78 ++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5a56b787b5ec..efbfaaba0e0b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1302,6 +1302,47 @@ static void neigh_update_hhs(struct neighbour *neigh)
 	}
 }
 
+static void neigh_update_process_arp_queue(struct neighbour *neigh)
+	__releases(neigh->lock)
+	__acquires(neigh->lock)
+{
+	struct sk_buff *skb;
+
+	/* Again: avoid deadlock if something went wrong. */
+	while (neigh->nud_state & NUD_VALID &&
+	       (skb = __skb_dequeue(&neigh->arp_queue)) != NULL) {
+		struct dst_entry *dst = skb_dst(skb);
+		struct neighbour *n2, *n1 = neigh;
+
+		write_unlock_bh(&neigh->lock);
+
+		rcu_read_lock();
+
+		/* Why not just use 'neigh' as-is?  The problem is that
+		 * things such as shaper, eql, and sch_teql can end up
+		 * using alternative, different, neigh objects to output
+		 * the packet in the output path.  So what we need to do
+		 * here is re-lookup the top-level neigh in the path so
+		 * we can reinject the packet there.
+		 */
+		n2 = NULL;
+		if (dst &&
+		    READ_ONCE(dst->obsolete) != DST_OBSOLETE_DEAD) {
+			n2 = dst_neigh_lookup_skb(dst, skb);
+			if (n2)
+				n1 = n2;
+		}
+		READ_ONCE(n1->output)(n1, skb);
+		if (n2)
+			neigh_release(n2);
+		rcu_read_unlock();
+
+		write_lock_bh(&neigh->lock);
+	}
+	__skb_queue_purge(&neigh->arp_queue);
+	neigh->arp_queue_len_bytes = 0;
+}
+
 /* Generic update routine.
    -- lladdr is new lladdr or NULL, if it is not supplied.
    -- new    is new state.
@@ -1461,43 +1502,10 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 		neigh_connect(neigh);
 	else
 		neigh_suspect(neigh);
-	if (!(old & NUD_VALID)) {
-		struct sk_buff *skb;
 
-		/* Again: avoid dead loop if something went wrong */
+	if (!(old & NUD_VALID))
+		neigh_update_process_arp_queue(neigh);
 
-		while (neigh->nud_state & NUD_VALID &&
-		       (skb = __skb_dequeue(&neigh->arp_queue)) != NULL) {
-			struct dst_entry *dst = skb_dst(skb);
-			struct neighbour *n2, *n1 = neigh;
-			write_unlock_bh(&neigh->lock);
-
-			rcu_read_lock();
-
-			/* Why not just use 'neigh' as-is?  The problem is that
-			 * things such as shaper, eql, and sch_teql can end up
-			 * using alternative, different, neigh objects to output
-			 * the packet in the output path.  So what we need to do
-			 * here is re-lookup the top-level neigh in the path so
-			 * we can reinject the packet there.
-			 */
-			n2 = NULL;
-			if (dst &&
-			    READ_ONCE(dst->obsolete) != DST_OBSOLETE_DEAD) {
-				n2 = dst_neigh_lookup_skb(dst, skb);
-				if (n2)
-					n1 = n2;
-			}
-			READ_ONCE(n1->output)(n1, skb);
-			if (n2)
-				neigh_release(n2);
-			rcu_read_unlock();
-
-			write_lock_bh(&neigh->lock);
-		}
-		__skb_queue_purge(&neigh->arp_queue);
-		neigh->arp_queue_len_bytes = 0;
-	}
 out:
 	if (update_isrouter)
 		neigh_update_is_router(neigh, flags, &notify);
-- 
2.51.1


