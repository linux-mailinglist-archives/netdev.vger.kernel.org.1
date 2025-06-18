Return-Path: <netdev+bounces-198963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D42BADE6EB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6287E189E60D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D22820D1;
	Wed, 18 Jun 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i0ULE8fg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8E1F4191
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238803; cv=fail; b=JSojEs9opAvapf2lat7XPQ8KkJezKnmQ2QueGYe7Awz0VWOvaT123yK+epLC9E13vOqJkwLfnNw/U+mBuF1aNpkyrNJjJ1mJ64foOVaYiVJLWn1x7kJl+l/qzNMsleHSAyOJ47FZUwg2SoqpNH+SXy0VKp+/1trAXWiRk0u/8ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238803; c=relaxed/simple;
	bh=NsBFE9xfG2rSdG/yNqsm/5gY7L/nYRsw1GUXfTqO/rU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iV+2zXeSCET0HNgRMccnn/UscSNv2MDDg3JhUQUYdB5zJSr9Oct3UkV2HERMfVzfQW6TkUQnggpKuWCy4+I6wDqU+u480slSJPp3oDkkHBP2LOdJU3slBdyM+zBd8HQWVVAR3ik9L3axQ6rfoFDoMZTm0cFuNOVqAjZ3i99MzlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i0ULE8fg; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf0eJDPvsz1PGk0eil3y/qM8M2WWd3jP/IRKqg/whLCY5f208u7wEc03vaieYinPTzwQJaHdkQdWXEd0bqrFPn0ChtdP5DC0GH4UIn570uE51BxnpNJHdmdvb00On2UpoITVM552Tq0qrV/92sJoPQKjQOgBWy0mF1Jy8Gu7ye0JDM3senT645nISQZNe6s6Ck0sZNG9UNdr9J2GnLU3uLLeEpPEqTv3nTNeUXD6QvcbAwkOEBHkLv1bKSd56Udx/MA4+qU05FQEW6Za2S0absG3Ojte1fUkPZ17w/QCpyibxbZnWYhvz7Q14mv462ISkzuEe7QY37OoMVAlMqILog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvrUDp01fCL42Xv7ZnOWStRM0eqkA4WgaEhcpCk4Igk=;
 b=R2A57ULC10QjBvPkdRCIj01fJICAkyCFlXTxzmpXw5Oc/xgJakNRNuOEK6T3yjj8MPoD6oDZk+8aK4dKtx2JP2EG5UJH4xvDuh7FoF5ZabdEaznJ2todqG55nOI+UTOuq6cg1AgVFha/ZHyZ2TQiOWeX8UMZPuWCxBGNCGxYM4pQfDvLmTURe+LYqm6A0aVSP7t0w7XzMaDu33dGXKUYEUR4IJSlgFLODQ9VissWrxD/7s8pkftBU1c5gDGJ+V7BzxqVLv//ZcQnhtLNpSJpjf0XX73SUVLTekwIDvrestxUfcaPp4Tk3KN7yMYbUVzDsVmja+D6quueQdR6wn35Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvrUDp01fCL42Xv7ZnOWStRM0eqkA4WgaEhcpCk4Igk=;
 b=i0ULE8fgvyFOXXhGM3YGrlgJ3aIokydyh9xSWmLnRQjnlz7qWhEMRQLJI2fu02z8ORkEKc8d+v5SNiilYDYIYpUEt3QJtv6b2vRnQle7fNfITrdpMzt8YS1U/sizIbU6LkkVNd4bHlYBpo72nx869IHZzutb/Vl/35/mGpemmSQktbmAx4jYYIbMbrbxKT5VqrE6ZxVk5D+O9fYGcUceVud0DEFftIhuWul0NN3hqPsHy9E9Mk7SH1cEmh/ROFyP3gruHcLoTX6TXJ0oFqP61Sq3kTvyd2I6mH6r2xRW+70b5xZYGrCwohWR0QP81EC+mBsXBGt5+X4yN+06xBTuOg==
Received: from CH5PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:1ed::9)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 09:26:39 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::80) by CH5PR02CA0015.outlook.office365.com
 (2603:10b6:610:1ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Wed,
 18 Jun 2025 09:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 09:26:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Jun
 2025 02:26:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 18 Jun
 2025 02:26:23 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 18 Jun 2025 02:26:21 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Eric Dumazet
	<edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next] xfrm: hold device only for the asynchronous decryption
Date: Wed, 18 Jun 2025 12:25:49 +0300
Message-ID: <20250618092550.68847-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 87767674-3244-49dc-841d-08ddae4a3a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rG2UGvz/F5ORjgS4TJUA8/GOWeMGdjJJQQ0obok7dFP0G5ci07An4CCHe70?=
 =?us-ascii?Q?gLn5zytOCZ/SalsNAjrDQOl1uBYKFAsvvoxZsFdpIYCtmV3jwySio29rq1qH?=
 =?us-ascii?Q?OeNYLLHu4/eIEB9Xx0ljQRBRKhlL3HGrJUg3QgOra4gdzLoGLU3SeDnX88Ap?=
 =?us-ascii?Q?L/40ca3XK0zMV4Jx55vZmnJlticTMbvyOP6iUAx6qpeDrmQYmqhXk/x1CHzS?=
 =?us-ascii?Q?kon6uYtt7H+KM2LXQy6GIUtLo+9FbtRxeFwrV0HcS2VxqOpkUtgYleOAfQIJ?=
 =?us-ascii?Q?QSXen0EtND+MVL9jn5edPh3F+8yWir816bK711mOHLsHpIWd6+VGQco/BujB?=
 =?us-ascii?Q?4kXnIcR3DUX3Amms6Y24PSnpkOjaJO+lvYeHBfvIYqNiD5ltRe6VEuc+/J+U?=
 =?us-ascii?Q?TB+qzMSTPqZvQzMpoZ4lfas2zF5O3r9wkUeR5p4zxF0xzIN6IavxE+GZuelP?=
 =?us-ascii?Q?w20O7BifjjHz81uUhe7/7G86asEeqXjvVMvlwcpV56KNIzAHUurdZinZWFHr?=
 =?us-ascii?Q?UQDQjVSzQ3brG8z3NA4V+I5PDSmSSwLCpGjjDNgbf5NqESE1q1HlhSetLIBX?=
 =?us-ascii?Q?zkOiKAfej9M/cDoQOfO2w3kTv1EAG4gEOcJDEUVTrkbQU7Ch5ha3KmlAt32k?=
 =?us-ascii?Q?KB4Sr7eiigTyzhKJsVrlTudn6ljxwf8vN0xFEKPKXvAPAjk3MOFxWZEMf9j1?=
 =?us-ascii?Q?0LwyzNI2wKt9mZiBylpK9WrFF4WleeE6u4lYeCb8ykRGvc+r8rTj37nizEIB?=
 =?us-ascii?Q?FA9+au26hQ+lBF+GceWq58JVZzw4Ma5p3hmF9AoL1onDJG2dZj/C8UrUT8HX?=
 =?us-ascii?Q?3zq71zM6TwKgZ3AWNGp3t+Dp6B59GgCCfGZiY7cio26OZ1I3XDHB0e0dCuC3?=
 =?us-ascii?Q?SDXBm6zl0KD4yPIw5b0lHxXSx3QH5cqNxjouOSRT1+bpH70H0juCfj6uNC2H?=
 =?us-ascii?Q?zn3QWyzB5dKKr1P4ZJwiBMO80seDRckzNRlwmCOQ5jcdFbR+Wq88WdPX0+/8?=
 =?us-ascii?Q?E9GlTZ4TnwUsHF3jk1TRA5DHXNhl0WZs5mohYK75vgUyDSJ2CTD++vrb57aB?=
 =?us-ascii?Q?AozXmw1EnZdcTiZe3joZHrxUxyTkCDMm7znRaSLSaChTfIWWO4m+Pg0Bhhds?=
 =?us-ascii?Q?/admTDG9fRjiATtHFXZcoF5T08byOKU0PWDgfKDr1jgl+2vGFJiwbBirBY5/?=
 =?us-ascii?Q?+1JGzVOX/BKwjTmGeQQWYeuAcHSCivik9Gbx5iIHJum16AeLeNDeObU/5gXd?=
 =?us-ascii?Q?ZL4o/2bcvucBTDyrota1oFj8rT0lazuw7KVWW2j8lcmX/7m2U0eXQkNlkHFD?=
 =?us-ascii?Q?KS3CmNP8I95SskfiZa6+fr7tNb/Sr4K3v5d65Too8ORAeVAFSd3gwqur2o/B?=
 =?us-ascii?Q?qFODUVdLnXQIZvg28fql/zA3REb4z2hmR2tLnDwjuiBoAiLmngJxc5aIl/7B?=
 =?us-ascii?Q?f9yXhq5xrEFXZFo9OI12VulYQC7DbhLHrlJRjLd6lmPPArcqthNOOTwnzuyU?=
 =?us-ascii?Q?XVKicA1wHhOYRWoqsmhP9jJsa9zZOIaLhk61?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 09:26:38.8930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87767674-3244-49dc-841d-08ddae4a3a9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

The dev_hold() on skb->dev during packet reception was originally
added to prevent the device from being released prematurely during
asynchronous decryption operations.

As current hardware can offload decryption, this asynchronous path is
not always utilized. This often results in a pattern of dev_hold()
immediately followed by dev_put() for each packet, creating
unnecessary reference counting overhead detrimental to performance.

This patch optimizes this by skipping the dev_hold() and subsequent
dev_put() when asynchronous decryption is not being performed.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/xfrm/xfrm_input.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 7e6a71b9d6a3..31ed705712a8 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -503,6 +503,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
+			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			goto resume;
 		}
@@ -649,18 +650,16 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		dev_hold(skb->dev);
-
 		if (crypto_done)
 			nexthdr = x->type_offload->input_tail(x, skb);
 		else
 			nexthdr = x->type->input(x, skb);
 
-		if (nexthdr == -EINPROGRESS)
+		if (nexthdr == -EINPROGRESS) {
+			dev_hold(skb->dev);
 			return 0;
+		}
 resume:
-		dev_put(skb->dev);
-
 		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
-- 
2.38.1


