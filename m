Return-Path: <netdev+bounces-78140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A277C87436B
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05307281AFC
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631041C69A;
	Wed,  6 Mar 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ralFxd3c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE91C2BE
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766295; cv=fail; b=pnsGRMJqXiCHAhAZm4S+qjLhayUMCZsQt/3peJ7II67wrPm+acGaNknOYY9QDffKb8H4co2Y4pfEJyRP2gNxISBmLWCjIk2jPC5D7xUt/v40tK8+62362l7srgTlB1l1zzPUMWuEsMvw5HmYLJ+dLKJfPpxwj4aIZB3FaDt8rOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766295; c=relaxed/simple;
	bh=LUBo5w/m8iudlwGknjlvGrFxnmeI0rL5pdx2hu5ERPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZn4o0uHWJaHHMy+tU0iSHoLhxS2ul+5A6fsYrtKA7aC95GEwXpV8ABmRDfpNhGB4rr3u5BXThAHUUXUvQfIboEfKqEZzPSjo6zskwpkyrdhT2sAGMsf42r+CxzWAC7Hr0noS/WfH6an0NUpxKn86RJsZGJWTF4E23StgZCog74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ralFxd3c; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WedE3uN7yQA5NhCbG1wVvU53j3HVxq/a/DJglx3P995sY5fDJsRoLENsLeSkKHCVoinDC42EdYbt4yGkAkY4xLUvzXO8Eu2afJ1ZGuG2jaK2dkIHC0cFdVVXJvoHn4IfVErj3mZGaCG3E4hA0o1qinJx4Kto2Kx69Sm2XXNyd4yHnQQjwCLokfLOX5EljYOc122eRCpVqepLFgg7ebip5eVkElpwAm2wqNBhU+K2kh4YCkHIlgNFSnin/CliXvkGZ1gXbmg9jBzqWwwuNwVzYBaQkRQEFzyXnwOHm+T2KzIOGRKhTk5fONwlSGoUViSHHoFX5D6Vjq7JvwDzq0gBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO/7JEnRP/hBRJZ6XIZ+lXk/ZV8CjTZGp82uKXmk6BQ=;
 b=PtpN6GJr26Eh2tW91hyB0mHSvqO1moG6HXk3llM4h1/BKVQ7p7hWg/fq8XwnVnai57NqebBN1MdQuQQpoGWhJlbV3EDkWTLmdzn7Uxay76Vk7ZphfgH+gl1hLWz6+lkt8xwdy/asJT4Fwyb5iJyqYlQ1MYsKyzwzcOC9GOlAnyqxAi+3Qcg2mMmOws1JrOF2iG24A9zRYOT6CNpysE1Hv65GG+x951EEzAvSi1yLgEaNVECk9+l74/kclFjRNJxlAwO8T/d0ducGAt0sWyzlrp9KeyObYUB6h8m9wXKfy3u10Nkj0IBuucOGohqu8UdvDCMLsGbmrChqpjZqY/5SFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO/7JEnRP/hBRJZ6XIZ+lXk/ZV8CjTZGp82uKXmk6BQ=;
 b=ralFxd3chWdNBljJ2LIN1vkw9z8MyQ3LwlQiqW4LTXFsOVaTjDE+WCnbggH0VIevoCDMKSn1JiExoeNd6gRoThgLFgoycRe07N/uyFL0DNOsb/isioi2YrzNYqI/Occ24+g+Y6Wf8HY4o6qZQxU5A8upV/NcrMgNH4VQG2koCdK1CqUA+22M851jDeBZeoMO+EG6EOB1I/ZBMlkcmIm50RwP3NfJ7vCY9Cki7RmKkD2CeOCERX/NgcrWA4bry6IwzYectGn09GOzFE14+VuucuGblGbIM08iyVhb0bsoLe+G2N8SZuB8I77dIwzyPeozmjmCSozqsO7zY0dZd9cZ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:04:47 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:04:47 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Nabil S . Alramli" <dev@nalramli.com>,
	Joe Damato <jdamato@fastly.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC 1/6] net/mlx5e: Move DIM function declarations to en/dim.h
Date: Wed,  6 Mar 2024 15:04:17 -0800
Message-ID: <20240306230439.647123-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306230439.647123-1-rrameshbabu@nvidia.com>
References: <20240306230439.647123-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:a03:338::20) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd166b1-888f-4063-13ff-08dc3e31d07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GuOJyFvlxDYCwT4p1Hbx2DirtOty8oke+jbIf9b0kLDBWwIpb31mGq5Rwd8LAhP/LF2//qnIJMbEzlAGfZEjvIlfJrR7Epb9pAH3DFM7WLBdqdFYZqIwfAmu3FIDzeJLNeAlVEm+0p+qqupVXhdh4Q9dvC64G7DiHudlEozx9d/vMjVx1HrpIBCVhVmFEV/4Z2sorh6oQvf0iyYtULA07JcoYhtbz/revI7GhpmIFZLJu/oWuEPpVZINg5YxoLvwYf7DK2rQCMCGY1KfLfh5e7g2nIxCPU6Cy4Di41T2+GI9xXHYJ6FEUHXPHy1bq1vmpbMKIr5pEjWYYcAd1EmnYHAOIYABscJ+8aPxqNVCy7+pTFquOEhGLR1uXVKLaHr10uYZShdjV/LQ6HIYoiY7odmBeePSlAcQuNDh0qpk654CkBRGxtmavdgmnqP7ckatKeDHfiPu/yfvin4Qp1jQ+ZpOWlw4JMhBaB2KMaYRtuYQAk9Vx3aGEcBy3jxzAQ0JWdp694bqOltxcEcQz/XaHoWycj7n9Q+vItnMBk7uU3/xLQ3sf82qZ7RxOGxtv+qMcsR0bf1Ilr02nrVhvnKlCFEc/10YGbtxCAju8CRhCuYrLqoLzuGTXq1x7YQ6SiPVHNkhG/WkOeAOupHYMRvUWw7Q8O1QPv+BZO55q56OnyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h3e8YAtkZMq75ZTgVV8DZnGg/IliRu5/FviJAENItVFJYjgvkZEk9db3JZT3?=
 =?us-ascii?Q?jPYM1JLEvJJ09S5xMaX17MKvZCrxZRxImiJ+kpP/WTwKRGx7iDRCllk7S9EC?=
 =?us-ascii?Q?6M3WmkIoiG1+6Dt2AfvBaDXvwg3gziz3NebyvEA69sOpaFZqFZvEbzF3v4oP?=
 =?us-ascii?Q?CLKAmr883D3c4jsirzAAFoJRqN+kG622WChq4DcuO9viSnmk9PqOWEb7y6p8?=
 =?us-ascii?Q?1lKQB+WoBUlAQ69zw5qxGllSJ7pFWbxM/zPp2NH2jvqiIeybjFoKavsI5K8/?=
 =?us-ascii?Q?sNfWfdE4G18Heg/OBQGVE+SlXBw1Oeq6ASEsTgBagJ4DBbh6RNRUhYoNMpAu?=
 =?us-ascii?Q?316U32qzjFZOUCWseomgOHCGJs7UDPdk+j9EXMMmXn7L0jzcNRpx6W3bGCzv?=
 =?us-ascii?Q?8aeD44hLAivl/ZL++YNK73y6B/Y3s/mMop2HARLRPrQo4g/QZxRYi9nwmsup?=
 =?us-ascii?Q?1T6r/UDJOrlDieqf8KT6oEmqpExFYBVat7R8sY15f+MVsm02Ci3fnG9zAakn?=
 =?us-ascii?Q?jXWieYDC/hM//P2N2cm9/tIbpF1Z4YRvjQF4k/omT7kmrZrAQByYDZ0geDpy?=
 =?us-ascii?Q?dVIzzpvbyKN+xR0b3AYqSudV86VcNiBfJ+iLRqiJWKv4UXNak6AoATZUJ5Gd?=
 =?us-ascii?Q?mXgxpW+FhHhKc8ybDda8t2M6Y7iiCoi0u2HNCjfUzjc3OXtp6kskQso1fsrY?=
 =?us-ascii?Q?gFmJEpsU012tI6PVwcUR5r0NmP4koC/nJQ6utueq0uehxPVx29A1oKbI0wLZ?=
 =?us-ascii?Q?YWhueUQSBG8qQuptJedW9FEcKZ9+saPzG/qDkfDNms4l3imGzwkHPinAI2Zu?=
 =?us-ascii?Q?3IqTeBrI98JG/50HFbT4yy7N22hLydMwLiXT7G84C77l0WUmqxmKt80CbOwr?=
 =?us-ascii?Q?VdiH+YRSaesdbau4czFGmMKkUbWVQ67tZBhESo5or1ryOlUNT41a1aosImbc?=
 =?us-ascii?Q?j069e68+eVDMROuLXeJ9Sz1q5HZI+t+tQtcZawkD6PqUVf/yfhdlk9HFAkw6?=
 =?us-ascii?Q?KqAX1Puf9TeBenpjIr7/UkyLJdPdR6aAXr9atHDrqMoqQYst9f62lLIS9ZKk?=
 =?us-ascii?Q?gOEnL1cBxcvnyyxlZe35SJcWqM8CLvNWF1K+LnX+LWp6B8gvWSdKam17/dZH?=
 =?us-ascii?Q?QXWDUL8AjesXY+++qxnaUq5PcoGoWaDHH52OVE5YDlDa5Bg4ba8RQzXx/12+?=
 =?us-ascii?Q?GQyC1q4n25jv5xTbdIQo7WOqX/d6CeC/RWNP1ZFYJa51LY7a0nNohbegg6T4?=
 =?us-ascii?Q?avAEW4JxQnEM09+5DHFi9oATVZ7BvJMJJUz3/x/yRqfRe9IuvCw625d0wNxA?=
 =?us-ascii?Q?9byQh+xXhDmCOI/y+uUukOv910guIVccE79c2pPT7ScFpkg18qXZDEuKntIi?=
 =?us-ascii?Q?QCoZRkwH5NPXvU4XmbYCZ8ONZEgHoYDzqnK5pKE7J7JvAAvZXbUZrPWXplLY?=
 =?us-ascii?Q?4hea1owlSsGuFQtB21ovSOaStxpW2eoi78ACDnEzE16iUBeTIosKmUfsytxS?=
 =?us-ascii?Q?UswYvQ9mEsvYFwosvw056AQ3XpYJABkglVDeM3injFgHT/J0x9zbGW0CVTiA?=
 =?us-ascii?Q?EhDmM8Do9l5MxShaDKDRP8qXfL6NtRlbww/mYiTOFb/aC3MmQ2v2qEU+bBbO?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd166b1-888f-4063-13ff-08dc3e31d07a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:04:45.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 140rpmz07bebloQZxoFv9jQqx32XB9yd6S+ficN/UDlqiW/3iarFS9fK8nN3ZkWx6EdH9tOlple4YpWAcebX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

Create a header specifically for DIM-related declarations. Move existing
DIM-specific functionality from en.h. Future DIM-related functionality will
be declared in en/dim.h in subsequent patches.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 --
 drivers/net/ethernet/mellanox/mlx5/core/en/dim.h  | 15 +++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c  |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  1 +
 5 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/dim.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 55c6ace0acd5..2df222348323 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1219,8 +1219,6 @@ int mlx5e_netdev_change_profile(struct mlx5e_priv *priv,
 void mlx5e_netdev_attach_nic_profile(struct mlx5e_priv *priv);
 void mlx5e_set_netdev_mtu_boundaries(struct mlx5e_priv *priv);
 void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16 mtu);
-void mlx5e_rx_dim_work(struct work_struct *work);
-void mlx5e_tx_dim_work(struct work_struct *work);
 
 void mlx5e_set_xdp_feature(struct net_device *netdev);
 netdev_features_t mlx5e_features_check(struct sk_buff *skb,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
new file mode 100644
index 000000000000..cd2cf647c85a
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved */
+
+#ifndef __MLX5_EN_DIM_H__
+#define __MLX5_EN_DIM_H__
+
+#include <linux/types.h>
+
+/* Forward declarations */
+struct work_struct;
+
+void mlx5e_rx_dim_work(struct work_struct *work);
+void mlx5e_tx_dim_work(struct work_struct *work);
+
+#endif /* __MLX5_EN_DIM_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index ca9cfbf57d8f..df692e29ab8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -30,8 +30,8 @@
  * SOFTWARE.
  */
 
-#include <linux/dim.h>
 #include "en.h"
+#include "en/dim.h"
 
 static void
 mlx5e_complete_dim_work(struct dim *dim, struct dim_cq_moder moder,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cc51ce16df14..9b3bfa643fd1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -33,6 +33,7 @@
 #include <linux/ethtool_netlink.h>
 
 #include "en.h"
+#include "en/dim.h"
 #include "en/port.h"
 #include "en/params.h"
 #include "en/ptp.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index be809556b2e1..7721d7656aee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -43,6 +43,7 @@
 #include <net/xdp_sock_drv.h>
 #include "eswitch.h"
 #include "en.h"
+#include "en/dim.h"
 #include "en/txrx.h"
 #include "en_tc.h"
 #include "en_rep.h"
-- 
2.42.0


