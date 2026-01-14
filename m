Return-Path: <netdev+bounces-249782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761E2D1DC0D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C40A3014BC5
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73A37F735;
	Wed, 14 Jan 2026 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TjGKKYeS"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778A3816F1
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384597; cv=fail; b=MSoEvwSMwCXXlnVEw0EiH+d8Y+4KCdr0NqTdiUZWQEUgADCLapdMumZVa0vIk4hJPNluxoaNhWkUAYq6sVQqXVU0YbLh3S/fYKMfCB8CuNT37api3B9zmzAFmRE1g3VLrffwf+D63W1X3xUpouqZ8pqNwtZ/3b4x2wqaiMK2jes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384597; c=relaxed/simple;
	bh=zOUNGRoxPl5Yto3Cgk0L2Z2Pd5nChPDzltlFiaffepo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnMRgNP/f9CgSPyTHNLhg0kAqpDwE+TuFr/zsoAsf+tz7sz9oMTGAed1TZizYV9ePa7WTmK+xZReb4yW99Ae24cxvkNdsohIhNU0aiHbNi0cUeY0fyrOo8WiXI3njwQEK3FfpkhyIbc0tz9vD5B2VCQtiqce+plZVEpjJhYOwhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TjGKKYeS; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc8W0p4T8KCSwhvcupPSIkBHbVuV1pWULFhCX8qHINxTYHOw7fX/dpSXCqV8qEraWwaSDBk/oQHxEl7lEvCEG+TlTQ+g7m+1ep/9nhmiBBPHCI8Ub/c0Y2zaDomJxLlXlFBXoVaLJlvR16DFwsZkxUOnGmotxzj58NRv85pZTUWalpkheKoTprZKO46iIiNLwOt5BeEOMT9em5bFYvq4jnCgS7U2mGdqcdaPNXrsJNL06Po2PoWyxUFO5FD+u4w/22oPBxddj1yCM0LtW+udTCE9XFbTI/6kc4rX2rPiX8V/OOLxVR/NzLZ3Xea9hRgi0Ny4DHW4mqTMPWJqsI+MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chbcuu3quLxzdXXvBw0+347kWUPi9Pp+oG+r0LdqpjQ=;
 b=E1fRxcDuSPDob1jWQuSi8jqZbjH8QwiU4ditRgZomfdA6E8CAg7ns6v5mflrB3UIkEVcFsbqBTRS2mQjvmDy/NuqIk36ZqlHnHovQ3Lq9mC78L6L5uCTpLmKl+dGTwUyD3vmQoPIhTs6JX2vqXC2KqnEOblKVr+xau1JRti+qzMM5CxD66NF01FHjA1p0dKYmOMZkNvMHoSt7ZxLoImE4i8xdIDShnF79q564kBRY90RRQ+3DCXrKQ4az8DNBUOfNj+N0NnMGYXFAAwby2Cfvt/+qtJLEgWtobJ4ptqbepkgK1dIm95MBpZ6u/Ns29zE1OX41asyHVp7D9ThWTUdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chbcuu3quLxzdXXvBw0+347kWUPi9Pp+oG+r0LdqpjQ=;
 b=TjGKKYeSuSK2sSEryW1LSIfojmkqQfQ0dnsu0qnl4NFee0OrQsWDMS/10t7kKdprrY1XnzNlX7I+8vN0jvEUBpDx0EbIaGrbm+qdsjpjp5SzaIafNZN+JNLsGDoRnyuOOfEo/9mdRXElGas5yW+tDuHsiSawXD5Sq0W9aILMtqx5XjQ36JhoIy8Agr+1Q3d4DQEvPFcyeXky8V4swUuhIkvds7wkXUk7IRqrIsgSGf+mzHDIZYqhV7eB6eF6tZ+3u1fJMjiL1yvxhvs60fF8HhMJdw1OsgcMOEioZlCC/4RwziIvos6K3l+VhcxwfWC5dB+x6ui1tcJrFn8WkCb7uw==
Received: from SN6PR05CA0001.namprd05.prod.outlook.com (2603:10b6:805:de::14)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 09:56:30 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::86) by SN6PR05CA0001.outlook.office365.com
 (2603:10b6:805:de::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:56:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:56:16 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:56:10 -0800
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
Subject: [PATCH net-next 7/8] net: core: neighbour: Make one netlink notification atomically
Date: Wed, 14 Jan 2026 10:54:50 +0100
Message-ID: <e3752b30651dcf46ac0be0099f5661f349268d2d.1768225160.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: a629a435-b1eb-4c51-f51a-08de535330ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?th8RCSPbl9rqEDRjZoJ5R0k4ckEcMBDvKA2I0nw4EfJeOn7o0kpdT4aP+bZd?=
 =?us-ascii?Q?hpboCHss4EU0GNhb0gN8wkX3R1F6LWFZSRbz+eEdl0Kl+UjCkHzuNU2x4VDu?=
 =?us-ascii?Q?sjBucaxFQzsoKqNmAVBf3bb2RvqclR9ZOvsig7vOjgY8ybw2pBwaaMLdiQAC?=
 =?us-ascii?Q?OR9nCZkiszjza9dlIVIuDU1twqiIuyx+T3mD4noncmXpDutvI1rT+MUYqxPb?=
 =?us-ascii?Q?qnkE7AitquujEWn+tbaTRJby31iVJ+0eJoq4N5Qn3r0H47FAX6M75oADRwB4?=
 =?us-ascii?Q?P7x7uX0W5qOnbtvaW1ir+fK5Zy8cwuW9NFoYvc/z6EUrLiRZYIFSqOEDi6vU?=
 =?us-ascii?Q?xjrng+vq1my66tbJwJmGK8EAq1gXIeq91qGARh340d/p9gJDjmJg1xTN1LvF?=
 =?us-ascii?Q?XO+qDjhq1i5zYRkBhIKPTIrEdt/wDTCnPaCFS4c6d/qulzwWZf33KSyUYIRn?=
 =?us-ascii?Q?Ii3FS/HYnWdiZhW0/rqowvMR0njJifniotxcOjYfYyBukePPNh0U6dTbs3R9?=
 =?us-ascii?Q?GSRHEFUaVnp/6YNM82JEoQ7wMzjSzrsQRu/6lZ8VL6c06REDcIipNm+58PzK?=
 =?us-ascii?Q?vlOeKBfXXoa0UGoqpE5UtGHseP1tM1ds98cDuJzUComGUZ6daNcWC+avIgbf?=
 =?us-ascii?Q?FCbwDrnDTkGId8zkFVhaUozCpYUuPtBp8we0gp6WH4vSHQYCpa4P4A5MxjU3?=
 =?us-ascii?Q?L8nVPmZgGGGirN3qvjfwE2dDNK9ivIM0qso3ukwUDNeo1VpntKb6ThR1SX9y?=
 =?us-ascii?Q?ggavvPvp4Q+cG6a8DMDy55B7ryywScgodlYLs+W4pwkiVK+ayl8wcYWekLVI?=
 =?us-ascii?Q?HP6hGjPDzXDH8PXlTFFJOAWa5bfi8UWtB4hYe7M6DFhLNYgFKb3JYy1deI+a?=
 =?us-ascii?Q?hyxgr4CsIiugdfOjOdEtXTDf+dI+GIICvafRCGGriHBpuw4/GvOviSl5k82q?=
 =?us-ascii?Q?WGDTz5GpbexgoAiiCqUsP6G0FqgyAaKIcfsm06oCVSHFSKnGQb9YqELnVwBn?=
 =?us-ascii?Q?AVWVQuUH395x7Plw8CsjJzz/Cvp9XHq5oPSsZS6waztPHK4LSPtakKb/m5PR?=
 =?us-ascii?Q?l8VtbPe82ddQN7BFtQg6GxXrvBjPycctGVMwtnwP/nPXH6vEzgbcPZEAbJFZ?=
 =?us-ascii?Q?EJVa1BeTF3DdCgZ4R+TnW2StMdQD3FDa9rqlAurxCLlIC00NdcTvaOZlFPR8?=
 =?us-ascii?Q?xSdc+8DXvLPVYs+NeuXyNWRsh6SiSW8XtCJ2NBkW/yYBYm9QJXv8762/FIPb?=
 =?us-ascii?Q?pUxhizM5mM4QcSLtyhtoORMcGwoLRnAq/OPacpS6g9f3/90+Bv5qw2ZTJaQG?=
 =?us-ascii?Q?Wf0P+GdmOkwu37nwo1lrNvFNviX5Q56UAZ2ZKXTOCPuTy8mEIFNQsDLdRZNO?=
 =?us-ascii?Q?oErgzAlHkX4igWJQA+E26DKTQfNS0v058dyo3ykVda48NqXEHtkTuUHGHGWA?=
 =?us-ascii?Q?JSM90GdTRDa9Iy8bk6+vu+yw46mIrj9D5mSypB4+yhi/tgM4DkqYxmVi0XaM?=
 =?us-ascii?Q?OEQNxp/Y6t3aKrxIAysuD8J5pCKB+xdZ10DHJwr2u9oUpEbrAwIEYpaQlNOb?=
 =?us-ascii?Q?jKoY5J2QGLqszWzk1W4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:56:29.7696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a629a435-b1eb-4c51-f51a-08de535330ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801

As noted in a previous patch, one race remains in the current code. A
kernel thread might interrupt a userspace thread after the change is done,
but before formatting and sending the message. Then what we would see is
two messages with the same contents:

    userspace thread		       kernel thread
    ================		       =============
    neigh_update
       write_lock_bh(n->lock)
       n->nud_state = STALE
       write_unlock_bh(n->lock)
	 -------------------------->
				      neigh:update
				      write_lock_bh(n->lock)
				      n->nud_state = REACHABLE
				      write_unlock_bh(n->lock)
				      neigh_notify
					read_lock_bh(n->lock)
					__neigh_fill_info
					   ndm->nud_state = REACHABLE
					rtnl_notify
					read_unlock_bh(n->lock)
				      RTNL REACHABLE sent
			    <--------
       neigh_notify
	 read_lock_bh(n->lock)
	 __neigh_fill_info
	   ndm->nud_state = REACHABLE
	 rtnl_notify
	 read_unlock_bh(n->lock)
       RTNL REACHABLE sent again

The solution is to send the netlink message inside the critical section
where the neighbor is changed, so that it reflects the notified-upon
neighbor state.

To that end, in __neigh_update(), move the current neigh_notify() call up
to said critical section, and convert it to __neigh_notify(), because the
lock is held. This motion crosses calls to neigh_update_managed_list(),
neigh_update_gc_list() and neigh_update_process_arp_queue(), all of which
potentially unlock and give an opportunity for the above race.

This also crosses a call to neigh_update_process_arp_queue() which calls
neigh->output(), which might be neigh_resolve_output() calls
neigh_event_send() calls neigh_event_send_probe() calls
__neigh_event_send() calls neigh_probe(), which touches neigh->probes,
an update which will now not be visible in the notification.

However, there is indication that there is no promise that these changes
will be accurately projected to notifications: fib6_table_lookup()
indirectly calls route.c's find_match() calls rt6_probe(), which looks up a
neighbor and call __neigh_set_probe_once(), which sets neigh->probes to 0,
but neither this nor the caller seems to send a notification.

Additionally, the neighbor object that the neigh_probe() mentioned above is
called on, might be the alternative neighbor looked up for the ARP queue
packet destination. If that is the case, the changed value of n1->probes is
not notified anywhere.

So at least in some circumstances, the reported number of probes needs to
be assumed to change without notification.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ada691690948..635d71c6420f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -52,6 +52,7 @@ do {						\
 
 static void neigh_timer_handler(struct timer_list *t);
 static void neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
+static void __neigh_notify(struct neighbour *n, int type, int flags, u32 pid);
 static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm);
 
@@ -1512,6 +1513,9 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 	if (update_isrouter)
 		neigh_update_is_router(neigh, flags, &notify);
 
+	if (notify)
+		__neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+
 	if (process_arp_queue)
 		neigh_update_process_arp_queue(neigh);
 
@@ -1522,10 +1526,8 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 	if (managed_update)
 		neigh_update_managed_list(neigh);
 
-	if (notify) {
-		neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+	if (notify)
 		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-	}
 
 	trace_neigh_update_done(neigh, err);
 	return err;
-- 
2.51.1


