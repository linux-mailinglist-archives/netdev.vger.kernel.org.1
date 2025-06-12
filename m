Return-Path: <netdev+bounces-196942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A952AD7045
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA9617F957
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56022256B;
	Thu, 12 Jun 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gkMTNK0K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6BC1917ED
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731089; cv=fail; b=PswHb8vAPkQR7hJ49GDnvO332+cLG32h28SKPhPvzZfwfTh3/O3D8gxJso3J/HuZU2DlgqmVyo0TkvJlOY6UuN6nyWefT1cB4T9wbiX4YBETu7RcYb+sp1y76ubqk+sY+8tqm2vr/Ebh89Lk4ti0TdjYmIbO5vZE4oZ0qX1vNsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731089; c=relaxed/simple;
	bh=VTgvLfC7WdRQxtcZSdZjsiVvenQTCrblvlI1mXSwBbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDWvasuS3gIEmJeJaUiYF6vsBGpLvg1wLeWyCsfwxjJN3eaB5T6xtjXSi90oG9llN6GDbAecyynETjVg4m7+xWpKA3szRod3vatGhPPrrwBNgOmwPAbs7eStk0NCY69dpkZOSWCzhh3W99QNvB7vd3HEHU+pXTNXAmOcGwoYLE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gkMTNK0K; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqOXVWw4hmdumFVdmz/BeKz9uUCElPikIkl1PHue5qYnSjSd8w8fUBrWpl94jH4kGGZ+pjof4VmQkhvLUJVjmwYN636LEWVvCwsxW1okjZYe06RrsSsPyuwat0AQC637vVoEROef8SH9cetIMnt8d7CNV13QrD8zWOyOn+GFcz7IL53y/2CpZt5o+Ums9+SChv13QLPqd5q6WvsYgssbDsZk7iHCNEUKDA7qG821NY4GrSR3+eFpCNvyzWqX2T6CMEitxufFOPZ8nNVbQltoElTkzbq8U39n9cwSx38flM/fmO2Op+Y2ruHqcWNcLekDvqArpEsozW5ZBmkvNJDJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpfLvGwLH9tYJMUHi7z2LfxLP40MkMTsLJbNxJoL4XU=;
 b=JOR1e1YwTxUZSxpB64EwLdIunlEV58DKuc7A5pkOA6BMOH7zZo1M07aPk3DSNbxz0Ym8mlA5VO866nw8NzxruDrCFfq2gg1okH6RfZMxAZKU72cUGEYe8pRjxK/ruNkAVMbawxkY1Ev5L/odM8ZcmZP2lMdWrgUucD3DiHcBXtNTXyK8WhitQYpuTFN5/9HbrLCS7MEbkDyl2BekRm1QYFgJ2j4m4wVhWgHm3rjIWZQd2/oDvPkIndprfDr4q93Dh2uqJX1u9eMwL7pq7m9/6kNlNHTPvm5xURR7n0bXh3E95QPvZYkWkqcpTc9Ve8BDQS2ZNKbocOnHVjcIKdt8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpfLvGwLH9tYJMUHi7z2LfxLP40MkMTsLJbNxJoL4XU=;
 b=gkMTNK0KTAKRM1706ffRMm+QaOK9uJBUW0WfsZb+DmscRtH+3mlHnyQ42ABLUtJ6VV+5EcAquWfBpHj6qTCFYyFNp7/YBZnJ8kFlpVYtRY3DLayklRmpXzLYmXHWaHqha/Hn/N4quMN50SwO3UQthg/XPh5s5Qm9cCGIfX27vugZV4ZvBlKzirVsd2Hazr5YdcJYcg7Wy+onu2nayHlPvdEtl2rMTyA36srsGJx0UU8g36eWB05SohbZcJPAmxFvrq524KItJ4gD1Qtt8ACgfJ8zR3WEehsRssJrEn5S1rQRIiKHKnvRKLhWaKeexjRdHbsByebfciXNp3wsS4wvqg==
Received: from MN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:208:530::35)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.40; Thu, 12 Jun 2025 12:24:39 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::bc) by MN0PR02CA0017.outlook.office365.com
 (2603:10b6:208:530::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 12:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:24:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 05:24:23 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 05:24:19 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrea.mayer@uniroma2.it>, <dsahern@kernel.org>,
	<horms@kernel.org>, <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/4] seg6: Call seg6_lookup_any_nexthop() from End.X behavior
Date: Thu, 12 Jun 2025 15:23:21 +0300
Message-ID: <20250612122323.584113-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612122323.584113-1-idosch@nvidia.com>
References: <20250612122323.584113-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c79be6-80bd-4afe-353e-08dda9ac1a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLozla77CebxZkJbeTo6UfioaxMeKtiBlS7v8Fupz65hMQKj+ng7V1Jg9pwg?=
 =?us-ascii?Q?Alm4Tk1shvzVh7kIjv3GiSu/2Mpe+a0NtSSA2OLV0g2wDGJfIMsfjuw6T4p+?=
 =?us-ascii?Q?ciDatpbFdox3o3w5uMYDrhunmHQEvURHvcWY+zXKmQg6HHcAReN6z+fu5+mi?=
 =?us-ascii?Q?/IKDWuz+Raa7zF/iH2UA6GUx5yh/PhTgKTm5VnHDkVpd3udPxIvfwQsEYq6y?=
 =?us-ascii?Q?6TEBPVlAHs2lmxdUdc2An1kmeX1Me1BqHR7p2vf/F8JSMvSHRfC8V8vCpwlZ?=
 =?us-ascii?Q?9u5UPZ0oKutNwJcT/8e/PRK7n1B722STY64J/agxk8wvNopuLlwfBCFUvPri?=
 =?us-ascii?Q?2qBzP0BlvzHicB6bEJ1jFKfQeUY9a6C1O9QaNqKoJ7Q3ssjFxhOcuGrAKuxs?=
 =?us-ascii?Q?ZGNEM/z5DSw76ATARQdUwrSYLZ3n60KJh9QmtQi04ewP0WtGWLNmz9HoEW7F?=
 =?us-ascii?Q?/9vGdosk6oCMcKnEiPBgKd3L13Qdj8RsRblpOwRQUnyhSSFRL7a3SEuYalz7?=
 =?us-ascii?Q?+ZMu6nEuKa2IwfTNGZm139oTjDvAZ7xTeYjYDeleR8ZwYe5EQoWaFV4xTTUU?=
 =?us-ascii?Q?IuA5Y6OHZ8HZYnp4M9da4rl30+PNwGQh+P24FUeX5yxoTO9LApLedE2qML8y?=
 =?us-ascii?Q?u9gE9mVZnJrGgcg7gOTUDfMecmIEjE3OC5vVS2ejg4g4qP8JEq83qUABUx/0?=
 =?us-ascii?Q?OtG+7X+VKKybIrV+n+rh1K0yZ8gVZXuFzToENWWvQGuA3Uf0hL3f3jNtPkKN?=
 =?us-ascii?Q?9r4kxwCbFY05eRceK8Bagb5F44hSV5WETre8RuAQTQlLcJQm3hbjSHpGpw2l?=
 =?us-ascii?Q?1OMpKhD9k80N8n9LK+Xt4RGOAkakLueQhM6Vt2+tifXcD/7w1ai78mHM6Ows?=
 =?us-ascii?Q?euL6hq9l8s5SEP89457sVMpxOS8DI5Xe8/X388EBoCy2Uosz6z1aLiXI66zm?=
 =?us-ascii?Q?LiwviDz1O2xAFrwsyPfTk7cuWNpqOsR58apNq0UEffvzV9TcDqJrNnKbzR44?=
 =?us-ascii?Q?fb+eRalzZl/9xwlBsnAJwNzrljrIm2HoJhHJac8cJZktLANhj6Rx8X3boiuL?=
 =?us-ascii?Q?zMOdHHQuy0nnp7rcr3kAla2vKkyTwpkNq8n9FtYkeAgJCEA/yjswTMWjgcnZ?=
 =?us-ascii?Q?B1yk7JYUTR76+RlGMIe1xjScVUvpwORPnS6ieoeu6zm8jzvg4GeYvM6DODLM?=
 =?us-ascii?Q?9VmYWMUXBr1Ym/cP/S5GDtm++o/HlkTq/mjsRp86KNJ6TTbTbYUfdHglOxSk?=
 =?us-ascii?Q?j8VI6YpElITQnNQ5nyRr56FzrbO2b4l2Nw9tGuAQ/r9vjqBt6P+oWj1F76xZ?=
 =?us-ascii?Q?0wbyKIpDYKB/bTDwTJWu+vpH+LsAauk8rWzI/xk4m6rhoW6s5VkGvgYnIDXP?=
 =?us-ascii?Q?AEDub9QX7bO0j6m8ZvN9Cq/uDqFCgbTuUWV9BRU3KnXr1EQgWAgYrP6vZtdO?=
 =?us-ascii?Q?Jbj6EEwpld2yjkJkBAQR2eT0z+ZYTjLtHEvL/2Ce3i/qAZQuU80uzgBFD2LT?=
 =?us-ascii?Q?k19UwMUY0GlRq7jBUFDfXEA9DQQS5b8/Y2M6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:24:39.1280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c79be6-80bd-4afe-353e-08dda9ac1a11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

seg6_lookup_nexthop() is a wrapper around seg6_lookup_any_nexthop().
Change End.X behavior to invoke seg6_lookup_any_nexthop() directly so
that we would not need to expose the new output interface argument
outside of the seg6local module.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/seg6_local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 8bce7512df97..c00b78f3abad 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -421,7 +421,7 @@ static int end_next_csid_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 static int input_action_end_x_finish(struct sk_buff *skb,
 				     struct seg6_local_lwt *slwt)
 {
-	seg6_lookup_nexthop(skb, &slwt->nh6, 0);
+	seg6_lookup_any_nexthop(skb, &slwt->nh6, 0, false, 0);
 
 	return dst_input(skb);
 }
-- 
2.49.0


