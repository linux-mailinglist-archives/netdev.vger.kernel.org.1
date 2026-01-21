Return-Path: <netdev+bounces-252002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKpjC+QgcWmVeQAAu9opvQ
	(envelope-from <netdev+bounces-252002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:54:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E1E5B992
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EC19B44B15
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E65480967;
	Wed, 21 Jan 2026 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iPbc035F"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529444E05E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013889; cv=fail; b=hvZLaFdC2MdGjLk/6naBl3BWKJxomH0GJ+z8CcK7reWL/emF0tsSH03KWDff8d0rOiwRplTrk1O2JgZbXB/Pk6L0ZHyOZx7ZSWmvcEyEg2kHWQWtCbng0ISUTJlXdsmXh81fhjocdeUkuCNs/BrP2RGNNy5EgAt3h26xB6MSvgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013889; c=relaxed/simple;
	bh=khdjkT8s10xOkGN5tOFh+KFK9Oq9Ka1HNB2D8fdEccg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mg59lOPirl6g4HI0nhCUUQ4CTYmJGR1gfB7Ec0UrUw+7hOj7KQaUPYJXSqNp4eEWEjbsgGQxAPVt1I05jqcEM5fh17+lgRWnaVcf/aZg07SsbvLLivV3tdu63c1KvzVmyciZ7lxprRVEFa8HcNK6FsK3HPOAwYO8gW2AoEY0Haw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iPbc035F; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toQ9TKb9CSYMfzQ8TL11XUi3Zzmpa3XLOH9w8oJ66sxRLYzrqjWTeZZmP8luL6KdGSAyfeeafm/hxPaNbKRemadat8j8zAay8OuE7a4b6ULgUII4yCB8O9tkrIeRT1aHd0PMYcclkuvJsAxGlar0t3NIZ9E9acMtzjTdAKi9hMmnVxtbuDmlMtoMCT/SOyE5EqHlsanljdpAgGRoddrkHydk8UQYAlDrEHyvc8oB8v1HFbkhs7+JzF4uRlq1zWHtGebiSpaPRoN1vd0BvT5z/BkSK0wujKIRS+p4/NCFYRUBr1N2zv5IZNS/byJGm0gHvnxqjLQMiiGbXGjnjqjDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtpxslRqyfo90ewJCAuxa+W8I0XsjBso5w4dYwOvyao=;
 b=g6S6n0GZEBXoOwBbw0ADhyrdAqPqQ0pnUlMKK1/7R6vGIr5K/dabS5Lrd/nc7yW8QLUT6n5tiMdi6xbjnzZHU7NP229zf43P0iLPrAgaS4V37dUUVWjihEf6mFjBXTAJOkEQnylC/L0j4SamaMls7mWcAJVBBMU251Dk5ifYvVq07jSs6tqD2c+FYOpLu7sIjjKfFCnxyD0o1yYqNU1CCevavJWY4US2txrPY8K+PlXYuGno+1CcKatCfJ1BRrHs2c3LeH/1SqJjXmst8ISAnX6EqXZU6mRkBchvL4Jpzy7asyZXApzbb6qxnZELWtkrjnNidRpfi7uNRxq7lNWLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtpxslRqyfo90ewJCAuxa+W8I0XsjBso5w4dYwOvyao=;
 b=iPbc035FBMPIcyYFYU85HH7XvQUJMt8QGWq85P7OhIaFXE3XOpZgUg023C1jKIlMHudIECJ5gxcfYsHg4/3f6GX61PTaQwU5qi+40F5FOPcIiFff0dWG15PHGtfH1NCf3vGHuMd5UapH1nVBY73U7mP1LxMNaKFrTdWZjqhU3qsF5XvIQS0azZ3QnkgkRIqqhle4TGSAk/EOFcu6K9BPD5XnHTt/Q2VKkkYlTX7JkvANmBe3y3WmAQ6LlDrRfDE2T7kjbdDGNiv1NpxoGiw7rQZQrrf2Plk2NWuEOPUgGOUYxxHiRiC6uKaXzVO0+TXRR4QEOfKUPnEkqGEJFzHViQ==
Received: from PH8PR22CA0006.namprd22.prod.outlook.com (2603:10b6:510:2d1::10)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 21 Jan
 2026 16:44:43 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::3) by PH8PR22CA0006.outlook.office365.com
 (2603:10b6:510:2d1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 16:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:44:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:19 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:44:12 -0800
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
Subject: [PATCH net-next v2 3/8] net: core: neighbour: Extract ARP queue processing to a helper function
Date: Wed, 21 Jan 2026 17:43:37 +0100
Message-ID: <8b0fa0abe2cf0e24484903f5436fe0ac64163057.1769012464.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769012464.git.petrm@nvidia.com>
References: <cover.1769012464.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: ce99088d-e55a-45c1-e64a-08de590c6107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5dD/WjVK2zoTsvjsThoImrwNyOFTpl9IUvAg8SWh0NXWJbHvDqwQoMFB6trU?=
 =?us-ascii?Q?WdkI7jxzfZBT//4lN+2rU30eXT2dQ3MyndzGmp5J9WHu1BAvzpvScS77gEOj?=
 =?us-ascii?Q?8hjRb0ov/c9X06zTRyez4sh7CgHIynKmjW7u9vJOWUNsaNYbTycfaxty6bbL?=
 =?us-ascii?Q?ecRtnYMTJmQgVBqA+DfqFNi3o2KKrnWa7InT3Cc56JkwrLVvrnhuv8wQypjv?=
 =?us-ascii?Q?Z54t7DlUMaqfxx3WHP2SKeEb7wYW0LbLIJzUMyahwIGKC7TZmpw9b/75E4Fb?=
 =?us-ascii?Q?D7syHwdFqFCNRbj2htliNajD05WniyXiV5aU2Yk9I5siejYb4b/WcqwzaBaA?=
 =?us-ascii?Q?CQV2Tfsa0HTuDxpgdcPjXNnrrbHMj82pbBKWo8hVV5S18teSbrnz2p9Ad9ct?=
 =?us-ascii?Q?awqsJcTOgHxomoaxjlNobWCY7jUtrsxElBqVy+qafpWR48U2qlt63Fw95Iu5?=
 =?us-ascii?Q?eSeu+AyrbuYNUR2HBWUsaJUPpvbc8ptW6LhI3+0yBNy8r1M4IzSMpmSD1lP3?=
 =?us-ascii?Q?loNMX7KJQmnyzp4UbqjjcE13YazlW/otfpBID0pgfmWJMCuflCHjODprAnxD?=
 =?us-ascii?Q?U54DTb1r/nh5fvw/V5EwTZVYZpeGCwBPBzZBylQdN2Ly6dglYPod/k+qTKQ7?=
 =?us-ascii?Q?lv78hmfrFIX8bLktHhTsWR8VCsXI4WY9mN3r7kDFCFJDm4kHNfAVGBWmcOoK?=
 =?us-ascii?Q?9tWhBjk+JhIPDvnjmG8eHtcU3wIBu6vSoIRqnIYYDxuKOpy7V9SENvEIVq87?=
 =?us-ascii?Q?6kwt94sfe75fiHzkKG1MUiCGNrw85INLr/1h8X5695T1KfBzK6b/u/qF3RFP?=
 =?us-ascii?Q?rHiYy9ABgISqk7IVueCuShE6lW5joPIqU8AcNH3kC1O2htVveJFIpat+MkhU?=
 =?us-ascii?Q?k8PAdn8x5bdYVl5dOJig3tQXLlg8j++d5F8BLcw3Ww6/EjWxgCGFmRKL1Iwy?=
 =?us-ascii?Q?rceg+QZfVJ7DopuPnNW2CaPIz3zkYa1Jo4TfHf9x19dhK3a0jh3WjMi8qPpU?=
 =?us-ascii?Q?Nd/Ap7OlpKvTi9u02GL7UcCG809g6l2sYSIV7yXhDvpjfkLVWfpEgCeRGeYX?=
 =?us-ascii?Q?+SYG2gvpdwfvX42bN4owMBPZru4wBwx5ITSB7/8hu7CgIGZElDPCTzq0SOCV?=
 =?us-ascii?Q?248+IS4dc2MR+etdXobBhi4SBFMveqlKRE98qryoM+1W6TxW8iOXIyBIFydZ?=
 =?us-ascii?Q?wH8gliKujFXS15VPXMFaSZd0QRCg+WO42tHeV4r+kfv3dnx0Q9p+pLHUJYbP?=
 =?us-ascii?Q?TTFA1pxSrF3DfUhdRpy0V5rSzXHqEFoEfYkY1qkjgxImZVUHLgPkQ3qyynpd?=
 =?us-ascii?Q?j4L7Y+P2JaTgx8psGvixPFudPuAVBLxxm+a+kALJ7Fr/KfXyvtoQFuSJV/2e?=
 =?us-ascii?Q?qGLulh6eLcjz4PHy8EzVUVsALYFUsA1dabYASYuTJR30Us/pDKygS/U/uiMc?=
 =?us-ascii?Q?u/+T0tBLEpncmXuS1RMG8tkNLf+rL58rROyFBtLGlZuszElmu226zu+2NT6r?=
 =?us-ascii?Q?koxY1HlHr63z2la37ldmuJfb78pFyeTW/idzwtcp++iObNLmHgTYJSmAb6Rw?=
 =?us-ascii?Q?Uy1AN/jeJbqHRUd/AOisg34+dTMDWre69cgOaq2Pbv+NGo5N7uZ5S8RqXjjf?=
 =?us-ascii?Q?xfXkrHXeGPbMqAF4uCIMw3WJkdpBrejlWCDiIPfaKhd7cDwE3RiuNlYPkUfB?=
 =?us-ascii?Q?kGpDuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:44:43.4806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce99088d-e55a-45c1-e64a-08de590c6107
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252002-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C2E1E5B992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to make manipulation with this bit of code clearer, extract it
to a helper function, neigh_update_process_arp_queue().

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 78 ++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 66f4a6525106..b6cb127a5b8e 100644
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


