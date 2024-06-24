Return-Path: <netdev+bounces-106023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB829143C0
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FAD1C21A11
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56845027;
	Mon, 24 Jun 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cqUsqcRP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13264085D
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214307; cv=fail; b=G8WOQ/KhSZ5dC/kKje2XyPSOzf+LLWBBWS2Xb31GPfgRd073Fq9fW9N9Qm2WbTWHqN6ktnCiXxxrbdzSOtSjHBZKhhWpWkH/uQPwkiu62lnyQwDhirpKOcHhWc86VjhJxUouEc/nuxMw55aqMsm5xd7g4zj5RfRf+y0XrGiAnfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214307; c=relaxed/simple;
	bh=lk+e2QqIMLXks1su1vtDkosoZWYpcTW6x+CK+9QHOpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gojWPhcGUJxWLQ/5IouYlj8448vofsyTxsWCyFZyBWx1WVqTgokqFsOApIj4uw8x4Fj7J8OorWUULu9MMOzzAFdKNgXI/HDmzyWITf/G6RqqbZ1/coUnb5Z5meOc6h0MhnquoYs7jrBK7XSLMRkTbCBAxqRsSyxakgsEpsGQvTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cqUsqcRP; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYJeWYJ9Zpphjmnq4NCXuAnDaa7Q9R3jnWYPL/aTC7SJiLcYFmWXC5imaedHtE/WLFRvgFm65RpcvE4l7vMEODCyRaikWE7BaecuYq8MT5mCyWRN6Uhqn/MmpKjyOlv6oTrKwRbaxNGO2x5f7EGVV71PZBLJPi7rOmEk1dbpyH1LqXhHagJEQKpewoNbO/lJJszKF6/JL5lFDhERaYhb7kVR+/ScdkbW+VL7vbUE4evIWEZ8fTn2sEoQgA28OOby8WbpZulOB18BFVkBMoj3bBsN56+eGeTrswiBAbX4Yi3Qt1pVIknz3udfS37iox2CnYi7nbJbjBoItjCI/FAlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hCg8VCZDzUTSCudGzKrdIi4jPS2FNL+ci31fPsRHK0=;
 b=JE/IldjYxROP5hvqQ72yY0OJVPab5qkN9Mgm4wOsKH6U66qurylJeS8EW4DOwc7RwveQMpHgfguxi8KfEhrSjT5XyIOaLxX59g9oo3g/VgkCCiGWUSX2HyQTtfGF7+x83Z8dNQlYWiMx97kQByxCkVz9H9lCG7cLU/s44TJmQXKbkyhnRFVe2QJXbwm71+bCmSfvPKHU87HgFNeTng67qpPLxCW+dUF/+6h4qi1qYfNwI607vGYS07+grup4nZO1L19F2K6jFjtzGXZDGFx2KlncrQz3I5+tPxfAgRkIaL6x+HFv1EiT6z3fF71pYKdU0fAH8XSBlSc8iSTGiKfLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hCg8VCZDzUTSCudGzKrdIi4jPS2FNL+ci31fPsRHK0=;
 b=cqUsqcRPTKTSiw5MOnXUAdjzgr99fRLve4mxs7w/qjO2/11Bxgb0Y6lGpN7evLMMVCSpPw8EhDbCM4ZJ2/0Zoi6u1CPkmV/ZijnJrdOAypTTS5wSitWtj93Ajluzsq4ZzuTZDQJsVFM+UoN1+gwjkkjz9RUbgnY1B+vN0Wqsb2Adc6V7+75XHyYv06tJgJg8kYDCFETEcnCt6lQTOXq3TsaGunrSj1WuiR8Grn6Zf/zCUzFcJppHjoKtZgqRoK6JwjDZWiP2dZBX4N9k1DV8NxjcAPiBs1NtDr71RPyiNX/DelrArvLMSgNkXV/+KRmK6ypWnBLzoahag7p0grIUOw==
Received: from CH2PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:4e::23)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 07:31:43 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::f3) by CH2PR02CA0013.outlook.office365.com
 (2603:10b6:610:4e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:31:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 00:31:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 00:31:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 00:31:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 7/7] net/mlx5e: Approximate IPsec per-SA payload data bytes count
Date: Mon, 24 Jun 2024 10:30:01 +0300
Message-ID: <20240624073001.1204974-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624073001.1204974-1-tariqt@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cd0f3b-1064-4773-0c3d-08dc941fb1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yilRXlYSSl/LmUExCl3m2wzDm9CvF5abmtLaARzk+A1dAu6foR7jDZxEVBtR?=
 =?us-ascii?Q?GAq7Xsok+xT1+hJuz6YlML8z4YLiBdsdw+nfzBK9317sLPUOy7v6shwEAeif?=
 =?us-ascii?Q?3VE33mCg21NwHT/q2hlLszbgtuiBcZg7LJud9dhhXN0qdaBmFu+Wy4GrXS/f?=
 =?us-ascii?Q?eFc3s/GvTZrpxsvHofZaTBh45hdeBvQO3Z8W7sw5eW0ifP4j/eVf8WxLNTxu?=
 =?us-ascii?Q?UCWjSXOqfEoKxQSCSPsGD1vrEO4Y1U4Z5I5+jGwu3SbWouxagVWH/vA+z1hJ?=
 =?us-ascii?Q?ddwltokHq3WI5DVy8CS8gbL6c688V4NMYkGki4rKl8qOU9Vmq6XRIL5p9Ak5?=
 =?us-ascii?Q?9Szg/lR1vbGV9rUgb6YmPvmC4FH63wPj0UNECxyFKH+PGqkEV4kce9Ep8BDV?=
 =?us-ascii?Q?6DmV4uNaBBuS2gVQaLPgAv6V65qUw9Zac0Jz+aYHHMuUtlOEmS6EDZYwgsk1?=
 =?us-ascii?Q?b1AlIeP20gPOLHbokZsX8vgu5Y8PyKklO1WizIFdsj80k03uxfikkhB4gf3Q?=
 =?us-ascii?Q?6Su4VCZL5dRtDmngdLJjKLMqbUohrw9vjzgUobn1SlXp47C4upQjT4WiU3Ax?=
 =?us-ascii?Q?eY58r+eyUXrRISj5wXQRq0RsJPAwS6lhqHtTnUSBpp4ZrVg15QYhJAlRTLC0?=
 =?us-ascii?Q?x4fXeODYEzZLZTq3g3yMO294unlaCgocGt3i0KJfjt+TAJ/4v3sKBfjrGr86?=
 =?us-ascii?Q?hT1nFYVnpHydYNfaa9lEeLC73QgBewKMk2BOmcQICsjMVNi1E/e92EEYio6W?=
 =?us-ascii?Q?fteU9xHnAUg8Fq/VzbTH/G5WkqRVMuPxvpvYRRsd+6c2v/1GhhAGd9LtWWv4?=
 =?us-ascii?Q?aadYkYVuKqMIII4MqU4gSYKQTzv+NyFvb3sunvfib46TV4O66TrUlMLxYXpW?=
 =?us-ascii?Q?fSNSNy6884fWg3aQQufDGb7FmA4z5wBMVlhlNcWf9jfODXcVW+JFyvMfEShh?=
 =?us-ascii?Q?n7yj8nzGUCKt0aE7l1rVIy1AsBlpPkDvidpQ2JYfCdhqSHmIDnE7a7HzDPa0?=
 =?us-ascii?Q?ezbacBQgAqlN/5s/CXMzzqjTqPzyS9ttazBLTKBXFb69FSftpd2PbvA6wIgg?=
 =?us-ascii?Q?Djykw8yrqzpP9DXbWI9deN1E1nkTggROsZn4e4+GT3e9h/5Wabsus+pLYu/X?=
 =?us-ascii?Q?oKTgY/F3SEfE1PIxYVpZtxq1H309wfihCHPmxa148Bc0EIgBPUKdHNVGczZ0?=
 =?us-ascii?Q?E2qkPF3lYhjAL7cHRSysaSzEjs5skRw96o4BaswejAyvwlLgDIEVlHW6FKyO?=
 =?us-ascii?Q?6RmGDRIbtER3f6/LxZIbGBh2K4ebqTmvSEfFNfojNiHXuLGP+KEii/a9FcXf?=
 =?us-ascii?Q?JvAoXEnf8rNw0lO04t13hdhUXDyMJxbwoVAjBZ/v/KJJL0EoHburW7c7SIlu?=
 =?us-ascii?Q?RFqJ3IWh8L6Cubn/dGkkqJZ+mMBE6vZ/ZpdUb025aWuGgRPnwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:31:42.3707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cd0f3b-1064-4773-0c3d-08dc941fb1a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

From: Leon Romanovsky <leonro@nvidia.com>

ConnectX devices lack ability to count payload data byte size which is
needed for SA to return to libreswan for rekeying.

As a solution let's approximate that by decreasing headers size from
total size counted by flow steering. The calculation doesn't take into
account any other headers which can be in the packet (e.g. IP extensions).

Fixes: 5a6cddb89b51 ("net/mlx5e: Update IPsec per SA packets/bytes count")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 2a10428d820a..3d274599015b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -994,6 +994,7 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	u64 auth_packets = 0, auth_bytes = 0;
 	u64 success_packets, success_bytes;
 	u64 packets, bytes, lastuse;
+	size_t headers;
 
 	lockdep_assert(lockdep_is_held(&x->lock) ||
 		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex) ||
@@ -1026,9 +1027,20 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	mlx5_fc_query_cached(ipsec_rule->fc, &bytes, &packets, &lastuse);
 	success_packets = packets - auth_packets - trailer_packets - replay_packets;
 	x->curlft.packets += success_packets;
+	/* NIC counts all bytes passed through flow steering and doesn't have
+	 * an ability to count payload data size which is needed for SA.
+	 *
+	 * To overcome HW limitestion, let's approximate the payload size
+	 * by removing always available headers.
+	 */
+	headers = sizeof(struct ethhdr);
+	if (sa_entry->attrs.family == AF_INET)
+		headers += sizeof(struct iphdr);
+	else
+		headers += sizeof(struct ipv6hdr);
 
 	success_bytes = bytes - auth_bytes - trailer_bytes - replay_bytes;
-	x->curlft.bytes += success_bytes;
+	x->curlft.bytes += success_bytes - headers * success_packets;
 }
 
 static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
-- 
2.31.1


