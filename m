Return-Path: <netdev+bounces-103397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9B907DC7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96721B23245
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514514659E;
	Thu, 13 Jun 2024 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c021+sSr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352014374D
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312546; cv=fail; b=LrNySQLMAJ6jiJQ9I4C1tTj6px8B8Gw7inU6aB0HhgnsrPUr5zZ/PQNEHVVUmWcuksiKTuROtiQiC6uYGLBdqsz5BQV0hJoFhMK1tbh6354S+DZrhElgx7bMsNiUZe7MOx6FEwCJoYiNYLRf7YjRr5gheBk62ldu0y02zW1odhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312546; c=relaxed/simple;
	bh=GX5hOgaqeIPGmYqPXq6rE586PMo0lzP3sNhSYJCgd4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRPQc8SCdzPIUlswqQhdGGS3bBQ8eTbqa5IyXyHn7mD2v4rCa6xfet/EDXOllOJwz6d1igVzE9wAMWxFdURbNqvVJ9OssOL/YUNKesMCnQIpDgi8nGudqXA2h5qnIx+0yEGFEaGZ9lJl1yegff28vxtf4PsAbHk4lqA3I2N4kk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c021+sSr; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef2gL3bnw/II4NX3aYv+EoveXcZL0BByeeheIm5BRU+YziaEY71IighH0SF9TgbjaCn2ND7PpPxc2WHL2+/aRLO5GFuT3/K3Mf/4tu67UT6Eq2fAVGoKBcKuxghfyLMNneTye6TyKWZZN1v4F5HcM/WCON9k8yoSeiilQYqcjosmgzMtWv1WEE2qXh47X2fj9SqS4k7bialGLOp3mfnPn3M+M5c4CFrTecvWiGKKi7tpess78RPcodJkH6IzLvQbe4ocaVJQFs4Kd696jyfk7UBDcCO5TgH7tJNr/gkwyBWe4P0c4yi6avutPhvl1wPaJetxggaTt38mJcmhVghTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SUYibYWBM9t1esJGHQYFRFI4U6OUVh0BMZvyctCa0M=;
 b=m06jtYaKknGYsRALP3LAWdSUfLlIqn9qd0c9FlvJfZI357IPSlZyMhzkRrp+ndENHY9Vt1foVyeK6jwCjlPW4ZFM9t70c6qpnTLNhY274oKoI/gw/ty4VCFpy5kWt3RcAcTPI4AI44DBYJPw+1uHCX9bX7FKgZueepnEbo4SdIkmpA3Qf9CL0RVr3CrJo1oGM/UuD1d2hDeLm+SJRpXzcUqvF4fjeg9QYVt4Yo9hwtxS2gu4COSbkv3mfH/rCMzEBVwviO9Wd38S7tkjGLItMfaoPlbiOA1Csfq4Y1w78ArbP4tYoPzFu4kDe0GRU27ko2TleD7oiQn8CevNbwyBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SUYibYWBM9t1esJGHQYFRFI4U6OUVh0BMZvyctCa0M=;
 b=c021+sSrYL3Odyo9GpH6CwNjHD9LyTkhBqBgR+f4nOpVrySm0b1a2xGCaXfwr9uJm5olRrQyzsHteRlsk6IbD8tE8JP59+OtQq/ZiGJEB0QGf2Z64n0Pz48lcVhFEtQV2RpOFgx8DNruRH5vTuViGiC6WORcKrZvAjPREkBRdCqnnyCnHmOYybQ04Hzah2c3/Qa3Ykrb/c3UYdpcnSAlKmvxInKRHjkAbtaFHury3xzL5ZPsJbEPlTy0wboDTz/MleMkYBBpB9jDYGeBjo8OZ9sv1pgaIi8l/zmI8n8HZuIKH7s+csJJ3CpNG7rEha4LuJW/O93g1aODx/EbDAM6Yw==
Received: from BN9PR03CA0495.namprd03.prod.outlook.com (2603:10b6:408:130::20)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 21:02:21 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::3e) by BN9PR03CA0495.outlook.office365.com
 (2603:10b6:408:130::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 21:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 21:02:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 13 Jun
 2024 14:01:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 4/6] net/mlx5e: Fix outdated comment in features check
Date: Fri, 14 Jun 2024 00:00:34 +0300
Message-ID: <20240613210036.1125203-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240613210036.1125203-1-tariqt@nvidia.com>
References: <20240613210036.1125203-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 23861d6b-74db-43af-efb7-08dc8bec1de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|82310400021|1800799019|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/VZQ7W6pKqoA/KTbyyLkgGfQJTbAAZg3Mj89ZrQIIa5/B7Na5FjU0Q629lT?=
 =?us-ascii?Q?+J58dTkiLDttkBaI3XHW7OAmkRORiI9PMqVhgXezSXkylwAkziQJLZjZx1hi?=
 =?us-ascii?Q?mNiYyxGDkMtAYdoScrl7Mqr2aozqzaVhppXItswwIFhpDTfnbFdovOyrf7td?=
 =?us-ascii?Q?wqWK+tTKLLyYX5VKHVa640p6Ut0yb+7sHc6ptywygoUgtLitFT3fBK+ulYe3?=
 =?us-ascii?Q?CLgWwccDAFWhJOh5yJMkcjmoVbXPYibuKCjGXf8lkE9CKxa83xkBoGat8MTi?=
 =?us-ascii?Q?d8Tj3rKMv2C9m5LzmjOIjsHfTS18j+MBgi/sU/SCPaZWkkbjCeqOtr2A1z+H?=
 =?us-ascii?Q?aXfJeC8A5ToioUVsoz2iGOn+DoUK001Cwb08zj9YJSinj7e2f/uSoi0r2SKl?=
 =?us-ascii?Q?SeVggRgpgEGZA6e1tWsc+UQcFdCxfo2EI5PrKKyorV8gbcO08M7hwlJvEgg2?=
 =?us-ascii?Q?fedqxuz+Ftkag0EziNGasriYiqmOPHZ3mBPex6xr9fWtAHPxkhYjR239366/?=
 =?us-ascii?Q?0p+1rBPI+PMaw+Je1N4O4UHw7QOYveuNMGeb2YrwyQ+tKZbvmfxAwSrpkzyu?=
 =?us-ascii?Q?QRMS4+PMToUprdrF3zWqc+UDs6OXWV1/kXOcNA6GII5gMrGRwgmR3mjnL/RS?=
 =?us-ascii?Q?awxTwKiXxif9A5Qal2wRVFUyHtFO/35Ox9od94DA5uRd8hVnsO08BSmb7Nro?=
 =?us-ascii?Q?yc/ep0ARG33YR5g1K+zc5dbGXEnpkf0EgvUWRDqE4SmjMxVH/zpRFOaYCGXb?=
 =?us-ascii?Q?Kj+fwiHg5S++xyMQ0J9tzwxa+TyLznYozQiuJXehonMlen9pdII/cIwDWrun?=
 =?us-ascii?Q?8JGTcF87YEZyOh8NfPL2YwZR6N7GPe+WJKqChRzUo9j6UvxC7Ph5wMNw2SFd?=
 =?us-ascii?Q?zYZb11EuM4Jo1WajOgcicWchKZRQI4NHEmkb7Pq1Hgmwj58yiPBloY+n7OgS?=
 =?us-ascii?Q?fRVmS9w4GaBVK5kdweJpjRkJtvXewMGEDr7HT/aFzG6+ucb84PCcDUHaG+aT?=
 =?us-ascii?Q?Ir0o4DjLVD/e2IGRvLOfbydBlEdS+wOl9oYpwfKiZ3d6dqiKDo4wnbXZc5An?=
 =?us-ascii?Q?b49ilNT+TkXbIDEAEHyhCjV3oH7GU3XHqbXoYIgPgnr8tPosYBQSsfVQaPu3?=
 =?us-ascii?Q?nr47H2aOAvRdaL/gBNO9DEkt4+sC9KWHcxF7KP65mdcRtiyPRa3btWXCn5sD?=
 =?us-ascii?Q?kFyw56wlrnuLw7dpSVUGyI+7qexcmvWp1CXyY4YcH4qBVA9tDsRJNjeWC8yb?=
 =?us-ascii?Q?EnMLtvED417qMQEZXCxH40lhXCamx4PtnOGYlitW1uuDAwPM/wIxO/Rraqug?=
 =?us-ascii?Q?ClMBZ2fj4dy4yfhracI5TcSCGJFZ6cjrZMoxw4FD2pxgf+1s6nQYAmY1vBg5?=
 =?us-ascii?Q?mHHKyxpXNFj5hVli3qo+P4uGt/4UYiUT1303iuCdmr3cwzwUQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(82310400021)(1800799019)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:02:20.7953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23861d6b-74db-43af-efb7-08dc8bec1de6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052

From: Gal Pressman <gal@nvidia.com>

The code no longer treats only UDP tunnels, adjust the outdated comment.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 44a64d062e42..2e2b59df5563 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4910,7 +4910,7 @@ static netdev_features_t mlx5e_tunnel_features_check(struct mlx5e_priv *priv,
 	}
 
 out:
-	/* Disable CSUM and GSO if the udp dport is not offloaded by HW */
+	/* Disable CSUM and GSO if skb cannot be offloaded by HW */
 	return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
 }
 
-- 
2.44.0


