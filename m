Return-Path: <netdev+bounces-153030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2789F69A9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6367B168127
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886F1F2C31;
	Wed, 18 Dec 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KZ1D9ja2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EA1F2C4A
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534687; cv=fail; b=XQGyM5McaYEEOSaP7HdNnLXHbeOyEWUhDdIerw6tCrUfGUnI2NBsGmRNtZh4Ex7U3wCuHQ8TJ/Qh5DKRa5V9ZQGdBXAXbw7KfW72mdxq9jtBsK+an8TISvn3V3eECHYohDLWJSw+CBSbnIKmUDPyjvRUW3zWo3spHR7FGy8xijI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534687; c=relaxed/simple;
	bh=9yNsPSBsC871AVMhrnbhk1MKrfQGKCYhzYXBc5QZkDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVbbOxHT4U/d2J/YyD7lUQYmzoutYQ1JOGW7GyXIJijuhP1Oue65Ij96op8puJXYdpdnl52wQOlcaX7pSMrRZEouS8f0ymAIlU3b4XlWPYFq7RsI0SWuLvsiwQWlCXfKxrPh6ccv9NqvzQ+G1W9Fgyp/1vl4AHeoM2UTML14poA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KZ1D9ja2; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EudmoNq+ArVKu3O5had5rHYVSH2ZwnsuM7yOV93Ek9I4Y775ZUTc7ZPmzFdRlgPFyugX04cCgXNbPFpaRW/GIJrL+7oZ9pvncJjWukAb9yuVh1FUqMK5yemGRGRPYiixbGNsN7mUvzBfoHUNuw/l2DeK5uLILwTf9tfI2SxGGyiEevvDeJJLcaAg6AoM0FQKat4eGJ7MDbLV8nhwpTIpU9yfk8gdbpCToEsCwFJ70KtbJ8SXNJQ5lCWk8uf60geNjLAWnusTeb3HoZvk2QQXUgBWxeaAbi6QnlpkZZWUQaYAxPRcluSPoKdg82HvdgjcLwdB3f3bK3y1Z7nIAE/TSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9BG74MYERHdr9NL0Kfm9B9qFrEakHHifnkfDb1cdUI=;
 b=DpDDxPhk1p2b1Cj6S0rPizGtMQbB0ufW4szOvZPw7Zysgf8VjLTlxkyCXqs1GSfJvKTC8z3xPZxk0fXLMYrJVmYecs2sJnEG+qQgSLu5hVmP8RXUAGL64oBgdgwkDEOPaPQ1Sj/pC9iBjE1gBcpTfdNi+67TEDG8X9amxFN0Lkr+2WzkZ1jNguNNbpD31dHChmpEqm3K0FqSboy96TVF7HjbiqoVIf7zhvvAIm0VicSakXKlFf8WWPx3dOQVWVWKBy+GIBucSDeiwTUSy9UXR0DhHTZ1GbZ7dUlIjduu74cSPRrq2cKoh8ILzuzn1NjQfiwc5fg2f2hk+TW7yfWkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9BG74MYERHdr9NL0Kfm9B9qFrEakHHifnkfDb1cdUI=;
 b=KZ1D9ja28TvK7aZ7eSX6xzJHl6ZY2YHo8lm25OMhPH01/IQry18wSehONjZUNg9ojkdTSLeQICmEIELL+ORPmI3Gxk2qUTrQq9C0ijyuhSyg33nHndp/R77HPvwLGz8+MsutGES9VRU5jIXYhkpINa8Vj6I5e52olvhhouE13fNDZPWoh/j9P8Y4QbjDFxoAdUEIA4WmCk90bUw898RFA65mf+Hv8VFXxLsZgFTE6j7UG7t9/0Mk2Amh1uXZnusspd/7QPXskV8C5ouarrfkg0ADQSK6vcGwQcl00eRsX/DLXSQICeAU45Y+gmFZH3hSLzyLlxcsGyozLl2/6q935w==
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Wed, 18 Dec
 2024 15:11:19 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::9f) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 15:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:11:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:56 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:10:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 05/11] net/mlx5: fs, retry insertion to hash table on EBUSY
Date: Wed, 18 Dec 2024 17:09:43 +0200
Message-ID: <20241218150949.1037752-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241218150949.1037752-1-tariqt@nvidia.com>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 980d64da-54c3-400c-2bdd-08dd1f7639d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GOPNFcSm0EX2Ncg3yaAnDCo6Vm+md1Vyfz5nTNZWYlpkDuQ3uGSuUkaIz5LZ?=
 =?us-ascii?Q?B8NoU+fDFGJ+3jXhrLWST5PU05+d47+1Ine3CkLY14XUYdB7iYPxJFpbPl/G?=
 =?us-ascii?Q?5nJPWscHA5/wQhXuyIgOrr87vTuvUma3ldEJpgBMEOyeDn2qhgFvaJl7zjwT?=
 =?us-ascii?Q?fruUQC9s0v8audp3yyxVzz+YQWo6m/ZOGmJ3TaQLYE1hApWCDFeRjzRl6nIT?=
 =?us-ascii?Q?X+lK8i/Xt4QbZmLFyOViL8IG4xV9kCWgyMppR6+ouiud4y7SnRX4w5vMdr80?=
 =?us-ascii?Q?KXH1bXu5IMRw9/NiWqMY/JsnFvunrz/GSI4c1szAOeQOe64gpBb1S+pFXEET?=
 =?us-ascii?Q?3Sjo+yeXs7sabSxgD1xSFaWYGA1/rbG5/WuNIlEk8pvd4waXjz9TTMexTiwB?=
 =?us-ascii?Q?OG5qm8yKSDI0KJ4smcteaaNqlK3gQTaCbT7b1iFnts9OZN9jr8IYTxHQUlzO?=
 =?us-ascii?Q?WQ5sac4Jb8VkDs+F1F41mv+nFV2aptDskOIr00hXGpTqwQE78Bs3GXLHN5/K?=
 =?us-ascii?Q?niL36zZBA9TtbZoG3Fa6lNRs7asGRZHIxOQGggSVXB/FscptyHas+K0nK01Q?=
 =?us-ascii?Q?CVzAjqFNRm5F2Vygs4/PmhFqMSqigGzpOtm5lTbOr80wB7Hzuga7a8usbwoJ?=
 =?us-ascii?Q?L0npUkToDAcN4wqh0NGQTBDyeh1qrak3xWuKpMXsqumFt+HwXn/q6uYhD4rE?=
 =?us-ascii?Q?VeV1uxyTVZ0Y3jMRBTNizJDFP07kF889Y6dgNx513zaNxDBZSqQBlY1qRiGg?=
 =?us-ascii?Q?ryU6LGd/4gZ+IXOg9800FhwwJV9oKzzffQ/fekjbdBkySQGQMn/3VuIZhiIU?=
 =?us-ascii?Q?hih/GhuVpC/5wSzhgbRwfkaxM6rL9QyWA09mvLk9AYX2BR5UCFzZVDkZufqz?=
 =?us-ascii?Q?n5hsGB8WaDx6WXtj+4Atuzge8Y6wv/s8I8ekZok77vIfPPKqEx9gYn8U1dbQ?=
 =?us-ascii?Q?ki9AbE7N5V8bI+sl6F3pPpO7TNyG4D+trbPUsh8P2FaIb69IkzohHe3CDwhs?=
 =?us-ascii?Q?HEecWt2IYTVK7XDkEPCoObRxyPbauMgaZ+dhwov0zRSvZgUAl72+2gFXhafT?=
 =?us-ascii?Q?hBCOrAjhA++PTcNFOeb6St3ug9xzV/uYalxXtK6DIifkFNPwHHO2jcyXQIKs?=
 =?us-ascii?Q?dsY9ldX7KC3Nok2EMmJFBf2FFclBFLMw37kshaeEEGAMI2W3LqF1ZlpcRIZv?=
 =?us-ascii?Q?Nipn+z1oNt/mqGaiXKfvn6F3GDClLuUu4spSHRPfEi2zCnWSVbd6HlDM6zRr?=
 =?us-ascii?Q?cacXRSCVcyn21wAWmkkp7kPdHbuP1Zrk6VjX+6C1CdtA6YXhnTlGV/Cbu1c+?=
 =?us-ascii?Q?RVRZ1/sGlBfJ46EtHoh03B6qIhUVZcgZZwbMYV5ZBJrB2GtHi4gMD5B4JNse?=
 =?us-ascii?Q?kW9Y20wNg/AjWgGJfzCedzFPhXSsXaKYGYNk4VtnJjZ6nL+cB9V0N9mMOyZS?=
 =?us-ascii?Q?3Twe0IhsMOKCiJStKJ+n1VlhT1betdie5yd8z+ZHKWs9YBLOT9BeVrKMyYEY?=
 =?us-ascii?Q?hzCDIKx3c3C4NSk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:11:19.1058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 980d64da-54c3-400c-2bdd-08dd1f7639d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336

From: Mark Bloch <mbloch@nvidia.com>

When inserting into an rhashtable faster than it can grow, an -EBUSY error
may be encountered. Modify the insertion logic to retry on -EBUSY until
either a successful insertion or a genuine error is returned.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index f781f8f169b9..ae1a5705b26d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -821,11 +821,17 @@ static int insert_fte(struct mlx5_flow_group *fg, struct fs_fte *fte)
 		return index;
 
 	fte->index = index + fg->start_index;
+retry_insert:
 	ret = rhashtable_insert_fast(&fg->ftes_hash,
 				     &fte->hash,
 				     rhash_fte);
-	if (ret)
+	if (ret) {
+		if (ret == -EBUSY) {
+			cond_resched();
+			goto retry_insert;
+		}
 		goto err_ida_remove;
+	}
 
 	tree_add_node(&fte->node, &fg->node);
 	list_add_tail(&fte->node.list, &fg->node.children);
-- 
2.45.0


