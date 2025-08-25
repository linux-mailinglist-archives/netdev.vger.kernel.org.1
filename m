Return-Path: <netdev+bounces-216395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE05B33686
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5A87A0380
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7512853F9;
	Mon, 25 Aug 2025 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhCiLHY/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE928507F;
	Mon, 25 Aug 2025 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103875; cv=fail; b=arx/nsGdAI/myoXT2cZUPybQuAp5+W9J9pujUlV7uWWlhGqi/mTDUOMOC+p8ySTu7Wsu2NIq1wCaVJ5MwwpoECao1xOvGU7DknoQl6in8nt8NIR5DQj4t5pe8Bb2t4zlsayCUswJ891lV+vXKJZOimTlLo4gZvjeEOR3twumVH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103875; c=relaxed/simple;
	bh=gpVqEzM++iS+MCO7hMUyBrxhvGL8NPDTqRk3GwvPDos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7UgCNw2mZIHd8akD1O5lEzVOZS+drQS3JXDhjXltHbtjZlmd0G/oDPfE04o+evZrieC4TGsasV+CaHi8WPY7DeuEXj2dvPDMbC8C36lunTg0ruh5jW5DCavZfn1H0DDJSKNe8ycS2M7mM5CYeQU2EFNKVCps/k3DNVQTT9H6O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhCiLHY/; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNBwEcu6ixllZN9U6zJZfkst+zY7EbhZ/iB3SoYGam9sbgJGYU6S00yDNk04pOdjeIK9FtfDsTspzfuWyt2kjgeER4f59pl/hxcA+ArgFBQ1LNrXw2lwb73a10StEVQ8mC+BM8BPOpdRmGnMcs67QruniSWOHGjjj7LaqjrFU3yBHUF7ETBjLg7TZ+mO0p3FeBOMo5j2yT8SCI9x9jVELkYL8SdevO7xcUKrvymUNdnT6gEXlMFJrQUoBzhBcLuncM7/eESttSnzR+h9q/ZftWktY1UN/wqrAFKXfU5A3i/XZo/R2uhCGHqoLRNyljq3aqy60XuZW3c4FL2245JWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usXVVuUSvWBL2seaykd7c125tV+xIT4bq0Rjg4o05CU=;
 b=Iymkk5ynuO6z1ggWEmN5qTq5HJpkidY1YAQ1vulq9X4Oex0ivWU3C3XCsm3O3JHOwlBlIo/SPX9OCfGZpJAAZ78if1BcEcYWQhCR9fuuA7AiPG2x1WmsGGZW4SOYY9kUQoTKyArCWQqZ0SCPbaHNJBZsEZJfBOeueJNQnO9dqVQX8WuPLiUWRF29OOR7psjBb1b8afdnApszoSnrdMUXz/J4c/YEJs2tl9EoQfZ1lQqy4JYmqaRJ/1n365JVB8gTNvdPiS4+J+vuK2u64ja0e0U9TTrLeCA4a9HjiP4hgOyeG/jM8mnq6aIpqo5MGZ49szeOf0VhEeW11HdBq79fSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usXVVuUSvWBL2seaykd7c125tV+xIT4bq0Rjg4o05CU=;
 b=qhCiLHY/ZmTpdM4knJqpnVY2qb4miJCUgD5iIBKTY4mPVL4vy15ngFpQhzW5cqA5EzwTnL6LLymxczR+8vrER1vfMYuQ8kBOZ71TOIw4/PBq0bhFPHBCNknuzLx06uFPaWY38F+L4CMGHUJWpAPP4mmzMMmzHRBrwxYUyJTmZ9YW1HfAlUbqvnAa7zqCr0KmQ6TU53rDgtPS6pPtTULJFJjSzCOPHupl9xYIUkXQqch5xCeUBzM3AcWnGZWW8eWFrzzitdEiT7foWD03EnKL7SFkaPG3dohJJSSkIplh5hQatvdRS3XqZs3fQp2QI20qXzUqZhufHLjmYZcm/lyBbg==
Received: from BYAPR11CA0054.namprd11.prod.outlook.com (2603:10b6:a03:80::31)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 06:37:49 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::d3) by BYAPR11CA0054.outlook.office365.com
 (2603:10b6:a03:80::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 06:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 06:37:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:32 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 23:37:29 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 3/7] net: devmem: get netdev DMA device via new API
Date: Mon, 25 Aug 2025 09:36:35 +0300
Message-ID: <20250825063655.583454-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825063655.583454-1-dtatulea@nvidia.com>
References: <20250825063655.583454-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c92e17-3f99-43de-2413-08dde3a1e92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M8haI0B+0KlpQwLdh4rUf792hREQEUwn9SUej77/eAmy69g+vaT+hh29JX2C?=
 =?us-ascii?Q?2YDBkHcjAIqb8eLTPUzy0GViWVW9+fSDBfiED6NfFlOQXQAOlP9UcwolQQDp?=
 =?us-ascii?Q?AJdR08OKsdoHNbb1izhQR+Pdy6ztHWeNkqYJLAMnbMDFKR8VfZKCDC5nLf+7?=
 =?us-ascii?Q?CM2JqLAQ1eQMglDWUM9jwNtsRQXpJotyAGa1GLm+lcZ/W4YsX2FIf5BQZtDh?=
 =?us-ascii?Q?LXrFhOcImp/gO1XCMee4k7UXx/qntLP/y9qR3oSokAKMHzQxzjDLzDJtFW9e?=
 =?us-ascii?Q?vn23qLStQtHl6PkeoG7phFyuSthz8noH9raHLlLickWB3PqFPC9nVGyvNRWS?=
 =?us-ascii?Q?DL6DKeW0HIa1NQCu61FjVOlXvXoUYvaDn6xuXYGrT7xt9ILSEUh93FspEsLX?=
 =?us-ascii?Q?+H1lQF1W8yoOldQrvgf293AFRcaAgf6OfPsv3F1UrCvtvjZfq+/AsTlZeSjH?=
 =?us-ascii?Q?2ffhzdQ+EO2Tz+jthvbQvYn70Z/Nc1wGH7It0OulQ7ZaPYqxK24MTzors3PR?=
 =?us-ascii?Q?hOs5DDUDdVP39t7/hk77Xie++qQf7I4+2VZkx1w2k5RwcCRNy3M2sfzs2oaJ?=
 =?us-ascii?Q?buyx8E8iwrasLRf1oL/hguvz4I48qlWXOQ1aIbbWpxebKVtve1QbDBc9SRDv?=
 =?us-ascii?Q?pbvhlGvc+Ai1hhq+jWHs1XvCvKUm/udTU2AbLe7lFnWVooErVvgB36YkYo3Q?=
 =?us-ascii?Q?jV+X9vg2o9XRZ+r+1yLz/aMRdzqyC55Pv0NGQX7mD6u9vSN8EwEMsWWaBymZ?=
 =?us-ascii?Q?//nzQPfvPJWYRmyxL7cRHrQTULsrKW9OTH/T6526Syc5fho+2PyD9EogC8pH?=
 =?us-ascii?Q?EA9hrUXGku7hHXsCDRaGidbC09CbiYuO0h65HNpPcN47ijvMYC5pTyM+f61l?=
 =?us-ascii?Q?HRgv2odxUKYyL4SoJuk+jTpiuGMQ3WwjBuYxZNUU9E7ZVyBXFWhM48FT/EYM?=
 =?us-ascii?Q?kogvSp8EOqrtT9kUqinjYIN1RM63FbCtctCMgEZ15P30HdqSBoMe5SWVLjQt?=
 =?us-ascii?Q?sPek1QhDRghirw/GFA22qj6Y64gQJGAkPNtWUJcFDx9SfetVFnxxG0Ss256w?=
 =?us-ascii?Q?ZJkyp9hftGszGYjJzm6fa8AFVQz463rUjqqGsAr7Bst0+bOG3wn2hF30hBYS?=
 =?us-ascii?Q?g1RtVLqI7095BYECKDDQ7nT0e3vTQSnt33abbvjM9MRQKpIK0Rv1XP2hb7XY?=
 =?us-ascii?Q?sOzHApXlxVtRR96npgzlQwiiSwsclkFV4vCSzWFiqM9utP/hnFbAQ1Or3VbO?=
 =?us-ascii?Q?iuqacbjQSfk169ofiAd3x2/qdxiYIF8USpenDyo4aESxuRbnuWkJrZCmUfez?=
 =?us-ascii?Q?mgCrjrODl7pDApULYGCh60Y3dnhoTulePb+DJxz6g/WT6nuN7mCgA5wcEQYb?=
 =?us-ascii?Q?M0UaaBesvKL4AlPoqKHv9MuVxYnnLPSE/+yJCirA94JM7pwH7SYlnFuwPUtj?=
 =?us-ascii?Q?Xx1uWkiM4WR1uhNoHX8Zg7k+ycpDwS7DeKnC/c9wXcslYct3qPryXcJYoaz4?=
 =?us-ascii?Q?P+L1U4yljW2wAayOqxCiPPuY1fj/WdZd36ED?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:37:49.6588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c92e17-3f99-43de-2413-08dde3a1e92e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136

Switch to the new API for fetching DMA devices for a netdev. The API is
called with queue index 0 for now which is equivalent with the previous
behavior.

This patch will allow devmem to work with devices where the DMA device
is not stored in the parent device. mlx5 SFs are an example of such a
device.

Multi-PF netdevs are still problematic (as they were before this
change). Upcoming patches will address this for the rx binding.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 24c591ab38ae..c58b24128727 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -182,6 +182,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
+	struct device *dma_dev;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
@@ -192,6 +193,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	if (IS_ERR(dmabuf))
 		return ERR_CAST(dmabuf);
 
+	dma_dev = netdev_queue_get_dma_dev(dev, 0);
+	if (!dma_dev) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(extack, "Device doesn't support DMA");
+		goto err_put_dmabuf;
+	}
+
 	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
 			       dev_to_node(&dev->dev));
 	if (!binding) {
@@ -209,7 +217,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	binding->dmabuf = dmabuf;
 	binding->direction = direction;
 
-	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
+	binding->attachment = dma_buf_attach(binding->dmabuf, dma_dev);
 	if (IS_ERR(binding->attachment)) {
 		err = PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
-- 
2.50.1


