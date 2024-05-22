Return-Path: <netdev+bounces-97631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9B8CC72F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC60EB21E53
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4214830E;
	Wed, 22 May 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KSxfV84Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204AC1482FE
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406111; cv=fail; b=JCTSI/kJlDB6M+wHnSJu5b3ORP8x5Kq/BdQjmgtKFv2L5JWhQEFR33OTq2D1S9cCchH4WH4svV36YaEiGHTn6IwcZDpkTgaDaCBgbZQN5A2UtUYMcDLbKRT84jQjGWQtxx/uilH6ANnMf8w96HdOlTbW00GdvhRl3v1j0fK70Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406111; c=relaxed/simple;
	bh=Z3WhITIG7UbkBi3+yHjguv1Y9WmkaGd/H8FPxb9MU9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnfU5j2UvAZH5TmcVnCieu/jr/R7HmInxnPdzyW07OVAmoc3g5uYhg+OmaC94lTvYaw0dhC8C3zbz7Pckomvx02JJbOWamGVHYywUvwUTdvZDhxxxTOwkmyiDO/ASLumvO34TqSe6wJJFlzfZiqfzyHmdkwTC27VmLKda+gHFO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KSxfV84Y; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5C+flAW9aILT+BFiPqnWmxWgpcO+ZVqWJdDXHA1oymUU7YFCA1L1tDxO8cTnVtTHCkWt/T+q6Bck0mnvSl67plfqo9llOXcEMCYif2OWAsEx0aqzUNKR/LFAu0Lq+4l5eiQKlEnqK6P2qNVLIw3yCklIoZIdxbM7KM1sBePb5CFaXhgkyS7HmTWHYkeOziC5rMB2OFm4WyhUr9FVxYtOc86+SXx59E8h3oapS+RjGooh4cJ7mH/Rhj6GHt9oH0YkmZRbw+e6fMy6/Zm27IkE4+NrVJzSD5BanzbxTS8svVtvY61ZJGeF2W3ijcHI86ILUjg9dfHFqc1mhhS33czKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM929nyZon7FnQoZzWixpLuF2MdyZyduUY37ixsCQVU=;
 b=WPNE3bX44s02tSP2D4npAsmgEzvCr+Kx7wwdlyulb4eFjIuwZHTi5ewua20HsjGSg/ChlM1obnmI5iz9GbqkYANFOXE9AeiyQYTQiF3rCombbLCpCvlmMDPBt7FGksmUphZSjsG60uL/1OEtYugWwmD2CxdiXuOaRZSDy5pb1JFWH2zY0Dt5ziCn6FE6DaQmf0qxDKbaURcxEQwpBgcvFqor6lNeNiOeJEMYo99Ku9X319QH5NpFWOzJnpSh3+VeVNyakGr7t7AlyCeKRME/he1MmRM8otXAE/veZgnGjuUaq4BwaBrQdr7PZqAhXLIxrRb/B6DRvGvO0vkF/Z7mLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PM929nyZon7FnQoZzWixpLuF2MdyZyduUY37ixsCQVU=;
 b=KSxfV84YGrz0/6V+/3Inv+HiKfRL+Y83OZ5Tt5n87edsljABlbkJlWvOPL+kaJNQe3pDqWZxgTACKP+pUW6T2/1AGOvhF6ot+retOsU1A2Ks9FSViwZt4eQOAjImaNonNHt11irqCNUdCVyheKITA1lkRc+jmy7xQChUWbBMsD9W9sBYfHE3cWNJ1u2nO6yzmv/+X2f2xA5IuZOB2ciS0dIo0axaFOV8J49DaT0Pzajezs5M/C8gfkGbVH4fmemPH8Y6k5JaFmKPv0Wg7mNuPY2L3ceLybx5+orbUJ5fPmDBpVxKee8def7JLcrrKB0zJkhEjlAV8n5vjjtIp+UqKw==
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 19:28:26 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::67) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 19:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:28:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 5/8] net/mlx5e: Fix IPsec tunnel mode offload feature check
Date: Wed, 22 May 2024 22:26:56 +0300
Message-ID: <20240522192659.840796-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522192659.840796-1-tariqt@nvidia.com>
References: <20240522192659.840796-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: a9dfd6e3-0b6d-493d-68d3-08dc7a955977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zlqb2weBSOHAR27WsYMs8kEsthj0XmWj3uZ2w6sKaWu0uP6/b1YzPsvICHCw?=
 =?us-ascii?Q?8ngqMjd993gY1Z1iDTgByAWJEKElNGNRhnkF+tfpoJBAkEVek31IqADl7Zsj?=
 =?us-ascii?Q?VtzWmrRg8h314ed9cTftUsfbiZ+yWjHfN8qCtRxFN+Rwo7gJADra+l+n00Wa?=
 =?us-ascii?Q?9+Ddqc7YfuQLECs8OWIpm+gbO6q6/2O9aHbfU4Semzzo6p669dRlsseDEzdS?=
 =?us-ascii?Q?2WYRD+42SK0KCeDCdcgsPn21MueQV0ukcb/PMg0vUcz1Ut3sxC+K12IYH1QK?=
 =?us-ascii?Q?bKHacKh9dX4A/R2a8L9IKc2EMpeqNYc7bARKzcK03vwB/Yh2KpR3r9sXF5pC?=
 =?us-ascii?Q?uIlqqAZpzMLBxmLvteJXoZtA1MmZg0ou0LQIH9gZPZsNClheZk1KpCZNaUza?=
 =?us-ascii?Q?SRkTqsVz1DiwNBHG+op1okuiJjF1NDli5zcbspqffoXjKsgKDp4+8JogLkRP?=
 =?us-ascii?Q?JBSNdWZ1Ntvn22pCPERsV2a4UfccE+pdWR9mJlrh/KCDGs3sUm+vyNiwLp5p?=
 =?us-ascii?Q?klSV4z3cmT++q0QnZLyihVPhIGIiZ1TspyJQoLsF1mOvV+5ZaA7XNdxoTiR1?=
 =?us-ascii?Q?kjl2D2BF0NJag99TOih+vpoCoVjAeO3hQ90ivQSeG71DxBF7h55ZJK0U2iEZ?=
 =?us-ascii?Q?JvtFySU8SkKRylxjJtnbewvxxqWFHfb3SmlR5UsU5Jt9ipYxu2leKHGMjIE3?=
 =?us-ascii?Q?4wwBtdftFeAVwcniiFu5C6rinceJIUoKEc1jHnVho26QYOguJyqcqYIxczkF?=
 =?us-ascii?Q?JlI7D/evlgQ8VO0/8uB+anzQECCOfuoyCLhLWgZuPxwrcYEWBHF1W9XibvgW?=
 =?us-ascii?Q?b1c6YEHj0nE/FjvC65zI5DZoTtCOZ/jwZDop2NqQ0aSqpvfDTsO/5nCi4A4n?=
 =?us-ascii?Q?ZXtEzNq4lo4BGFSL6pZh3vAQyHWnYJ0Ii3zyVswpesCzLwKP9nP41q0PXfZv?=
 =?us-ascii?Q?2BDJ4gryp7U18MwtgVJRq4ccnM4+GAFM7o5c+dCDFnJovuS6fG8O5HPidcpg?=
 =?us-ascii?Q?nJcXQe0zkjKVSiJ9kP7TreiCgbGWQThVl9W2FJIqBYXh5ce7r7d6tBHhP0nu?=
 =?us-ascii?Q?nxDtqrNobFFELHw9kbIzbgWljgU9mYiQHErgbLES5QoQ0HNywDg3omCwWH8N?=
 =?us-ascii?Q?WVsp666kGTclCQn9YtTLifKzn7NNxH+PZpR59czgjz2dNAX0g4GFhTLjNI49?=
 =?us-ascii?Q?9Ba3692KCoyBSvmOB/Z5NE6Ktp/yUwhyM1BY2ErIqZuo8dWQ3VWiZRGKxXwX?=
 =?us-ascii?Q?BSwYThgnFDm1+ShcPGiBwxlOWurFDEfcYT79F1tl9d+qLHzQ8qJSYvlg4p0A?=
 =?us-ascii?Q?FtHuLvviiLQpor9E0t9yqwyI06qcBSyIwT4Tsj6yvExpwpYkgkeU1u6+mggf?=
 =?us-ascii?Q?nN56zfIjaUw+BH0jgvh5hDXDL4Ll?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:24.7450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dfd6e3-0b6d-493d-68d3-08dc7a955977
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Remove faulty check disabling checksum offload and GSO for offload of
simple IPsec tunnel L4 traffic. Comment previously describing the deleted
code incorrectly claimed the check prevented double tunnel (or three layers
of ip headers).

Fixes: f1267798c980 ("net/mlx5: Fix checksum issue of VXLAN and IPsec crypto offload")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h    | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 82064614846f..359050f0b54d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -97,18 +97,11 @@ mlx5e_ipsec_feature_check(struct sk_buff *skb, netdev_features_t features)
 		if (!x || !x->xso.offload_handle)
 			goto out_disable;
 
-		if (xo->inner_ipproto) {
-			/* Cannot support tunnel packet over IPsec tunnel mode
-			 * because we cannot offload three IP header csum
-			 */
-			if (x->props.mode == XFRM_MODE_TUNNEL)
-				goto out_disable;
-
-			/* Only support UDP or TCP L4 checksum */
-			if (xo->inner_ipproto != IPPROTO_UDP &&
-			    xo->inner_ipproto != IPPROTO_TCP)
-				goto out_disable;
-		}
+		/* Only support UDP or TCP L4 checksum */
+		if (xo->inner_ipproto &&
+		    xo->inner_ipproto != IPPROTO_UDP &&
+		    xo->inner_ipproto != IPPROTO_TCP)
+			goto out_disable;
 
 		return features;
 
-- 
2.44.0


