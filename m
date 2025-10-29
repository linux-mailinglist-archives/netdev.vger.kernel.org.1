Return-Path: <netdev+bounces-233864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 518BEC19877
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79A884E2F9F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F7322DAF;
	Wed, 29 Oct 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cf+WgH6s"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADC20C48A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731566; cv=fail; b=k1J9mlstA6+ETWcBUIe6fF8W6gzAdGFKA3walfQEqXCl4DWdfzwy8TWVFz5x3Tx7Cy4jH5YeFXeYhepzZFWhVtM1TU2nrHtjWRsg9A+IouvSJRxedNE0BsID7gtc/XPQE4dVqqYSDa9UgUysHO3PhGP3CjbJ4YKSA5T8nd7ffeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731566; c=relaxed/simple;
	bh=FWNMCqTUtOIsiBEiYqF2XYvTCjDcEH1WpPpxZIYOy2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OOxG5/2nIZ+7AYNMMKOxyDUCfFcileU/mX5+CcfMJvQLKFjlwvreEwMKY/f+8Lz4XfxPAx57CNL1Ks2KymQAIJWZTairThWZ6cUeIIbZSxFibOlgMNBJ5csS3U6L28GoQ5gobMjYw7m+t1IpTeXGJJy7gp3xwx3TluX9Z3GvaQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cf+WgH6s; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=th8cq96QLeX/yE0YM9qIc+6Ux/odOJdwpCtr8DjzozMdd7b/H0hs7Qq8HyNkLRh4kjI54tRmYyQL9eopmU4JzHNN0vxR4SrVt9B2qkpUTlqiwxgCpwoPw2mZgPswsWzVASkIJypfqZWYYiFvE6S4TPkvgL8Hr7t0UfD2vxbO9Rvt6eD4IZmsH1mLHZySp/EHpIJnyZt5cRS3ESUFnOuy7oE2lsNShBx5tLqC54yfOrXNj5LxfDJ3lL6EnGm2Z0JPFVFSZ7TakdknPL0LqUfxHoZ8Iwt/egclJ1vNBOm7IniIARYQU0K7k5E6WVg8cI6HRVfEtzwLdZj+xjyA04yh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj+j3gi2ZuhD6BNz11ZzeEsuXCYNjQWZYuz2kPj0P3k=;
 b=R2+rrakA1+ltoUqK0CFvYRBCIaMEFL/ssH2hOOeU2MXKXJ/fFtgsNdG8+ZobtcCElpqJy2KKhGk3NNi70rMKsTZ21nGBxVsdXl66FqfEPurIE10DVYLjGTl32FeXDEXsCulvDXym3nEyzEPB4bv2vfXOUHtVNfiSUMJxr4gzumUT2ODKlfJfeeSBLP0i1zIxanIlJifQF19i9lSreJV42x74Ovgutx2eoYvbq96jC1jhu+ji92qjPRe9V8iTIDeUSLvc+ja8EeDi9x9aPtC64NgVDBEGzv7rgUFUmj1zu/H8DAaXpaLiRhNEyj0xuBJnRWLCP4Gy7HwWQlvAjQ6e7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj+j3gi2ZuhD6BNz11ZzeEsuXCYNjQWZYuz2kPj0P3k=;
 b=Cf+WgH6stnmQ024A8GB9Wh6geJmzP73V/zDvmts8jZ3LdgukPCgkzUuZvAEoUEfEIJRSSxXdcya6rkn9uQhU6JhFL4xD2kaheQ46c8V3hd9SaXVDpO6k1S+GQqVMbYqUH1ormrJf/eJOT2kmZZa08cT4KLiKF4tU+bshS/hpJL0oygSLbM3Uh3pw1G9JsTny8uQrISxOQqyXmZ/Vw3F6IteGsGQwtIVaOI5rZ/Ytkj9NuX81+FWc4J4i0kRLu8bhq4JITA7kFfsCVwZXM3RrJTIYAwOrgxiyWBmH1VW/HlgAjvcaagkmP6ZH4EAZtNLkdz8ysK+PpW0g8BOCZx/Zng==
Received: from CH2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:610:54::40)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 09:52:40 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::5a) by CH2PR11CA0030.outlook.office365.com
 (2603:10b6:610:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 09:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 09:52:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 02:52:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 02:52:29 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 02:52:26 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <acassen@corp.free.fr>
CC: Jianbo Liu <jianbol@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Leon
 Romanovsky" <leon@kernel.org>
Subject: [PATCH ipsec] xfrm: Prevent locally generated packets from direct output in tunnel mode
Date: Wed, 29 Oct 2025 11:50:25 +0200
Message-ID: <20251029095213.3108-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: c78f146f-40e8-4003-8ed1-08de16d0e65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdnOPNh3KHg0KSNtvJa/enGdkrFtEeYUah9RLbRGFwHn71W+dXQu5fDe3ZQF?=
 =?us-ascii?Q?VQ8DuvvQfYnyUCKhhAzr6sh8vjI7ny2A1vsx0lq1UtzQF4eY4kF78X85ih8N?=
 =?us-ascii?Q?p1f68WDHRw4Fjca25HYzO9etj41jQn3zmtrlOYRbwiGrSKCV0uyTxUIoVZC0?=
 =?us-ascii?Q?1jQYwEInffO043VXzbU+jojkunUA0P22TEWttXR8788WBPplWhdC9eyHyw4/?=
 =?us-ascii?Q?39P1zTWD7FiLacOW/QrVLOSu+7rr5aUkFUCpLkA3Ymjl7WrQoXs7poWmn4S1?=
 =?us-ascii?Q?23AhtKaKhZP2vP5qlznQWcErOoVtO0K4MPYHRgsXBJCll6D2c5ezJGOYLWLV?=
 =?us-ascii?Q?VzQRUKnh6yQONdrLtaXeDpCGYJtfGLGXbGTpget7BmIu7mA+hyfMF0iDIIgF?=
 =?us-ascii?Q?B1uu0uZ52zMCx72kjIAnQ5bH2JAHMpfO6fzKFOb+bD2MGWJzezqss2kI8sUh?=
 =?us-ascii?Q?b8PqxgFkNxUyvxwSpqsk8ufQP5Ijo/Cj5KiVzE4rIPJ7F4yqtfKH8Gyl4k6S?=
 =?us-ascii?Q?8m4RF63fmn+SheWr7RrsmwgPXzBokDjr+8n6SeOWR+ldRz7732EXWigK+nbu?=
 =?us-ascii?Q?vTwmQUAzV+2oixztYm2iJVlO1DJ+TfwpY9OYxB0nimdSdVNPqIS2/WgcG1Ap?=
 =?us-ascii?Q?EgBgY2XLpmn6C/UKd+t+kfenq3j5K4/OXygukBPaR0MjaHr0dY3Pb8L+gY/l?=
 =?us-ascii?Q?CEA9/Zdq/vZ7PhpEnwpnKfTzikPHk3OOwfoTRk3tdgEVy5amW/DvWK+1EQRf?=
 =?us-ascii?Q?AqAlxwgkXX4Bn6APsC5YY8GAdnPXZmTzNUZ3LNHb8OErbmmFchF9qucdYL7u?=
 =?us-ascii?Q?jfyq9AQUqpYPxmxzAJZfCIlgY+IbvVhIxmK1S1OQem9GrQFweaAOicqhnsYo?=
 =?us-ascii?Q?V4rqyOmctP5Zf5Br9n4MypOOIN3reGIlW7eTX+tgvX4jzjr9nWdOYMCeLT5w?=
 =?us-ascii?Q?wElnU6a09tbARWzSumBEO0oqUPBroAhixE+9rvfz9H/tepOTdOxou4G7sPIH?=
 =?us-ascii?Q?VDZU9vszjSU8h4lIRhwIrsVL0YZGDh15n0l7a+jMxAHt3XjLwY9o1i8DBCiO?=
 =?us-ascii?Q?aqu+gTqo/QnQMEu4LSlKUR8NyMFqk3gQrSOme4t9gFUU/iI0UccIKu+qOzjc?=
 =?us-ascii?Q?lxjM3/Xy/1sms55g9kkalcuW98WO3TRfLgIIbg89zUE4F90R8G1QUTdX+Q+E?=
 =?us-ascii?Q?TxzMeLvQV/R0+u/LP8AInf07WYXWlBUxQ3GF92/ODNlK/o94rA1F7s6R8iqS?=
 =?us-ascii?Q?r2PJscJZSuwefWh+TFnh/bOxzUMAFf9+Rpqj3i+reghaFmcb2JCi4T2MDsvb?=
 =?us-ascii?Q?nLVI5ZxY5uQkV9Igdlvr6fok9/T3MgNbANq8+RUPAw+VW8hMEXXF+sjexy8O?=
 =?us-ascii?Q?YrvcAD4SvpXzCxrL5Ov1taFp3LkzzdRK97QC/SO3ek8hG+K+PZURcjj1J6s/?=
 =?us-ascii?Q?M8Jmzv3XA6qcZG/WJNn+xRufPsThiKrOu5KDWnATYzukyb/X54teQiIoZTuq?=
 =?us-ascii?Q?FQFz5ybvD3nP1CZbXfGpY3XKsKW+MVo+Ct4yoK7PxHpIfQlRCWDlYW1+d5dX?=
 =?us-ascii?Q?2+B6UUo3P6EYDQkvAKY1jC1eCgNZoh4aJos1Rlnr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:52:40.5596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78f146f-40e8-4003-8ed1-08de16d0e65c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311

Add a check to ensure locally generated packets (skb->sk != NULL) do
not use direct output in tunnel mode, as these packets require proper
L2 header setup that is handled by the normal XFRM processing path.

Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_output.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 9077730ff7d0..c8fd506ca5cf 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -772,8 +772,12 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		/* Exclusive direct xmit for tunnel mode, as
 		 * some filtering or matching rules may apply
 		 * in transport mode.
+		 * Locally generated packets also require
+		 * the normal XFRM path for L2 header setup,
+		 * as the hardware needs the L2 header to match
+		 * for encryption, so skip direct output as well.
 		 */
-		if (x->props.mode == XFRM_MODE_TUNNEL)
+		if (x->props.mode == XFRM_MODE_TUNNEL && !skb->sk)
 			return xfrm_dev_direct_output(sk, x, skb);
 
 		return xfrm_output_resume(sk, skb, 0);
-- 
2.49.0


