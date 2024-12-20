Return-Path: <netdev+bounces-153618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0869F8DCB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FF168062
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726631A08C1;
	Fri, 20 Dec 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ceskJICU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0B1804A
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682575; cv=fail; b=tLwnxUSrFosE/f8YvnJ3BH23upwmRMPCgMD73AxyNCs+6W/UdKwcjvfSN8/TFrPksIo/HgjeQxk0j1/YiKpcYc0zMqX9XcqFFs6LQ+cpsphUBr5DF7BIQZgLxJbatC+M06pLGnSy5oUV8Kul8yFU5DZ87YTrF3wbuOs61MsY0cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682575; c=relaxed/simple;
	bh=cR70Et8boTQOLBhbmcWInaTQiknQQBEAUX3fF1U9ZlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzN7WljenZICtZ12BM4hrsEF53wRrr/n1eaHqRVsNPUaw+c5cb3YNeh0vFdaQVy3ifxt4ggxGvmlBoMQnGu+srfsnkEpwmkVZEHBkN5n6cuPyBBiWt9Nvq6m7qLW2fPktNZ8ti6KqH9rK3wDPOwdvw49kZ8OQLfkLxpWlV4u7t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ceskJICU; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX0pjrZAZ6wAmzynp4/Thsilmxp+x80WezlmWuc95uieYh+ghcCOgwwVXCvcx/ItahDYWW1nYCNbR34H7fYZlb3nTcXHg7hpGVvqqsxK+F7kifzVz/xXY4BeE5fpLqZnjDpxwB5EfM7a2GYJMl2tROFvkInDSQR5t7nFxiF10DC7pN0QOeNWo54xFmSmI2GfQFUdYEiHFUyRMaxxA8iii4LzPkgPqlvPNSXEdswQai+lYtErXTMns9ZNBP9qqHC+olS1chjBXAjjqRsG1qVyZX0kIwcuPdSWR2QwttaVejp6em5rf5UvwV2JD/n1CfOL0GTbXjeyFbDY0/NE+ywOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kgqaa+WtZogcPOmUCPYuVov8koCHnAepsol0KOflvGQ=;
 b=fxOzZxflYkHwcYLllCESFdSRvJgMygZfPQ1R1f71Pw4ynnnNjnubPj93D93Ui0lnYzPPv6SrYlIqAap3TpupqUUbrlaBvY76IOpFQ07Vw534x3MzUi2EEDakEd7Wiyy7DDONPFrs5K2tWIcGvIXf6Blk8410kMAPTiYpA0I9PzMERsTw1xVX5Wy6uce7U7Xz2iDbuiTao3zBpi8UuMoX1UQKLCTTU1hg/AeDO1XqTbAi2t/qyLWpxB7nqU/yo4fy+DmVCDld0IbZg5mmYpaLAaDJcM+0OgFaG6Prus/Vt37nreOqh5xkHJljUSjQ42chDzZz0bu1ncOKoj28JchYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgqaa+WtZogcPOmUCPYuVov8koCHnAepsol0KOflvGQ=;
 b=ceskJICU2S5b/U9vHutaB7iik2LBdl3KZoxIg/b5+iRx9RgMinv610kmuW2WTUnkM+eA7DIfyrNUXV/Z9qX8L6pnk2rQKZqdIVIISiUui1uYgjTpJVlxMn4L9JGzbh93rjXuWVS246Dbw3SQWuQDxJ50Twf4ZAbR0sH/eF8z/dwbBKp/lAUWrJPNUqjuaCmhw+sLOZd6NAMPjJ8VlfOz29kh16GZ+XiR9RvFJTJTzU1nNcLcFW0BoltWbeik5VM80RnY3PeB7MWa74qEcbPprxX2lKKgqQR1/fL6qAB4OQyDsNPh9xLpQeCCN4ui7cLhluXZ3i0H/kWgGIXZVktrKA==
Received: from SA1PR05CA0004.namprd05.prod.outlook.com (2603:10b6:806:2d2::29)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 08:16:08 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::86) by SA1PR05CA0004.outlook.office365.com
 (2603:10b6:806:2d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.9 via Frontend Transport; Fri,
 20 Dec 2024 08:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 08:16:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Dec
 2024 00:15:57 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Dec 2024 00:15:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Dec 2024 00:15:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Lior Nahmanson <liorna@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/4] net/mlx5e: macsec: Maintain TX SA from encoding_sa
Date: Fri, 20 Dec 2024 10:15:03 +0200
Message-ID: <20241220081505.1286093-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241220081505.1286093-1-tariqt@nvidia.com>
References: <20241220081505.1286093-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: b464496b-d72e-461b-3c92-08dd20ce8ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EWdtGyyG5AJMQgcYK9GOnpi9FcNZCNiy9mhnXawxFtz853k9utlqVzsR4jwZ?=
 =?us-ascii?Q?fhX7zTsqqtuP6E/QUXl/6isvT1H486UsTt3IR4e42f9rBqTX6YyFLOWU7uUh?=
 =?us-ascii?Q?d0CsUXND+TDbebQwCMfzOmKCT++ZYakY5TAg9t/qKE/8ReiJ9w+ux+0zq88O?=
 =?us-ascii?Q?qWh7KXiPReRSMKu7eJUuK/o80k5uKdc7ew00wR3jsvNFnLUZvGgYTch7RzBV?=
 =?us-ascii?Q?CJxGFQFdmEiEE86+huKu3nt4iCe3sgvlOhcMMXP8U3EQKQstp4cuxtHZoO4n?=
 =?us-ascii?Q?Bb2OIx7RGVP6/lB0o6HyTrs0QeTPmKARVBqdbOh9d/mo/i3vOb9lUVbEMvpS?=
 =?us-ascii?Q?a8ZQsJWWo2EvBmZ14c15JipHngFgpTum+y4CEZJqBwZqHiK0+XXkr4g8Dwp+?=
 =?us-ascii?Q?yGJLokMlPJltdJ8ozDvTlB4AJpSBnhq3oTv0BYidQ3L1LE+Md3NfilMuI/dF?=
 =?us-ascii?Q?C5SX0FHGcGHtpu241y+J4nZd3W1f7eJFAV6Q+H8nlsTL//EqJ+pMZPI+o1NA?=
 =?us-ascii?Q?/XX7w24N7Tbw+zk7XQafD7D7JMGsgCG5gLrKwoPaWcCh15pX691ZqwQwmFe+?=
 =?us-ascii?Q?L1ORJE0tUxQjXR2t3lJlU7bhXXBF5ZqbAtZlYikwyjN7ym/53jOwZBlbF/ih?=
 =?us-ascii?Q?WYAdBNksJY+MijmE3pkvxYhVGuV9FNLkssmrMlecnAKL6q9hAlFm+tRMSIFH?=
 =?us-ascii?Q?QtMePfsFo5QDbyXbHDfQj2o0CQzbgJPLBXc0k7aLYDS/WIcuqBVsYwTb74XE?=
 =?us-ascii?Q?uRJqx75fey5sbIx7VzNRVd8UpEeAYwgmvNxBQviRLTAHqkDKBchgjoR5u4HK?=
 =?us-ascii?Q?5iyuYHuaIXScrolTuNZPQ0YQZWiZvpdRYOIDH+FyZ+OpZONDOYp0HGrwgyzB?=
 =?us-ascii?Q?dTXyX0gz/rpUiamULZuPvvj73hKU0Wkk5s+III1wpSPW9pUk01RU81Qdr+Qb?=
 =?us-ascii?Q?xUjcnuSlMec5GQ0NHThuLkh7vCfN+rGMHbQIN+oY8NUoTaykhLS0ykbOA5qC?=
 =?us-ascii?Q?bEdDdtShnhPc8uIVm5EQ7SkTWEZteB5vkG1nqvlTRVX5Q02PsNWAFoH/uwK7?=
 =?us-ascii?Q?sMrwzs8zHldX9YoDRsP9NbD1STBF7DfiuXKZrwLlgICM369gs5JQ0tbC6d7l?=
 =?us-ascii?Q?7rBUZ7Rfci2J0sWFU9SQZpUNV6Q1UOllavvkNKOeZwQ2EloIRhcSovSJw5uf?=
 =?us-ascii?Q?yM6Dow/lh1vNPFIEOXzKFEfSecoF+dKMuKaG8rT7m4R8mGMeZ6jTKMOkg+bs?=
 =?us-ascii?Q?32/8DIztLxXMfKoAaF9nXdEwys2z/HwO0sTAnLxTXnmvTbnVqR2wGD+dPglv?=
 =?us-ascii?Q?mJslKTeG4EGCPk6Se7lHv/JyHuqHWNmoiIoABSz+6COYXvkkZXZakwaD2wP/?=
 =?us-ascii?Q?+esfDwvn6RFaBL4ouzE67m+kX/sW1K3AmAiQERJBnCB0bcVyZE6OEs8ahAdK?=
 =?us-ascii?Q?BQTnSPSKNxFx88bMjj/UMT6gQjG/aamzGi70fzxbvuMM66T/VGitJCcaMT0k?=
 =?us-ascii?Q?hyM5nPPcEbGY+Po=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:16:08.4298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b464496b-d72e-461b-3c92-08dd20ce8ead
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079

From: Dragos Tatulea <dtatulea@nvidia.com>

In MACsec, it is possible to create multiple active TX SAs on a SC,
but only one such SA can be used at a time for transmission. This SA
is selected through the encoding_sa link parameter.

When there are 2 or more active TX SAs configured (encoding_sa=0):
  ip macsec add macsec0 tx sa 0 pn 1 on key 00 <KEY1>
  ip macsec add macsec0 tx sa 1 pn 1 on key 00 <KEY2>

... the traffic should be still sent via TX SA 0 as the encoding_sa was
not changed. However, the driver ignores the encoding_sa and overrides
it to SA 1 by installing the flow steering id of the newly created TX SA
into the SCI -> flow steering id hash map. The future packet tx
descriptors will point to the incorrect flow steering rule (SA 1).

This patch fixes the issue by avoiding the creation of the flow steering
rule for an active TX SA that is not the encoding_sa. The driver side
tx_sa object and the FW side macsec object are still created. When the
encoding_sa link parameter is changed to another active TX SA, only the
new flow steering rule will be created in the mlx5e_macsec_upd_txsa()
handler.

Fixes: 8ff0ac5be144 ("net/mlx5: Add MACsec offload Tx command support")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Lior Nahmanson <liorna@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index cc9bcc420032..6ab02f3fc291 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -339,9 +339,13 @@ static int mlx5e_macsec_init_sa_fs(struct macsec_context *ctx,
 {
 	struct mlx5e_priv *priv = macsec_netdev_priv(ctx->netdev);
 	struct mlx5_macsec_fs *macsec_fs = priv->mdev->macsec_fs;
+	const struct macsec_tx_sc *tx_sc = &ctx->secy->tx_sc;
 	struct mlx5_macsec_rule_attrs rule_attrs;
 	union mlx5_macsec_rule *macsec_rule;
 
+	if (is_tx && tx_sc->encoding_sa != sa->assoc_num)
+		return 0;
+
 	rule_attrs.macsec_obj_id = sa->macsec_obj_id;
 	rule_attrs.sci = sa->sci;
 	rule_attrs.assoc_num = sa->assoc_num;
-- 
2.45.0


