Return-Path: <netdev+bounces-112633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DDC93A423
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE64B22EE0
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E737A153838;
	Tue, 23 Jul 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qChPUPxj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D7156F40
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750732; cv=fail; b=ZROCWY5SES+1EbhiFEGye7JqEklA6Y/TkEUGHL5dVeHUff2ZJd1W/Bubi5zpp5OYFyeTtOFVwU6qX4ejbx5kqhp5y/QQeYMnjxLE56phH7BzRzLmzT2afg1KYD2w8ocrHS5mO6bWtZmelGo0OmAmVEHsog7QWTeAIN27TAtnW54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750732; c=relaxed/simple;
	bh=wB7lDMZQHGedOhkq9jStooKc8CMXr4TwWG87T8fChFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gpRrMmM0Lu8rbggxS2dITmZLb4P9p7yOA0X/gKDJrNwfthAkittQQE8/hfXCcbCeOWvPBPeLhBuP3w3SW8EH+eQN+jJajwvmTXpr6DGuUhI3RuBskkVtZ7xHGPt1anSPPqSKzEKKPpserE9fTAlBj2jjmgjw6T/hdCAs/VDv0e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qChPUPxj; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ92XpL8kTjxCMxQdSu7FBXJ0G7rcfK2RLkDWj4enib76h+rtBV/TEw1M0FdOKE4KhR5YZrxI22MMoIJOlyhy6adrPAporpo4qOGHmtKNhbfxkh3k+eLn1qiFPE80uPu6P9LkqxcEf/MrEXzwcN6JSYc7TD2rBF+Z9UY9mucUjzXVIXtR4kYZ5EVwUrdZQyFy7czDdvc2fCsDQQqbwxPwFRwYA6bB+Oycl89etpF+29g9KmIy2PmFHUnQFV9kJ2TbzxeGPTv0XhXo+7ay+DytjNczONpeL9KI5w3s2a5zoqhkR5Cv2etBvMWO18gdWp5gVfYHXc1dtY4S+NcU1wbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lHvMQADR7XiMTLAmMVgjgT++rMpPLmfk+G7ktthT0M=;
 b=fyk/ZmttML7egnHye4XlBNoT3Lv6cu+/M3pjy0oYXCJZrm/YCt/KU/t2QnPg4CFodDHVHEw92D8I4nNXpERCQzaqSA2TrstGhsiwvI/03TIRbl8nRPvO+g8D7EBGDXgSLP30/chFPSj+Bmny2BV7PAxt7uAFWHAcsYCiWkPP1VzRErgQ6IZITIFhRaLjKIxf1Pq4nPg93Vwe5Qo8dRPgY3yCoPPImy3mXC20u/tGyAcKmCFcd+jlTWzB6OZCqdMJJmXgcu7R9X0xIsKcggJTTrQZuv4Bq4M7A2+z+joKENPe4PSsC8eJUMZVrazvaNb37nPNoaAaEKx7pzyAMjQNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lHvMQADR7XiMTLAmMVgjgT++rMpPLmfk+G7ktthT0M=;
 b=qChPUPxjm6ljB7gW0HhUwJ3hdfll8QFh5leo3CsI6VAUDcA9OHbny11eq6R6guZ+iXiLXvTnQrbllfhRdYUj/5KCbj3YX2UCaoPjpWgwpLvzYWsAJLrNeI2mmptdl3M3SRSzYiolu6XC1XfX50b909mJE6Gq4YJ3C/8OnIfjGy1C28u66UELMltxBlbm4QjafsHK9PaWU2JJ3aie7PYdFX/UxdvrP3M1AA6F19cDWqpmun2avObKchM3uCDb50f4MGq6JAM30+3bmTpxmapbDPtrMYriOCsubWz2WWiYgM47fs/j+6Fk0qQ6FHP6risyPj77kNEeOx51/Qnzhcp0YA==
Received: from CH2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:610:4d::14)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Tue, 23 Jul
 2024 16:05:26 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::45) by CH2PR19CA0004.outlook.office365.com
 (2603:10b6:610:4d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 16:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 16:05:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Jul
 2024 09:05:07 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Jul
 2024 09:05:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
Date: Tue, 23 Jul 2024 18:04:16 +0200
Message-ID: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b92ec2-3997-4b32-3ab5-08dcab3143df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nt3LKk8VI8qU6k4EJ9u2NXLm3VLGJ1gG2pvdor049JanndFAA8bfDknD3sM7?=
 =?us-ascii?Q?VD8Ky9I8+nrjCo7g932KS0FA2NEQY+AU//3oww3Xw1hmgfVSfFIB3XjW6ZgY?=
 =?us-ascii?Q?gwHWL6GQFmEEcDNdSendYFg7agL2NH/YCKkQ2W/8NvEfT51w4E2vPfIlqJn4?=
 =?us-ascii?Q?WN/JZduITcqrhBAxYdUNbsx7HSTNOjFe6Gun/FJo43e8ZdrFHGPwonQSLcgL?=
 =?us-ascii?Q?ph8go/d9LlEj+q++fNAEkNjTcNw70GTVQT9IxTAIcDyL8iDABmhe07ApEHvg?=
 =?us-ascii?Q?Sse3C89I/6uedTQQYoNQde9HP9XVkwv8Ke5iZgN8xeMS9L0Fkl33j+lTzZhF?=
 =?us-ascii?Q?+EwE/dC2YXKCrwu9npEPTzFq//fT/hqwwAzT0mAsLg2BFfXgMNsC9i77Sw5f?=
 =?us-ascii?Q?s5yR3+FzQzvJK5h0F+O786Ud/B5PQ3G7fcmVruix+N6RyOCiSJYw5Oh5ghON?=
 =?us-ascii?Q?QN1/TTxW6eOGPGu41kPXsY99L7XmgatsMxKOxtzNYT4gLyN+DsDT5V+rXbmu?=
 =?us-ascii?Q?rRkWgCSEmyAvo0Y8RykmOQLTOovIBEZxOeK9YHQxVQPs5Bhw8EbDXLvipIlm?=
 =?us-ascii?Q?l9BaRDHABe1ChCr1YyQbHqIN2vN/HQNUOcWoBB+hGtnSSKJTm3lsgxYCmAgQ?=
 =?us-ascii?Q?ZPeKDJjIwsRuSyzzU3Ma1B7V2JZfxXj4UPOL6RXTIBIDGMeZ7NtrtUEg6uB4?=
 =?us-ascii?Q?zdQ137qmRu/dZH686olBanCeLTGvlBVILnP2W3Gz+6AacO/LC4qprTDFr6M9?=
 =?us-ascii?Q?UmB/xBTQcZDULnONgkpr/YMWuF/Hu/yy8lP1FKbAEok/oy3qkyPLh6638nEW?=
 =?us-ascii?Q?ouoFSoYtXdPWLgWemPMt6Yg1UoryBtHms8A/3Gux2z5Z2uCqEDSwrw9qgUmG?=
 =?us-ascii?Q?ejkdwLq+z7Mml/2rnqYb9U4Ar6obTMEcnNZPJHAGs3C0nnqg2Jpor18Get/s?=
 =?us-ascii?Q?RkJ88uLYm4tTrOXQj/8eZ6mgXsjBeghz3QvlJ7iJNH6maE1J+P8hcydU+Bik?=
 =?us-ascii?Q?1c6oY9RGH5wRNApefDKSclsWXOQMBFx8BDn1iC/BnXARR0a+UNRdKyShRKjV?=
 =?us-ascii?Q?8DFkephnRUOn4mcP22xDFS/M4Lf1BRaitKgBqpRlUWoh58TtkAuZceby+Xxb?=
 =?us-ascii?Q?XSJ9BTD9n8rFTyF3BdwE8QTuSRgO9d0n8SpgX4hym33fj7W1jmY0r7jZMC4/?=
 =?us-ascii?Q?zaYk45g+ncvr2WdPE+suVrdip1AH3u2EQE7GgD6Fcmj0W0pRLXbj8RqykhWg?=
 =?us-ascii?Q?CSptDiHRPJZY0MDhiLM1QxYohd14tK0eon4aMP3sffibIUD2fU2QmPk0JbBJ?=
 =?us-ascii?Q?bSpCgGx+fxqScHZShB//W0H0zXHFhrJRp0GC0p1TNSbSMe3aR/ATlOUQU5A3?=
 =?us-ascii?Q?A0P0/f8xM0Ni/KDeIPaXHIPsT37cLS0Sydn5RdsQnjZItFPKYflqoYN8Q2pC?=
 =?us-ascii?Q?a+rWzj4nkRFhLj1N/jeLNqA0Wt+mrxee?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 16:05:25.8655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b92ec2-3997-4b32-3ab5-08dcab3143df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

struct nexthop_grp contains two reserved fields that are not initialized by
nla_put_nh_group(), and carry garbage. This can be observed e.g. with
strace (edited for clarity):

    # ip nexthop add id 1 dev lo
    # ip nexthop add id 101 group 1
    # strace -e recvmsg ip nexthop get id 101
    ...
    recvmsg(... [{nla_len=12, nla_type=NHA_GROUP},
                 [{id=1, weight=0, resvd1=0x69, resvd2=0x67}]] ...) = 52

The fields are reserved and therefore not currently used. But as they are, they
leak kernel memory, and the fact they are not just zero complicates repurposing
of the fields for new ends. Initialize the full structure.

Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/nexthop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 535856b0f0ed..6b9787ee8601 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -888,9 +888,10 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 
 	p = nla_data(nla);
 	for (i = 0; i < nhg->num_nh; ++i) {
-		p->id = nhg->nh_entries[i].nh->id;
-		p->weight = nhg->nh_entries[i].weight - 1;
-		p += 1;
+		*p++ = (struct nexthop_grp) {
+			.id = nhg->nh_entries[i].nh->id,
+			.weight = nhg->nh_entries[i].weight - 1,
+		};
 	}
 
 	if (nhg->resilient && nla_put_nh_group_res(skb, nhg))
-- 
2.45.0


