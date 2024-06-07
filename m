Return-Path: <netdev+bounces-101911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C6900877
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997C61C20AC1
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE51990CE;
	Fri,  7 Jun 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HQ/kCXAv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04749195999
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773321; cv=fail; b=Ww/B/N5eB92g0lHRbawWR5RZ/USmjErWOBeMMwm0xBW1esVZ+DeoMl+D7ykoWT396G/x+UsHueAo5BaczNcpm1F8exZa84tAAF3os/vHo8CLORExnkZt0qhHjCBfloEN2MtSBygS1LjW0boUKTdKwAuzpwFQJOh5fguvMPW8WWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773321; c=relaxed/simple;
	bh=YcvSLs2LU3INVOOeut4w4V7clSoF8oKqm5Z/n3gzDrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bj3ivTp6UeNatzyW6yQAFBaBVT3fuzUlo9h9+dwcPMLwwmHLnP5N8cf3DNVwGifgih8ZSa4KTDobf8OOHHErA7MPuO+aC53UA1kP+XlKOXUkwzvxFtWQgL60LFgpdl6u9KSfb9TRM2TsaodagsVbgIGdl48YjnHbC/uCzWGc7ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HQ/kCXAv; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJp0YryRjZEl12GtM4qF7vfBFDHcfq9Tu1lUVuGFvzh/o4FACbWd1W++XvGG2Q6VhbhTDvLuiRt9m+hw3l6Kfp7NkfuoFv+j/Kc6wYKikHAOc7bmTu0qnIkLdFH7PA2859Fl/I+5wGs4HV/tXw80AxrcrfVv3x51J7sS40TWthM8QhU8Y0/0lGYqm/kWItIy6AXoDs7uRblPMUnROhu79++v0Y0bNRNEzxJck6rT770mfJ3LU0myXVmfsH74gnWVl6Yd8/rqzA4Z4wTaXdAynndKGcmcr6BXeC24hrTQKhfoh7vF6HtplHLYZD87Z7Tc+3Fh46R0ip0go/At/1gtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqDEVXIY8wIC0A1XXD36OZ818h/X519G/2xgJixeNZA=;
 b=mw/df6p0YUd5TWlTOPLaI74mvWKzN1yOoPBzLp5DC517a/M4kLfby1KVlam/yIydCj23r1PGKf6GbuISXr/Cp/9jISaiVk/rHWFzutpJVyI22PNSI6aN0NjNyCpFG/yk7yGjufH7VdQ3Jtu7McC4Q2IlmY6mo75zAbieRqquZtr5vdWwTTjB7jNOFVxGL6YygXSjyFYA23eLMiEpc0AgNLHaR3lFHQJjCH/l2Os5gkYnU87FzoGCcHxfJgQb3zHwzTvS11dWDsmrW91WpZI0PnopGIQs2nBtkoqeVl0erFXouSB/NUQmrXAJc496b9CTDcIpimtRYCu0LqGKCB9KHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqDEVXIY8wIC0A1XXD36OZ818h/X519G/2xgJixeNZA=;
 b=HQ/kCXAvUET63XkWlH0wpigm/jsumT1Xoc45RGMetg2KZrP37pqPs2QXqB/3HtHPqcNFgEuV8Gp9kNvX9xHA0Ux6y7EpMxW83e2TUwZT/AsUOvkmQzqjrzS17sDh6yPSWivKPpuwWYxPa5hM/acC1ujQNZX2cmPy8WKZ/coQS4opCi7W1M/4yHmw6tRbPoEG/ffRK2ufNjLT3iodA0n9MePMcZ7+GPDG1DTqwuOBgfcb8p2rnwXK8bNGDzoKritH1CHXWXEdoAkv2ZFVU5BmmbJEA/kchRNAPoAQuAAq+qVJzst77OMVOgb//XEW5enKWaukBEBmOioK1Bh7QB1ayg==
Received: from MN2PR13CA0014.namprd13.prod.outlook.com (2603:10b6:208:160::27)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 15:15:03 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::a) by MN2PR13CA0014.outlook.office365.com
 (2603:10b6:208:160::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.14 via Frontend
 Transport; Fri, 7 Jun 2024 15:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 15:15:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:44 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 3/5] mlxsw: spectrum_router: Apply user-defined multipath hash seed
Date: Fri, 7 Jun 2024 17:13:55 +0200
Message-ID: <20240607151357.421181-4-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607151357.421181-1-petrm@nvidia.com>
References: <20240607151357.421181-1-petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 384a7595-59b6-4cb2-db64-08dc870499a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eCGicibtTcfUYh3vmIzAVlLo1mntg/QYJn99Na0nO/IDTTDWOyEV6V5kZnK9?=
 =?us-ascii?Q?7HFj568uPYS8c4fuim5pstyHH5h9XuqtaohvUIXKfP2jJ98hycZ0XNHf8zVb?=
 =?us-ascii?Q?byXg9yKjLJ1z7DV25gtP/SK2NFrTkt+1WR6Yy2zp6ADne8Hl6d6zDCyWi3t6?=
 =?us-ascii?Q?AGwKc1rRoe3qnZL6Dsxnqq7WZI7fXf/tNw9LPeC+lavS1jGpCa/1U9bROzcG?=
 =?us-ascii?Q?R+6AMUb6Wmb4TZOWcMBMMqMd3xUAqNfkOdio0J8LiK7noChd7j68hWh8pXSr?=
 =?us-ascii?Q?CeSmAapqLpMls/3W7HBpkYIKOi/LlxJMXe1rt5bbS+LAYUStcFcOCbbpS5fF?=
 =?us-ascii?Q?NkMhx2cRCIGxUvZ5ZRd0zLVqeXGBVeYtWa26rTAmejOL0lGlVbMflBbrAwX5?=
 =?us-ascii?Q?OpVqAurvnmq8lp1gesjmVK+irpKTU/t2v1FhULywvgHshrrN1CK6iVTwl7qH?=
 =?us-ascii?Q?RmrE0rG2tIQgaR+UBFeoOgOhWQYCrmO0e5BqKk6C/FKUIx+WOR3r4Qv3EXV7?=
 =?us-ascii?Q?XTGJmZc0iZG88o8GEbwagMYsqzlgNkVG5FXKZD/Gq29rTbdRDRqWwLQS3T1N?=
 =?us-ascii?Q?8YNZPZqa37hJc4Nj51qdAR35pjmpr9wsRnQpSXnfh+3d5WUbcMlVM7t2wIGJ?=
 =?us-ascii?Q?Cbvu4oZSinm4c6/3103zNT4yelK9GTrLCudzz40cvtloocoSUZFA2EnyV+OA?=
 =?us-ascii?Q?2jNoWipNd2bYxSBfl1Q3/Up9bpzm8RJ+AC8mjM6TYRfm3U9K2iegp7gxm0Vj?=
 =?us-ascii?Q?C4oiJa7q8Q6LHN6501fK2BioJ/z8+XzL4Phdb2uf38gKCcIf8Xwgiv1YqQPY?=
 =?us-ascii?Q?SGfNzEXUaVD/U3T8FOzagN/pmltW7AKFeDezXbi4F7OOze+BSMPu8HmD6No0?=
 =?us-ascii?Q?rWXo3qhSZhWdfZe+Su8K0MVUBUmKo31Ep8SMy6AfjuG/ih+XL5GhqUfTxyy1?=
 =?us-ascii?Q?yt31zRc74cJbO3Xar2ZPtsCug1Y9jgHcr2jCg+2OaB8LzRasItYnBU5GXhY1?=
 =?us-ascii?Q?cDkFs8nijdPvztxuENtOoW0adiy0IOzDp09LFE6uaNYcfjw1gtK1ACcCapMb?=
 =?us-ascii?Q?OHW4/w5KxUvVtSYpk1QK3M2ZonFGz1svWjhMmIN443SE1XBdfrMYC06eMhV7?=
 =?us-ascii?Q?L/QF06LY8xrseSXnV9oi0HJFXm8ynK7nQGjcQK/OnbOEFOAzqGdpZUEhgjaS?=
 =?us-ascii?Q?4ljgSEi0kEUG8wz3ly1ww7DEq9QpcaD3+LQZVneNnrvHuOzzb0iHv4tl6vCx?=
 =?us-ascii?Q?UAiipQBspuSzDNioMBDkhRb4C2yvH1Us5PtIH+QdhjLBykjqlX1HjqpYQ1wo?=
 =?us-ascii?Q?Ac6z0ZV9Op0B+UYLlrXFoDmseykMr3P7/9kyzOlZrL8xizNdoplUFEhWZukI?=
 =?us-ascii?Q?2MwgEBWyTvvCuB5zjzaPhxHSjoChM6dfPJFzZQ5mFs+02E9V+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:15:00.4877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384a7595-59b6-4cb2-db64-08dc870499a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

When Spectrum machines compute hash for the purposes of ECMP routing, they
use a seed specified through RECR_v2 (Router ECMP Configuration Register).
Up until now mlxsw computed the seed by hashing the machine's base MAC.
Now that we can optionally have a user-provided seed, use that if possible.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    - Update to match changes in patch #2.

 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 40ba314fbc72..800dfb64ec83 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -11450,12 +11450,16 @@ static int mlxsw_sp_mp_hash_init(struct mlxsw_sp *mlxsw_sp)
 {
 	bool old_inc_parsing_depth, new_inc_parsing_depth;
 	struct mlxsw_sp_mp_hash_config config = {};
+	struct net *net = mlxsw_sp_net(mlxsw_sp);
 	char recr2_pl[MLXSW_REG_RECR2_LEN];
 	unsigned long bit;
 	u32 seed;
 	int err;
 
-	seed = jhash(mlxsw_sp->base_mac, sizeof(mlxsw_sp->base_mac), 0);
+	seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).user_seed;
+	if (!seed)
+		seed = jhash(mlxsw_sp->base_mac, sizeof(mlxsw_sp->base_mac), 0);
+
 	mlxsw_reg_recr2_pack(recr2_pl, seed);
 	mlxsw_sp_mp4_hash_init(mlxsw_sp, &config);
 	mlxsw_sp_mp6_hash_init(mlxsw_sp, &config);
-- 
2.45.0


