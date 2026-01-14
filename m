Return-Path: <netdev+bounces-249779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61378D1DBF9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A208300F06C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7CA37F734;
	Wed, 14 Jan 2026 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mrbIQU/S"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0437F730
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384580; cv=fail; b=QzaRZmeukPGXxHImd+ftGWxs6FLqM+/jUQ1K5TGtLd29tO99jQCxRXZY6H1ePOUxRmN0s7j8yOuI2I8VwepMI94+CME8T69j+Bd2v//fxkbaZc/pa+djjrVm9eeHwCcM/3OANl9sHhJCDwcQ0Hn7UlldZyhb7wrFpfemVrl9/lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384580; c=relaxed/simple;
	bh=4kgzTSbXkUPVCcZexcNYARuwP9x+nEtTKohdH0KQUs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLY8y70F8UMN5kex3d0i7299TIBGAKSpEiaATWsyry2pqTNhFK88zjviEHKHxpS4da2GwcPKjKRt/GgGBF3+Vn1GtBtU+evYpw2/RWP61+rqr8jDZQyRlQWN2L8mYmZuCc41iQQtCyDuPiypyB/zxVCqJ6YacruWn5jt6cK2i6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mrbIQU/S; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVCY+ZboO9/fxW+0ZIaUurbDvSGB6G7PtsSg1wa2jxtLnWQqjIHaEexsVGJ9FJLBsd2s1io51fy2dI+I+bK6pTvTP7H+68stj9UptFjIKcicNWiCjNZN5YjV/rbqRYsS2hTRIbJX7KmMud383xl8Zl44zCrIpltGwyWzyaB7uZEJmMW1wU1pPdEWOJ3uWUM56bfdnjEbJUos06wJuEwSChl9FLVeH31Lb8OO1Qb+QApyaZNIP4B29cDsaOaLdLkjMgc3DMC225qZyoOGyU80j3SH5h0SYMVqxYOkWY58yEhsB06Zvbq0b5ShIN53W+KQpL3N/5Qwqd+evRTOU6KbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4bhCCZRSfKxsYvRYDj26MN5Jq8YtALqg8/2vhgb39E=;
 b=Ad5k9qcJ4eheDKzDM/OqYaJQ6btj6EEV6jVf7F+8oe6CEpWlnSa5jjhr8rGAy1gkACwMYFiAA2OjZuhukDmjMIigbpxJ0VWtl+56pz6qRjuYUEMFXsNUfE1s3jo/KKF377my4JuOwsGm1GUQ9HYlu5h+ifEJuV3iTiUDw2Bl33RsilYQT3tuWvwt7PIxynJZQwumJmO/FXaGhcGyS0HAaMpdLEj6ZbinZPN5OqOAzcGVAyg/YLzhvHRKLrbrWkpeSYZhtCju3u8hz0oEehxdvfgvGAaIBUueBs7qY1XSPQciplhS720+x8+cP1H0ueQ0JfqdSPhcpJ7tr7oI6w/I7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4bhCCZRSfKxsYvRYDj26MN5Jq8YtALqg8/2vhgb39E=;
 b=mrbIQU/SXIRUuDLHNnr4c0KYgURCsdKer10/C+f/IT1pZ5TEZrjGVSf6xTXtpaZMIuAUuAcVIjcX5wn3PzOseJZCe4TlpGGBuwuIOsWxKL+ZA8sNoImEjSDAimuK9Myl8v7Hl0sZubjzhJORZkFn9aYJqhiFmOeM55ut7nMHADKVTAQ5c2MOKI4hOQqrvJ8QXbuMMUD34m9vvyDOgtPA1M8IcfBIOwKsdeyotmniOmWcqA8oSgVtWj9Dyt+L1g2RCRAWsyDOgSKdOKrI9INUcZtlXwwEMA3UCCOhivAEmCnpzGz3G/LRuwo4Gxoz3k6y6s3QRpA2Nz7bhfY+OAMjNg==
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 09:56:13 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::40) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:56:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:55:57 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:55:50 -0800
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
Subject: [PATCH net-next 4/8] net: core: neighbour: Process ARP queue later
Date: Wed, 14 Jan 2026 10:54:47 +0100
Message-ID: <96683fb5adddb45cc79305213eae46eec8182f57.1768225160.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0fc4a2-ed1d-4f0a-4ac1-08de535326a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wNWcm5yM68NwKHyeV0v15EKnzqKorigL2PdF017qrYFtrgkHqQozngfiu+MN?=
 =?us-ascii?Q?f8nWyfA+yNj3oYysWbzZXFCM3/6qoRhAzbxb7a6pQHRRVM4RP1IMFXDEEGEs?=
 =?us-ascii?Q?pvjPffTdeOzBIFifNWaHo5LcNC6OY4MPaonpEGMJXGYOP1CU2+gCcitC4GSx?=
 =?us-ascii?Q?hBRSWf6slfRkTnlHfMsibSZJLY6sEtu12ZkinUhM/26uch8PE8KjkqDd7hjf?=
 =?us-ascii?Q?po8wH6rfOT3x+cwGE6Qwpx/fKlB3LTIx70zRYbvpFQwSoHW2BMBU9drtLC1x?=
 =?us-ascii?Q?/MAlnxxDSXt6B74rK1F3+/R/z6IxKC7IDt9J6iHuUvKfPipoFvJM8oWitmzS?=
 =?us-ascii?Q?Q9yM8K3sm5iM6HgPSxOp28AKXZ7I0H7VRaauP3nFL9zfhJQaA2dFCYgSaA72?=
 =?us-ascii?Q?PFQ9JYdVulk6LmCgPB/9hidsKPKyUymdgr3tZuYEIMmA2aIF2U8os8V6mgKN?=
 =?us-ascii?Q?8ji9wnyqtjD86FVC8BywV/9ntYN5ObjgvSVFFok8NwkJcotNnDACI/5B+GoF?=
 =?us-ascii?Q?v3tV7XE5P0MrW/0RlHACeCkQmgNSw2Aw8D5BF8e+3corpe8z/n1e0OL9Ziax?=
 =?us-ascii?Q?Zfi/S8vPJhmigaCv6jC8GDHFwQHYphILRfcEuGlL2SmFFoCD4apw2Oc5/K0d?=
 =?us-ascii?Q?kH0OQq4W0R84G3nk1Z151ituxgTfR90yD0bX7/PXHU5jycB0gKMWUcyqqBrD?=
 =?us-ascii?Q?QCTBigxMnagBeu2Mc7xEXWg22FejE20B7hhlGh+OkP5rZm5iUCVCLLB/BdOw?=
 =?us-ascii?Q?tZAZsgrDaAug/KQ/3gcNLVBZsVkPQYsVBfFxpLJIX6DKuIh1EhiraPIQXcGZ?=
 =?us-ascii?Q?FpnJVxTDSApz6tcGBb/N+RlZqdWgecM42XrV/cYcchWUlnMHHK0x4REsYgxz?=
 =?us-ascii?Q?7EhRnTYUUeLxLhpykKyEY+l8NkhkUt6aG4aL0Q2PSt0rimwCW1OsSrJImOMT?=
 =?us-ascii?Q?jihDoTRqRl70tU2eVg8+/GVWv7yyi548ANR+vgGXCaQrlRNgAfklJRe3LiNV?=
 =?us-ascii?Q?/f9trQS9bpCXZKXnCY6PqrlZ8H4Q7Ep8U8hZv7WHB+NFLbDz49WjoUQ44ppW?=
 =?us-ascii?Q?+ygGfXemSdb29efJlVlGreIlaA51ROKqAkkuejWI6QKqMkyC+MZRh9IQTMj+?=
 =?us-ascii?Q?PqTmLLVOzJ0WJPKOW4Wts1z/wQPxxJpEb3NSSs8iP/qAiiSlikz7qjHuS5fV?=
 =?us-ascii?Q?k7Y1VzBQq06pJqkPKU2Te34fy517qYk0pmQW6+GSKxy2mhW0kYYNZmPqmrXC?=
 =?us-ascii?Q?Sm2yuamRIb0n1cDt1fMTx2kPTtvAU6tpdVyFedSpfPZaECikZ0U6Qo3gsEiP?=
 =?us-ascii?Q?v8DUGRlqQuV2XaBTaeC11ZqbI5t5sTEnFTQwlZsR0WIMUl9EpuzwdPNoacH6?=
 =?us-ascii?Q?SZUx0QSC3JQCwMOwLtkn0qDcb0pUNkF5LmbJp2Qc0GOhwLBG5IA9jqR1r0SI?=
 =?us-ascii?Q?gMvBjFy67ngxGOsvRoroggmI7JrZ2NKj+bodc3Jr4FCN/f27vj5V96yCZ0IF?=
 =?us-ascii?Q?TRrx9QMTWhsKHKV/9TcmbSXrTzz+Jtjf6WtK6dInhchQAjnfxM+IUhQS7JQ8?=
 =?us-ascii?Q?rMWftkdyh/X4JNdPRYs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:56:12.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0fc4a2-ed1d-4f0a-4ac1-08de535326a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308

ARP queue processing unlocks the neighbor lock, which can allow another
thread to asynchronously perform a neighbor update and send an out of order
notification. Therefore this needs to be done after the notification is
sent.

Move it just before the end of the critical section. Since
neigh_update_process_arp_queue() unlocks, it does not form a part of the
critical section anymore but it can benefit from the lock being taken. The
intention is to eventually do the RTNL notification before this call.

This motion crosses a call to neigh_update_is_router(), which should not
influence processing of the ARP queue.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index efbfaaba0e0b..f3290385db68 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1369,6 +1369,7 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 			  struct netlink_ext_ack *extack)
 {
 	bool gc_update = false, managed_update = false;
+	bool process_arp_queue = false;
 	int update_isrouter = 0;
 	struct net_device *dev;
 	int err, notify = 0;
@@ -1504,12 +1505,17 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 		neigh_suspect(neigh);
 
 	if (!(old & NUD_VALID))
-		neigh_update_process_arp_queue(neigh);
+		process_arp_queue = true;
 
 out:
 	if (update_isrouter)
 		neigh_update_is_router(neigh, flags, &notify);
+
+	if (process_arp_queue)
+		neigh_update_process_arp_queue(neigh);
+
 	write_unlock_bh(&neigh->lock);
+
 	if (((new ^ old) & NUD_PERMANENT) || gc_update)
 		neigh_update_gc_list(neigh);
 	if (managed_update)
-- 
2.51.1


