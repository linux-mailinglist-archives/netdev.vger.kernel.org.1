Return-Path: <netdev+bounces-106457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CFF9166FF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1622EB256DA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C6157460;
	Tue, 25 Jun 2024 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLe1dFU6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AB14D45E
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317334; cv=fail; b=HLbFs5L4mCw6SOK7JBnMR8AJ4TW2QJwXY3r0z9s7kLLp9tHSt0IaM16C2aWkY/mn51RhqHRv8qTBFYKjdOgOiyrAI3hcpJ76ouO3BY3Si8rjIWcP+HUeazQ4DDOE3JN0EZgXJk7K+HlDmRJoU2ZbpqMda08WnD4gnvzueXapNB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317334; c=relaxed/simple;
	bh=kvexmGOM+20u9zBGAo4tcZ9yrtdZJMnKe2kZxuog2a0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAij8vz2RoAK3kZpUiH/eyXfyldG1os3Aj1diBlyoBLYQ+0vGiUHGfcBDmHcoSxadu9heAQunCTTyeiqLDnB2J+jQK1bB6rgibuvVifJoKndZXVrEIOTpRF6gk6dz5NQb62Luz5TMxHi6JOFFX4lwSnR2FciwSwtmvx61+LM9hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLe1dFU6; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYCeRSD15KK667OfK75+5Og3wWcqGIFrpmDsjjmaHLGAaGjXT3TRqp16Std3P5F5IqvUND7EiTdOJvPItj0lXblVHqd658sOdDQN7fRhVtBJmaqyLMLO+O6c3BnpQ51VqVdgPPhAF5fnpSjayy54OSreOviJkoXTcshmbsvALecCY2kdPHjYWHSz8YM7p/P/leU7x1RAllQFR/D0X0jNCFOqJRr08LCF4z++DKZLICvErj0umoX0kDuJok8F/61UGZHWOx5+WzUEUKBOtHddQRd0lAJWpyvH5VXH7PflxWBI6s6l5jZxa1a5epGPlkzVcvRZbXe3whODXpRgDrmW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=401wB8S3y7ZdCdLR0MfnDr3+2MPnws7NgvfXzPhZ5Hs=;
 b=juA5DYeUqfckgjYcZhiRKjbRft9/zelCcjWjEO5liSaqwqwrRoICJPYr9MdQvqzIQQUGKcAxkWH8GAnklWEYJ1PaHHKEnlZQN8CZceruS6SoWGXhjs6SY4QQX1FmoZM4T9v65Nt9TWo1ictHfxq3rdx9PS475sjPNLOGfvZQiX4bRTjKHqEaqs3LQsHAIXxQxJTV4tBCQL1NAUZmF0iQK6xP7oDlc/rOgB537y7uTwOX9PS8C24pqB8vpJg/L3NGz6g9PhKEMRjfA+oWsRWXVnHGwiX6sHNnS17j6y7XYuDTMHk/26le/jPEV2prz+PjSeTFJiuyQ2GLJKD4iKqaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=401wB8S3y7ZdCdLR0MfnDr3+2MPnws7NgvfXzPhZ5Hs=;
 b=dLe1dFU6snp+1YdlHXC5r2XfAzL00jQ76JOevlO6WubanCP9s3dReIUoKgNxXh/Prxm3B78szYFBT6QPCNN/qByREqGYh4H1+ZxZD08oLmdHgdBfxbex67x930Qjm14bVZAuKaFCqDZourUp4T5Szo27EtvttmtqMULMZglQ9InzNjbRxHPMBJ479Iv+kfKbPwUWRaeVJzksE1+hatBbynLChez0oa3foZvaAtC+/dBVLtNHA2E1BPeYUvwygmhWneBzIgQPiWA/Csn/O6NgAidYr2+CHNj7IvUJfxKEA3Tfdg6dRrwkdMPuNQCYIGNnmbkE+R4WuVqTpAoWLMCZRA==
Received: from DM6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:5:15b::23)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 12:08:49 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::d0) by DM6PR18CA0010.outlook.office365.com
 (2603:10b6:5:15b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 12:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 12:08:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 05:08:31 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 05:08:28 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, <netdev@vger.kernel.org>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH RFC net-next 2/4] net: core: page_pool_user: Change 'ifindex' for page pool dump
Date: Tue, 25 Jun 2024 15:08:05 +0300
Message-ID: <20240625120807.1165581-3-amcohen@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625120807.1165581-1-amcohen@nvidia.com>
References: <20240625120807.1165581-1-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a6874f-9c7a-4c1a-e186-08dc950f9260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+KtXbic6O6a3gYuAp5C9wV6srrOWfX+OPiku2t/0a2MpbchkeUlRIJVFEfe?=
 =?us-ascii?Q?IYt6JGsIgmmiLeIRyhEcH+SwsQeimLkkRbMkkEItbrbIF7OiT3nVC+Ln2SGs?=
 =?us-ascii?Q?iA/qi0FMtHsMnAoVec6Aa8pGf8XmFkHimecy0Xt+vHxTMAU5uGvhCQZ9qr/u?=
 =?us-ascii?Q?vBPvStV2r+KGWV8t+jUJUKI9LA+ERlVJKJq1CaRjvFdoYWHFRO+Awaz3PQ9f?=
 =?us-ascii?Q?VEjzJBuXi5sMTcAd9OpmeyAQ/BQNP9Vnri78m6WoEMKXgGw/R33DLz/ULlXu?=
 =?us-ascii?Q?aw0fDCRKB1BMJ2xxoLpHupuN+wtPYM/l1js5ZoN9LiYC563cFnpnT00HIs7i?=
 =?us-ascii?Q?nU05EKGzUbo4eX4mu4Br2s5CYs4KAJ/l7XTFjILbYz7kXhKS8XDMg5nQ2kWv?=
 =?us-ascii?Q?gt4RvP/UB7sKjtZZt9NvT7zGFhW1Nx3Crxfl6pCLyikCnDmrTCHdgrtSlATp?=
 =?us-ascii?Q?smTtYENwJB/886KeKxfExVSTzHkWg5VFEd3NRuc7toiqqonpF1wMuEi4dr6Z?=
 =?us-ascii?Q?1VM/EyOlw4yUrYbMFQpGjskkqY3J4OvpBli11U/zPR+1Abew9M7bmQFy8dRR?=
 =?us-ascii?Q?Zlr2Q+H+K/+zYSiIQGTOPosnfF9asIIeNWgFB0/rUkJDFu79Zq3D9DpT7TMh?=
 =?us-ascii?Q?aGdsfPHsztb3UhqygqMlM7T0cmUia21m8BNT9OnyTxUpilTx9M9lOkksgAl+?=
 =?us-ascii?Q?HA3h8x9VsLe759xIvWmTMJ/x4pn+GhP7mzYpvsiXd6YptdTbwn7KaH32j7V4?=
 =?us-ascii?Q?LLftD0uL1Vi8xA4Krh0c+40fU87/9Ier4hwstUxuGlqWa7XprYdfmGXcOZ3n?=
 =?us-ascii?Q?XXq1PymAxuzKQMK9MTiITUImcR1hHNT04LdGyBeQVJGpWG8qCFpVSWCXaGTS?=
 =?us-ascii?Q?gdnLwXqqw/LgHbSl+Z2G4ra6wgFWlqPLziLb1DW4odGVPk7B0jzs4KIjBG+L?=
 =?us-ascii?Q?FLvciiuAbVY5C+IQSU491x/D558xzZ9HpiGKfNMPMpsZoDVDHdD8c0a2+Fzn?=
 =?us-ascii?Q?UPpMxYSTUJ35HdPlyYE1W8aPK+C4hEnITzgPnnods+OfOrvd6DPSXz7IsnNi?=
 =?us-ascii?Q?jYHR8K28aWRxAvwHmSKhprCZXdsXvzZC4hkJ26JR5dIJCaVAjq7TiTHj8Kjm?=
 =?us-ascii?Q?ZfQQ79v2x5rOdPYxaz8r4JXM+YHVFiLvwQK+A7tv0ZeJpa2uBxz0tl1gxhlh?=
 =?us-ascii?Q?T+gYvZai2AiTKFXD6bZdLHzC/8qBXzwllwPu7iTQ9w23ieonPUBD1jQ637WU?=
 =?us-ascii?Q?DfnCtTZEeZ2N4dkhHojGaARJT5NGhIXAd2p/F9D1mwQEK6qS+NzdMcruNWuF?=
 =?us-ascii?Q?+WDIQwegSNCgHT/crlCiOIjkDbxUe+1n5cx/A988vsrldPf0lAlbfMJc+3DD?=
 =?us-ascii?Q?wQBRZ658O5qCEnlJvmT2o1qiuRYlFOv+0Qf1mv+Ox+V7vu132w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:08:49.1232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a6874f-9c7a-4c1a-e186-08dc950f9260
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162

Currently, to dump all page pools, there is a loop which iterates over all
netdevices in the relevant net, then, for each netdevice, iterate over all
page pools which are attached to this netdevice, and call the fill()
function with the pool.

With the exiting code, the netlink message is filled with
'pool->slow.netdev->ifindex', which means that if a pool is used by
several netdevices, it will not be dumped with the real netdevice via
page-pool-get/page-pool-stats-get, as this pointer should be NULL in such
case.

Change 'ifindex' which is passed to fill() function, pass the 'ifindex'
of the netdevice which the pool is stored in its list. This should not
change the behavior for drivers which has netdevice per page pool, as the
same value is passed now. It will allow drivers which have page pool for
several netdevices to dump all the pools. The drivers just need to
make 'netdev->page_pools' list to hold all the pools which the netdevice
consumes pages from.

Note that 'ifindex' for get command is not changed.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 net/core/page_pool_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 44948f7b9d68..ce4a34adad8a 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -92,7 +92,7 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				continue;
 
 			state->pp_id = pool->user.id;
-			err = fill(skb, pool, info, pool->slow.netdev->ifindex);
+			err = fill(skb, pool, info, netdev->ifindex);
 			if (err)
 				goto out;
 		}
-- 
2.45.1


