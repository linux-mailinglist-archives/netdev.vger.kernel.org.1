Return-Path: <netdev+bounces-242008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D139C8BA8B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93EB24EFFD0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EE234B1A9;
	Wed, 26 Nov 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QgxIhDpC"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB46341066
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185797; cv=fail; b=P71KW0DDVFUs/aPgCuI/1RVwTbMt/OzPrO3Qdjz8EbzzWFSseCC7EENfb3XH0sFRzDnWwY5NzebOblGPAijKbpGbMVkl7Ri5knLBO+VszGlHZkw1N+ZjiJ1jROWEh/C09o/1hVEcHm6LmGxcc3JXmBG9TRnizaKapaVLD0xAQ9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185797; c=relaxed/simple;
	bh=zHNZW+qxmfh7rPzgqt8boyXvpdihrxHN77nNElpxuK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIzxuLV2HfdFSC+l/QcJ3MNAX/FQylyQCvfJecLvmPPuYTUeFkFjJ3+myr0+25xyC3ESSYcK84Qltbyob+QTWjKbpyKbkBc0VyTLQ+J4uyATSyqw3Qd5MW7qtKvvK2vKCkxabZsRXefuHIE7+9KmZ5USlmkfdHIwd3B/LifdR9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QgxIhDpC; arc=fail smtp.client-ip=52.101.85.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQAefNzmJGnYm84+59gCjxD3Gm9uZRAioeiMQ7EtZ3xIg8k7jWTYlXJMJXnRcm8VaM4RclLbtIByv5vChIQ34lyB41fkQx+JysCd+7inkSpuS8TMCUL+Vof45vwOCeeNGB54Vd9SiBcP5nQlj7+PMETHZfUOHmbmWgfuUCFbXeAhaNp7/d79SEK0HU6mhlTSIPeJBZkQdB6YW6kyZGztNciS6mDlbJw2ChRkE7vlIcZOohoScCjk6RegOeBGh+Gu8ILxfRqrLFLwjkhaplE9MWHmYj4zjNfJfzHtu0p0H1y6WnlrW/QRZgRsW7T+ymfS/0OrXRfDWRZWrfZaOXnY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3K3E44knOQ0jpPIXqT3DfVtAxo3WWALY4n5FtPOSaA=;
 b=iy1ir5QRqmz+fHroDpVyD/PukfK9315C0V54UMFEswpbl2tX41Sxghheit8wQ8qERHDMbUoLh9wWEqkq+B0osyPfAtkZGdrR8dXKF2SB1+ZPuIlEdhFspjRhXMlTt0YPctKH5hVyEIPTN/kpyWVsRpseddG4vOXjMQlszCXUeJg/QKADyr6+PSdSWVBvgvP8yNGxpYPXsrBp0DpQd1yfRbgW1/3n4ypqMca7axWiTYfzcNFgqJiRs5KFWMtOteFdJpvfJ1I1S+K2m3ppJIxpLhXK6k/koS5CXSXpCrBwEbxmqjzPKubWFM3BK7daz1jH2LwLlKIp+Xz1P45jc2goVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3K3E44knOQ0jpPIXqT3DfVtAxo3WWALY4n5FtPOSaA=;
 b=QgxIhDpCu3din2L/jygPCRsuyDnSUWojRKIenkltCizQFQT/k73FxIZcBA8ffKVKkXYp4xD+vpYe9ogNfx98ub8Bk9J00ftGc9BKxB9dfbDVkUT+73aEVoWNKbXG/Swxz8Twu1xd7Ba2jDfPHqQLhY5mU4nhs5HUiK5l1JfIBExzUqFWKqUafJqy6sFGCfVAcVw5plIteasODXGPvITI+jz8GLhHWW/xtmTNOLN5NCtSQ23N+ovSDN6jEWFuEulq1KyACzTz9Roiniq9rvQnXO1/rDjQJLgDsyRmQK1WSU5Tx0SaBQrGii6YrpzU17ZZPzOUSToUpVJna8dlzZ/gGA==
Received: from CH0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:610:e6::15)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Wed, 26 Nov
 2025 19:36:29 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::6d) by CH0PR03CA0280.outlook.office365.com
 (2603:10b6:610:e6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 19:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:36:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:36:08 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:36:07 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 08/12] virtio_net: Use existing classifier if possible
Date: Wed, 26 Nov 2025 13:35:35 -0600
Message-ID: <20251126193539.7791-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126193539.7791-1-danielj@nvidia.com>
References: <20251126193539.7791-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cce48e6-49ba-4d51-5074-08de2d23189f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IJoFtN0BFOu6+55RHfgbx7bbrxz9k+2k2e5iZbBrmgAFaOKFjs3MRqPbatrf?=
 =?us-ascii?Q?WK04RdHPKClTe3bqlzZ2cpX/hSy/CRyDYRAHKmZD2l/5D7SUywcCc/SMtHxg?=
 =?us-ascii?Q?48tFsqxYxlkkAj9P+WpiwDGCmP4B5Is7IPdb1dfNSyaJPYKPgBgKSqZ+ycgt?=
 =?us-ascii?Q?0hokh5f1txbg6WG5bp8ZDVWcAqdQawBW0PMgqbv+qRot3alW1b8BFf6ZIvse?=
 =?us-ascii?Q?xslO451gAVqAWI+sv/D/qAAUAuv83LiawRnQcrG9t9mkzswvcoyU8DzizaXO?=
 =?us-ascii?Q?y91h/+UR7XxyO4/ylWviBXuLwM0vrje6u8QbsdszAuaH3XaEeksJr9P/nd3u?=
 =?us-ascii?Q?0qsOAEeYx+3NeH45lTl2W9AyJedAOB3duu6XqK9krJCPDroWaBFGhjfolTPC?=
 =?us-ascii?Q?KtLiBoMYxjpQefD2S+gg6AtsLQ6D14I7Fy1P2D5958X/4coqratpOShHNFnE?=
 =?us-ascii?Q?bQTsohFh+8sNVpV5Yt58LLZES2WIOIYjbxVtjESYC1Zl2OaNgRqcxjGlWu3b?=
 =?us-ascii?Q?4zXtvBvdja+RQUuHaadyA/jZnJYlGv5GapqLNYfbRcS1NT/azbrsKnSVaRFF?=
 =?us-ascii?Q?M9I0M9ytpx3iQOpovNkWzhn4DIhmmC5DvWU2fJY3gNB1u2QrBTupFKJsgzBW?=
 =?us-ascii?Q?LxifJ4DI2A3Pugd+Dj/C+eBgtid5GWuQfdkFyYChofbaHZgG2zQNWDVK/3dK?=
 =?us-ascii?Q?J4d5WQ47Rq7gchIFayQYWnjFreptjGmy/jzjBn9POtD6D7s00hNRszBZiWJr?=
 =?us-ascii?Q?fsFTzNLa6NQ2pjHPP1BM9m3Dm5wNKnk+4cQkU4aL30N6QSBftX0nHIKUwKOO?=
 =?us-ascii?Q?J2XfYAkouXrvROkg6wdJyLPT3/VRc9Ktc7GQXmLngiKqumK1UnumIAS6XTEO?=
 =?us-ascii?Q?R9IvROn0MifJGcDgHUm0B8VMm9Pt3T1lRVYk2WicyN59fWx0taOPEcqRcFUi?=
 =?us-ascii?Q?lZRkXXh6B5vt7tJ/gSiKtGnxFnPql0Fi+3zscY5NUnstkJxcAFvW4jEazVnd?=
 =?us-ascii?Q?CYuUKD1+MyOFk4+xIpqh7aGXZ/XW09U34PDuJ6HRRR7eLPSdfHa5Kd9uP1BI?=
 =?us-ascii?Q?CLqL7j+VOjK0I4BHLZFyKJYSuhnfP7F73QbEbzxCANmuHRFoPPLLSj03hZB0?=
 =?us-ascii?Q?ZAAj7z7iDaKMmGv6WTJ5mNumvbgoD3d6L7ATduIHD01aszkLYHaRQotPxgHG?=
 =?us-ascii?Q?vEw8a3oCc3t3OiLWSqu0Ycu1a5sUzovUGLBAolDFJmOPrW50UX7UQ5YUz3Ai?=
 =?us-ascii?Q?QLpndSNjPOGsj0zRsge1xhheuv0ryr+iDii5xy9m0IIwCdIMb6zW5ZGv5uIq?=
 =?us-ascii?Q?nwqtBiY2O0neTbX6SG2B5dbyxAaJPhX9vsDS6fBK0CAqBkkoK8qDdp0VM5bR?=
 =?us-ascii?Q?nmyH6y0rs1KNFshFyIxHMxGnd8B8hUrfCGGJMv+jRCYHGDwRgSF19YlVxbIK?=
 =?us-ascii?Q?Txlgz+C1JwwrCtZB5w3XThxazeBF2j7WovauMcKvLi7wCD6ixqh29t/QIad/?=
 =?us-ascii?Q?ELt2jVg3bq/pBYSPSkHixNt8raAa3lGZ7kDrYJcLStB4FfKundt3c4aYJjxm?=
 =?us-ascii?Q?uaatyPTNwWEaqcCbmWg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:29.1958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cce48e6-49ba-4d51-5074-08de2d23189f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one. If duplicate
classifiers are created it would artifically limit the number of rules
to the classifier limit, which is likely less than the rules limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed typo in commit message
    - for (int -> for (

v8:
    - Removed unused num_classifiers. Jason Wang

v12:
    - Clarified comment about destroy_classifier freeing. MST
    - Renamed the classifier field of virtnet_classifier to obj. MST
    - Explained why in commit message. MST

v13:
    - Fixed comment about try_destroy_classifier. MST
---
---
 drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f2a5b4339db..026de1fe486f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,7 @@
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
+#include <linux/refcount.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -302,7 +303,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -5824,12 +5824,13 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
-	struct virtio_net_resource_obj_ff_classifier classifier;
+	struct virtio_net_resource_obj_ff_classifier obj;
 };
 
 static_assert(sizeof(struct virtnet_classifier) ==
-	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+	      ALIGN(offsetofend(struct virtnet_classifier, obj),
 		    __alignof__(struct virtnet_classifier)),
 	      "virtnet_classifier: classifier must be the last member");
 
@@ -5917,11 +5918,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	return false;
 }
 
-static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+static int setup_classifier(struct virtnet_ff *ff,
+			    struct virtnet_classifier **c)
 {
+	struct virtnet_classifier *tmp;
+	unsigned long i;
 	int err;
 
-	err = xa_alloc(&ff->classifiers, &c->id, c,
+	xa_for_each(&ff->classifiers, i, tmp) {
+		if ((*c)->size == tmp->size &&
+		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
+			refcount_inc(&tmp->refcount);
+			kfree(*c);
+			*c = tmp;
+			goto out;
+		}
+	}
+
+	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
 		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
 		       GFP_KERNEL);
 	if (err)
@@ -5929,29 +5943,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->obj,
+				      (*c)->size);
 	if (err)
 		goto err_xarray;
 
+	refcount_set(&(*c)->refcount, 1);
+out:
 	return 0;
 
 err_xarray:
-	xa_erase(&ff->classifiers, c->id);
+	xa_erase(&ff->classifiers, (*c)->id);
 
 	return err;
 }
 
-static void destroy_classifier(struct virtnet_ff *ff,
-			       u32 classifier_id)
+static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
 {
 	struct virtnet_classifier *c;
 
 	c = xa_load(&ff->classifiers, classifier_id);
-	if (c) {
+	if (c && refcount_dec_and_test(&c->refcount)) {
 		virtio_admin_obj_destroy(ff->vdev,
 					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					 c->id,
@@ -5975,7 +5990,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6147,7 +6162,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6157,14 +6172,16 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_key;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
-		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		/* try_destroy_classifier will decrement the refcount on the
+		 * classifier and free it if needed.
+		 */
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


