Return-Path: <netdev+bounces-124550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5ED969F7C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B060282B17
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405E482E4;
	Tue,  3 Sep 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ds/w20E0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC12A4AEE9
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371670; cv=fail; b=BrPqbQaxwkrdjvUMGtX2mfoCT6NI8vULQkYgxaMKAGng8+4o00tTY6mUTibjwA7hqgCmDEQh5GvrdnT9YyIvqj4ZnmjSaQ60nyDNrJTSNMN0xBOhj0hrxnq8Kfba3m83ADIri3/IrXWj0fyaVzDeCHAGt8vVUUqgJibO0ilEpzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371670; c=relaxed/simple;
	bh=DShXp46buMG1OneYB6FtWdCtW+zXzH+r4/puauKrmmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+Dcbtbng5KExpg0FPJE/e8eg4jShtMa4jiw6zX/fRHCVjWpOG1s/uZtW96NrXiFb9VJ1d/W1IbD38RcLKgW9ucIrROKONyIvF99cSjmUt5krpTnU2I+emHAly3X3ANGy1U3z1n7v1ov3SCwdSHwEVKT+ROOoG+4xz3hoRvxuTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ds/w20E0; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMiyTtYWLPSLB4mmdPZna0IdtcmQ45wxMqSWXJTWWIy3t01sn2HRkQy9grCSpFAG2mv5DdqPrbywRz+74Hm9n70tALjC/2kp8v2v2JGaNSyj36h5wtGYZUWGFOquc59q2mUgBVrb3I1pFcjpdi19FPWS+uelyR+6SqXwLoSDdoqIY2kklZ2329fgv15mSlkcUBnHu/fJkSFGG/nAYcTQ6Tk4yv6vivCYmyeCHX0D/8RiV1J4GpQU7FHdFPKMWlJHLM8Q0S/sjaS5TQJWkwFUvZYyJeKv+LKypTLiV7ngD3Z2Y+OoL/7/UsvnSpS9Ou9M6t6N/dzLY2kCfLC7yPpx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4ohU7uuF2glEAAF/DUU/IvJ+ZcLEyn1aFPpFSfDppA=;
 b=Hv7D35x0loKPhKGpN7xZ9xaw5KF+qtDUq3sgcHw5sko34rpbAjtlOvf8k5w9xVF7GDugVXJK0EFf/nSXiy5VrE+suZ1zQ5bzm9HYwM9+JkPai+4moodsqJeF3OHiFsmRVa9VQUNjYakKvwPMPbauUB5I9hk4XfZqfO2Z3eIDK5Sb77UxPnikrzws/BECWmCzAcQH2jTqbsj4YQdQFk5hmW7s9QJKH4NTaCl356q+ALwVYGThdm0bxFx59X1+j8sMcgK7DNoA5LJ9jaejRNdpWLlQzd95PvurM+ZCY5VQz7aoxOVVn8mpfupsAmqgljT7tVZSqtR6UhkCvcSvvoujQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4ohU7uuF2glEAAF/DUU/IvJ+ZcLEyn1aFPpFSfDppA=;
 b=ds/w20E0xNA2Y6cMv6cNeaeNaVkNCDlKf0lDAYuT6AuZp71uv5Ne1qTww1cSCw4LFE4Kz2o8CUtvsr0QlZyTGMNCPMAuNh2Ty5O5260kL9d26eA/eGa6dRfF+nNCeYbvSYW2O5e59XDoD+eYBF4+l8pMN4ZVZnrZLN4/s+8Ky/eRCZJyvcH2Z7D9fgEhSxwpLOu7gYgs/mIdxM8uJeWthc1jVB/ShxINV6SDo03Sm/LtqH4yB9esHwXmXq93R/H+5+LBJ9rQdiecTXqeMD3gW+raGs1CmJte+UaiqAgog21/FZfLiSwOqT995eCWTZkSHRuyTB8vk73K80nPKPMddQ==
Received: from CH5PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610:1f0::9)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:54:24 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a8) by CH5PR05CA0004.outlook.office365.com
 (2603:10b6:610:1f0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Tue, 3 Sep 2024 13:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 13:54:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:13 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:09 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 2/4] ipv4: ipmr: Unmask upper DSCP bits in ipmr_queue_xmit()
Date: Tue, 3 Sep 2024 16:53:25 +0300
Message-ID: <20240903135327.2810535-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903135327.2810535-1-idosch@nvidia.com>
References: <20240903135327.2810535-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3dee39-8724-46d0-3a07-08dccc1feb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A7P3d6u1d5/zbNMrbvmdgydDC9PO192xU9EbCgY4uDMHHF1T2hpueXJkbaIs?=
 =?us-ascii?Q?OI2ZHVEVhJnId7CNYAktLoBgwmvWyqeoZXKaNl0OjE0exvVTDtcUbn5QhHbS?=
 =?us-ascii?Q?q+XMYwYhm1cbPa4AcWOwJp0qL6t37hwoFK+NAyZgBKMGWmae0WpJ9du38oBQ?=
 =?us-ascii?Q?c18MT+gnb8FmIcgmyboZRmuhxJJxzkFvVZXZZJ0ha/Futeh/U1hH/3+01KDL?=
 =?us-ascii?Q?48mrWfye2NqP2G8+7KUVodv3NraJFBHe+0kYeeieq6yej+MyHU+RwFRLTyab?=
 =?us-ascii?Q?Q0hhbtvGd4ScAs57UHRbVd91uQLbwLirY5qbv7dgWy+QgypdZHxXcnQMBbnC?=
 =?us-ascii?Q?zvZshCo+Ax/2qUUy61YbH6sgzv6HZk+ESEwTe/Apppno+jdEC21ck4vIEDXi?=
 =?us-ascii?Q?h/k2C6YJROD2XzK24yGgFmBAvKwXQN3zsLZf9vm1Q4CXWRup6wb+fZm8Ou7C?=
 =?us-ascii?Q?4WcENGEiLquaQEiFwTkFtd45rV/e2RL6NRB1ZVjfE6qsUKL01b3KuBshEDu4?=
 =?us-ascii?Q?jgRSD/ekPQopUrB9yLrkryeh8Yg0anDJ6KAByc/SLXQVp1biVjZi8jdY1GRJ?=
 =?us-ascii?Q?AucfkLhVGkoKpD2yQfsexnRsO6cuON/2NfuhdUVtMUYmWQdrgtgKjbXEccfP?=
 =?us-ascii?Q?h3xRlx80PonBXrOIwkONG6pazZ8xMeUFL4ZvTO9OXDqkivkFZ4n5U89nqh6j?=
 =?us-ascii?Q?l9f2mktks0un+5eWfBamVA5sInd2RcrhHtlMxk8ZU63VImRllnKU5KWux6qE?=
 =?us-ascii?Q?kxYZuKIueZFTVmRwmD7vczamLOKjuSe8a2PsMqQDXU0YT694U6SNJLsXlGiW?=
 =?us-ascii?Q?5jQ28un31FPugZIXyHf05Zlpe6a3eOl6RvkxnlzNyJqpggHoihxASiANQwph?=
 =?us-ascii?Q?0VWevEBw30axYS1lQARKt6svAVx3AdmWcqSLBwQZuQlpoQpVw2LxcAHlaoJg?=
 =?us-ascii?Q?8w72tjDBKHH7E9dTpks7XYRXfYgHY9fHxo+4+a/1K2ibzJ54wI6iGnXnOaRB?=
 =?us-ascii?Q?268C1uIDIwy7Ew5a7E311V9DWUeafTrq05UZ2CMa9RDC2mGgnFZvMTVQGsK/?=
 =?us-ascii?Q?4DdZoB6pSj8xBzx0anScCBBaZTIv3jZeIILOJ517jdsVbYlDaSjvAQyzPp1g?=
 =?us-ascii?Q?rTvdmpLFylYX61dylzVfwVcxOBpnw8kjKoHKlx7eFX3uSBDaMDe8QZV18Btn?=
 =?us-ascii?Q?Wwjhxn8pu4QvpaeUeZWPc5dv6Sk7tJbWrf85MTFKzQE7yR8k0aeYvhxnBZU0?=
 =?us-ascii?Q?QnIi6qoKf+ME9pyXrJwtcaPFgcoqxcxA3SBy9WJ5OYor+MYmaMwJ4ReP1+r2?=
 =?us-ascii?Q?M93V0tNFigjh3qrgJ1M/0CmAxx1pwmc+uqrCsuhWLHnZUWIY0X+euKIMPxdS?=
 =?us-ascii?Q?uWqehb8k6f74KZ8y6+5hR3wrr3XWatWBU+AL2qdnTxY/3A06kCREu5CebzTw?=
 =?us-ascii?Q?UEopOmZz7RSODWzIP3WCUK6cte7uIUUk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:54:24.1047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3dee39-8724-46d0-3a07-08dccc1feb3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440

Unmask the upper DSCP bits when calling ip_route_output_ports() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ipmr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index f1a43199551b..089864c6a35e 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1869,7 +1869,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 					   vif->remote, vif->local,
 					   0, 0,
 					   IPPROTO_IPIP,
-					   RT_TOS(iph->tos), vif->link);
+					   iph->tos & INET_DSCP_MASK, vif->link);
 		if (IS_ERR(rt))
 			goto out_free;
 		encap = sizeof(struct iphdr);
@@ -1877,7 +1877,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		rt = ip_route_output_ports(net, &fl4, NULL, iph->daddr, 0,
 					   0, 0,
 					   IPPROTO_IPIP,
-					   RT_TOS(iph->tos), vif->link);
+					   iph->tos & INET_DSCP_MASK, vif->link);
 		if (IS_ERR(rt))
 			goto out_free;
 	}
-- 
2.46.0


