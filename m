Return-Path: <netdev+bounces-226669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B2BA3D9C
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060E8162A57
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F918D656;
	Fri, 26 Sep 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjqI83mU"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8924A049;
	Fri, 26 Sep 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892709; cv=fail; b=gkUedBusHvQE6UbehAQSqbhLPWDcir0VgIQUEASeVKZ0GtPxq/yXLu+jaLli0ar0vJmPWSAQX+0CJDWGZ2+zpbs17BVEwXbJnskjl/QqvIWywSLuWtEOv5TDqctBYEMzEPNi92IwX0b+r1yWsbEWUWadP7ZbDW5fuDCettrhHnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892709; c=relaxed/simple;
	bh=rAL3+TyPk20xKyJYyX9iuxjp7ulCHoyS6D/Xys3FeiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OsxsVRNF/TacatfUtWI9ERJlA8oSKtX61TCZ2w73wI+cJuUAybs2jE96arx+UlRJNSsRqaBa94bVUpq3kmvICClNG+yploiTr7yen423Jjl3cndSiHkwWy7v+UvAMxSOps2gLt9MWFle3LxSRfJLQDewNi5TQ0qlWaKVvHJEQJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjqI83mU; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcQYVDfu+k6C5nTAbWHo5kN2T7wnukHoeXEo6zDd3KiEvVjhCxlJXAN0YixuJ013oWOvgox3VbaahufDEUoken7yv5qPUjZkvAmiaRf6U7rEjmRIWRKI1E2fBHVO93StZPu4s7xIEA7ZiBv86QVZQZcJ9xNFiXxj6hZ+nTxkUjWNr3iftrQPoL0kv1HZ0nrkmJ6uomFxe4WOuG02M01icySL9WhGBB03iYLEW47wa7JHbvTm/2R+PmykxwzHuI6rnEtnbTGSCSOoCcAnWabqH3R9N0xZUZDeMUCSYMEqbz7OPiXrRpO3xY+Lo9U6CvM4ah0NMuWmpS+mRUpkdwtFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SGLGjeXUqbDClmvx5Th+1zIgfCSNq6jO9vq/4lMpSI=;
 b=ySvg1Btck/gyRSaCfbAp/EzlPpbdqwvXPHLxPSBTi3IQco4zSxR9CS4UVblfkBDrAzYVDQ1WasDEOx3WJQ5cBYQtwnxVhL/Cph+AUVEyutBarnTYxrM0j3yQL9NmF5tr2pFfTYhZXjKHjsjjSVunOPMHYbp15EqXFaoqCAMYKgrmc79mvi49bBV7IpiBWwT7npwOFt83hRk1/n2n0XIBhxqhNx+egzHqTBAoyUe93LZZffk+qoCQwDjG4ooS0otkWmXfzvISAA7ZEF5lJnnjjYQHKrpVAr0ABYiyruqw4eh6QDznt/ykkiIq3JSheqYDIOC48rIJr/mpPIYAFpidyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SGLGjeXUqbDClmvx5Th+1zIgfCSNq6jO9vq/4lMpSI=;
 b=tjqI83mUG7Uvp6GPzEXJynhnn4+5ArW9m3Ajq9Rc5MslzK72hgOpEqBy/em8QJv1/PuccrCEW7YNxOLg9Il32pKM8YLL6a8RpDl5ZwiTQDce2dZftqJxO3lv9xOS/3yev59QeVfkHny2mjUpCBTeK6iJ2/SUxtcJwrkob2a07i+gZd4NLaN4CkvAAy2PFTpDA9Jun2nimkW7OiCjVSmzdQzD9bAGdlA7NvMz3ZKC7b36vZ3AfJN6xFVDf9oTsI5dxHNqGcrHqQWmAbAnqveXDVS1la9uPr6PK9QUB/QKqnqcnxSoPefjRJ9JpqGP1mDYM+3jNfTAYWPmEsQNCN7eQA==
Received: from DS0PR17CA0014.namprd17.prod.outlook.com (2603:10b6:8:191::10)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 13:18:19 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::2c) by DS0PR17CA0014.outlook.office365.com
 (2603:10b6:8:191::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 13:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 13:18:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 26 Sep
 2025 06:18:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 26 Sep 2025 06:18:08 -0700
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 26 Sep 2025 06:18:06 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] page_pool: Clamp pool size to max 16K pages
Date: Fri, 26 Sep 2025 16:16:05 +0300
Message-ID: <20250926131605.2276734-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: da611f31-367f-4ea9-d36a-08ddfcff2945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ocW3rjJZpRTWdDbBvTu26iBg3bjI8I6HLpQDR8s2hKH9W+DwjfNJB3FmH5ut?=
 =?us-ascii?Q?7PQnI7J9x8Qmbv7LBfQugPSiTSdoDLJFhZrRN0IrFze82pNKYtTZKqMSI+X/?=
 =?us-ascii?Q?Ggl9+HbwM5snFJd4uvw/2F/4cWmTENkKztvU/smBMhQJPF18S7POduGLIIWe?=
 =?us-ascii?Q?hVR+nxh8DZhWNkMT+R+xJ73lKsxyUOJXETgm8FGv/uoJg21gRi1GERuAjFpO?=
 =?us-ascii?Q?YBELHZEfInmN0jxK09/PBXDLTv/TzjfMSHFOSPWpo6fLaf321tTJ3l3y8yLg?=
 =?us-ascii?Q?sOSZ80x6NMPcv4H8SL8KUtiJVi7rfaW4wm4DZ+MImJUVzCZ+joDpOOHOC//s?=
 =?us-ascii?Q?khQGHjiLEisLFJ7wssUHIAIMmGpm/07fOXMVL2EBQ2VKX/Il2TgVMMJzmx0W?=
 =?us-ascii?Q?VfTtZS4deeLyw9Ux/bi9Oe693UT5QLoIY3Rr6xpUh5hoKyH1Q06RqS89ZhdO?=
 =?us-ascii?Q?4Xj/WOKEvi5xfXLzGC55cZ1D3gIweJklpyBygWz0FWp1jedi4haAyncN46y8?=
 =?us-ascii?Q?HbbwCROES93ZNCwuV8Sn2kpFsXtXSBG5uJEXVGLVHZDWzLi9VO1qQMVw5hPA?=
 =?us-ascii?Q?KpGvq3XUIVqP/zY1kVge2leo3UM4u1mlY4yUe8ZosaQtbOZVflKTgeUj3S8X?=
 =?us-ascii?Q?/1O7lK+SiXJNnNaYHTIjE1CdoqJF9vgL/nijxMpFyWgXXO3SOxvElBO5aN3u?=
 =?us-ascii?Q?UfxalWaQAvHSyey1UsEbBwmdsPBM8Xx1vt8+/VAywN1GJ6rJOa7XzD/u99YH?=
 =?us-ascii?Q?DuRWQPjPbod7x8+ElmK0dI8ewMzd00DEU40vjUbApbZeocvfHw6yL2LbD2e4?=
 =?us-ascii?Q?hE3zFoRpEwEfKcXh/Mu4iqWnHWq2IUdzcS66aacZ9SZUHXnu2yRBMCxcEAfZ?=
 =?us-ascii?Q?j8M+1AX523DRqyCO4JDKLXm80t4Eh5fwK4ogeHkrtVTjWBALd8jRCKYScn8v?=
 =?us-ascii?Q?49J+AGKZ+1ycs8Vbm0jnSNlCf5y5CYqcFnmQ9DhaozRcVrzyP9qi9KiztIGk?=
 =?us-ascii?Q?2MJRTWi4N3/gqfF7zheLHc1LldWluH8pCBamyftWv+NN21vuQPjOhjn96o7j?=
 =?us-ascii?Q?W3s+PpHIPu8CY7CSlAPK+CG8JoNvuZRGVtr3hJ5HA2pkhynBg/Eij9OL/o4G?=
 =?us-ascii?Q?0YbE8podUw3bLVKEx4Mpe1bxNjIDLrk+GGo2349VOFqLmu5kguDBXhqfQfLy?=
 =?us-ascii?Q?B6+VU454MfBnK3YwzpKgIkKwGD4PMZTaQAC55A3YCV7zzNyqCltXEZMEEBPX?=
 =?us-ascii?Q?Jp3dDFamlJVc7t6iY1h9Bx4cSMuCHoNrJNho1MhaNxrACp2EPjUqyqQdmKGJ?=
 =?us-ascii?Q?vQjEMuYeJsuLiX6yvVCLTwr60hBsBEL9m7cbnC2z6l1nGk+OBGPwORK/fs5f?=
 =?us-ascii?Q?0LMW7eIAECJlXWDSn26I0mXkqUMC3oQsp5UiP3LAqLGKXL8Nbzf7ZxAUpEMb?=
 =?us-ascii?Q?Ju+W6osSP8wD7YfTYd+mpWFdgWQqOGTPLoOKtWEaIyJW6yyzYAZnfy21zY8b?=
 =?us-ascii?Q?Mh5mSaYUb1wAoh4C23csxCyLRt5c0RHHyCxJMZNv2EOGTcQovnXURg0KZXPO?=
 =?us-ascii?Q?dPls/rAHFBO1pmb3h/jmfGNhYeuKXefTz9RO3dWU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:18:19.4362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da611f31-367f-4ea9-d36a-08ddfcff2945
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

page_pool_init() returns E2BIG when the page_pool size goes above 32K
pages. As some drivers are configuring the page_pool size according to
the MTU and ring size, there are cases where this limit is exceeded and
the queue creation fails.

The page_pool size doesn't have to cover a full queue, especially for
larger ring size. So clamp the size instead of returning an error. Do
this in the core to avoid having each driver do the clamping.

The current limit was deemed to high [1] so it was reduced to 16K to avoid
page waste.

[1] https://lore.kernel.org/all/1758532715-820422-3-git-send-email-tariqt@nvidia.com/

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
Changes since v1 [1]:
- Switched to clamping in page_pool. (Jakub)
- Reduced 32K -> 16K limit. (Jakub)
- Dropped mlx5 patch. (Jakub)

[1] https://lore.kernel.org/all/1758532715-820422-1-git-send-email-tariqt@nvidia.com/
---
 net/core/page_pool.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ba70569bd4b0..054a1c38e698 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -211,11 +211,7 @@ static int page_pool_init(struct page_pool *pool,
 		return -EINVAL;
 
 	if (pool->p.pool_size)
-		ring_qsize = pool->p.pool_size;
-
-	/* Sanity limit mem that can be pinned down */
-	if (ring_qsize > 32768)
-		return -E2BIG;
+		ring_qsize = min(pool->p.pool_size, 16384);
 
 	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
 	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
-- 
2.50.0


