Return-Path: <netdev+bounces-116562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F994AEF6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AF7280E41
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B0213CFB8;
	Wed,  7 Aug 2024 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJKrqIAU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F913AD3F
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052036; cv=fail; b=JJ6UHq8f0ocCWyC1wnbTvseDFBvG6Ygqh5HDPEuZh1WfjBvKx7Xqjj8h96UFyQwOGUKgevxXuygM/WjtGFZmHr5YBj3K2ZR4qYDA0DOp9C0SRJ9zjmnqPphybzciOTTl4OGvYYvLSaYgh7uvV/IR6kQV95O3J3mpcjFu128BYXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052036; c=relaxed/simple;
	bh=zVjshRw3uywvxjdw1QDwFy9yQhbTDiB4Ldx0kpWdFKY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GkTqdVgkXwDygp7TUrB8rOq8dMc77GfUfle5XPz5Zk1ycw+M11H3dBaabYQDzoE4+r7y0fCiRixCzZCzJ+oFuSCD6vxEzKJob+ouMmUcD8+hC4FprDjKmQhVjpwVP8jkVyQQhRhj8v33qSmZgtBPoSZItuqTjI7eWN/Ziu2srRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJKrqIAU; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmItdvOhDX5MqPPz5E3qF1HrivHCtcnQUDA3ihkwUf5/l7968pMkfaeB9Og0w7Eb1L9voOlc03vsvb8Sil13TpX3tHCq/qJFsDz2UdCLhPK5CfGVGJ41B9ITFDxqCCTL6Ii8hfGcSxcXJqS4DUrEOCGdRl7DEd7cOa7ugompYHK3HHBvPC/W7rXfXFXff0tYeiF6NXvTYgGA8IRqYtJZgekmwgtBvv6Tw17XOZ0ZvpiwyDTdVFnlf73ItphYu77IPbyDhCXJsP5/Dak6/DHjv3+dR80LiDzgtt84PnsWRrXq4xbD906wUNv3Wa3DKNj7ymGyCn+xjr1uZ8/H5Uchmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FHOIpn/Qe8aLUFWicQReCgEO23d0yN9SSsQnmvSgnU=;
 b=bY+htOZ+C1HPfyTsLwDB3zvheL7D8X3wKvhBdoyb/McGI45bNNVACbJTLYNQMPkeNMnu3ehwrV5ZiRTRxFspBQiKbvkGUVtU8KUeY3SIsFXsR+OUt52v2nT5DbklDcr7OrGXIaFdWvmJAKpqrMMTPbPm9wDN7/nIq17AOfuP0zcgDWyYw6n9EMiNbYqVLHZIA4f+kQzl/zzC0IPB3nE4gQ8ZQibzwAzi8s5twgWg+Kcg4BQQhWuS9VoHVNvgJD+i/DrfEszOkTx/VdxwxQqD/mYjbqv6gXe2S/yCD52fmIOFIWVTasFukJEZm/fRWTPiFKuQwxk+dVl3UY0zMOpy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FHOIpn/Qe8aLUFWicQReCgEO23d0yN9SSsQnmvSgnU=;
 b=HJKrqIAUhvwVN2OlMFWRqFaM1UiCiKzU5ur/dviEXLXYo5Bep5FDQtZ5rd2Yb/cI56vAjN7w4DPEiUu/3v3p231hwe+/z1D9R+HS/CQkrK+4sdKjCR6z0E+orAVz58qfzo/mImX5/3fNtK2gYfEjfBzbYYT/OaF61eHiTnEJ71cYZth6EJbC6q5KltixXka5hJbi5ysA9qG6vfWkPPAG0UYgiiUcHDexbTVrP1dyzF9xt2LeDA1JW1iX370RrXbbhg3GLZsFQm90vJMp93feHD4QowCPqplhh7IZ/zIZ7hPcfhNVUyJZa86fZVl9Tra0UvA45r3TjvWBxcGevwenRQ==
Received: from MW4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:303:6a::19)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 17:33:50 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::f) by MW4PR04CA0044.outlook.office365.com
 (2603:10b6:303:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Wed, 7 Aug 2024 17:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 17:33:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 10:33:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 10:33:31 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 7 Aug
 2024 10:33:28 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net v2] ethtool: Fix context creation with no parameters
Date: Wed, 7 Aug 2024 20:33:52 +0300
Message-ID: <20240807173352.3501746-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: f06acdde-1fe1-4ca9-f268-08dcb7071927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4U3G+mGDC3lRIbHfXHg6ssiuCdQ14hpqGNe98SC3dU+NRUC+cQSaE5jrxVO?=
 =?us-ascii?Q?+0SXFk7zLC35CO3w2Dk2SnXzjDUx++tHWU/rBlwziubtYGkIQDZB4YeR+IXp?=
 =?us-ascii?Q?mvbOJEHZfPBrKohoPmGJa/FSd2TyGtvO4GIEPuuuLGZhEi7ZF4dtzsoW069U?=
 =?us-ascii?Q?zWRitFiPutEdQdd0M2RtccR/8k1AuHxGepBfJ0lrV5vZUMXO7AxCKAn2iw7S?=
 =?us-ascii?Q?K/28usNdlLp43YDAcT/N+RGbcG+K5mIoJ2/4o3FzJpsTefF8AzfzUsYn5J8h?=
 =?us-ascii?Q?18O8EdUTFfGpQPu4sgnU90rgE5dVozeeOpGpju+SfldX4mwa6AiaYNAHlp9h?=
 =?us-ascii?Q?YulOrLNJFjabZO7qwzg76Tvrzd6mwq8InZh6R+QzJDX9ZajyURx0VUNX5Fl5?=
 =?us-ascii?Q?Ig68Uz1savdXkaS9J7VqsekQIfJZ+0TgN391PtN7xflExOKUbcfvmb5Zm8ws?=
 =?us-ascii?Q?gyklQXYhTNpAK0Xh13EC8v6L9XowgQVwQGVyzJK2EF/rO3oQw9whmlYY2bNh?=
 =?us-ascii?Q?Cx0202Lf6ecn5OXWz/b36WDL721l70D2Sy0u1m7cc9OhY7k8VR0Di/T3jcqS?=
 =?us-ascii?Q?/iApG24ssPp5lG5BfDnAVXvez7+azhstBiT3GZ02FggPfTfFE3M3Ziaw2SKP?=
 =?us-ascii?Q?l3zLJXhE+7ZjSQtDTbV7HdPAxozhfTWSgEA5tIE7K8oCq63ec7e+dUqgYNiI?=
 =?us-ascii?Q?4eaB8Gw0Ef7cTizulzo6aEWcrUYEsuNDwkHn+DEE8uLXRfw/X/hTFH9u583j?=
 =?us-ascii?Q?0n2o0olKBmQPaUTniiYUgLBday+U0wHQPBNx6ivf+2bDtEJkRHSHyFchD4Wz?=
 =?us-ascii?Q?/4FMLhKpca+Bm0vOxGHZ0uxoa6aRqLOTFIfB1iqYm7vnKE75GPqXJpYJH3Rq?=
 =?us-ascii?Q?h6VdoFCJSwtIUjUGnlBS6GG4MQsDkExPCrE0TvmHniz9zlmbAqwq0Xu5cJ2e?=
 =?us-ascii?Q?5doDscv1eJffp963KIhGPqUZlQMSzQGWpSHGJ56Q80H67xE2MSuidBjVWALJ?=
 =?us-ascii?Q?UCe8eYdXIkmIhbs9SvUErUjLN0Fjyf6R9tNCBdsiGOKSgvOCM5049WW0jUxy?=
 =?us-ascii?Q?BTly0GEGCyA14tQRqVOb7C22Kf0GqoiAhUtME8ZXZjWYU6XVeSb0Ay02XVl3?=
 =?us-ascii?Q?h2xSkaW8ETspYerwBucocON4hVhNZQB6mOmgehxAKlO3gWUNS1xJO6jlSzbV?=
 =?us-ascii?Q?DnTumjYz/m0m1VGZmph4Ieu5G9KW2hyXoiem+bt9heW8/hCfoKAa5TK5TWS7?=
 =?us-ascii?Q?5L++EAZUXRWvpnOExHHUiPPHGSg8Dvn+Eq35XEz3o4CvQZHfF0jNZUYEo1s5?=
 =?us-ascii?Q?R1rQLqjT+I3LcNgiuYRHkv65PPnVyMoBZXl1SLKMmXlZzVoZi70oSwgxCeJR?=
 =?us-ascii?Q?R09/cIo8sgw/U38Oa+v6FsEzi/UFZQAwFxzFdT3Gp0kCV8L+cj0BVI+IpbvB?=
 =?us-ascii?Q?Hs7JIdUQiItI1OnDd67T2vuWQo0GXC2GBhvjeUodohrVezVWVRH60A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 17:33:49.3532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06acdde-1fe1-4ca9-f268-08dcb7071927
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

The 'at least one change' requirement is not applicable for context
creation, skip the check in such case.
This allows a command such as 'ethtool -X eth0 context new' to work.

The command works by mistake when using older versions of userspace
ethtool due to an incompatibility issue where rxfh.input_xfrm is passed
as zero (unset) instead of RXH_XFRM_NO_CHANGE as done with recent
userspace. This patch does not try to solve the incompatibility issue.

Link: https://lore.kernel.org/netdev/05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com/
Fixes: 84a1d9c48200 ("net: ethtool: extend RXNFC API to support RSS spreading of filter matches")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
v1->v2: https://lore.kernel.org/netdev/20240807132541.3460386-1-gal@nvidia.com/
* Split the check to two, one for validation and one for 'no change'
* Only check for !change in the 'no change' check
* Remove wrong comment
---
 net/ethtool/ioctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 8ca13208d240..118d69bc3c76 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1369,15 +1369,17 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		return -EOPNOTSUPP;
 	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
 
-	/* If either indir, hash key or function is valid, proceed further.
-	 * Must request at least one change: indir size, hash key, function
-	 * or input transformation.
-	 */
 	if ((rxfh.indir_size &&
 	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
 	     rxfh.indir_size != dev_indir_size) ||
-	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||
-	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
+	    (rxfh.key_size && (rxfh.key_size != dev_key_size)))
+		return -EINVAL;
+
+	/* Must request at least one change: indir size, hash key, function
+	 * or input transformation.
+	 * There's no need for any of it in case of context creation.
+	 */
+	if (!create && (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
 	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
 	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
 		return -EINVAL;
-- 
2.40.1


