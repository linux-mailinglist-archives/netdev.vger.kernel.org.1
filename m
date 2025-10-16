Return-Path: <netdev+bounces-229867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78CDBE1792
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D5F19C3E80
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A573222596;
	Thu, 16 Oct 2025 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tefdVrOx"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA09748F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590893; cv=fail; b=TQrYg6aiF3CqCLb4jYQPoxnFZX/MBu7X8FVYrmfHx9JYRPK5Y5AY3USIyWY4xPBu464JO5lCXTmiSDOUPvsGrfMxRiXrrQnYsW94KyhiEt7xt9cpzA2yI51yrVoqS98YTNOn7wmDCaRxf5LpgHlCxOtXmUCYx9PydcXGpi/2Im0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590893; c=relaxed/simple;
	bh=eQYaOeed25xAJwqdTJQ5nuZ44zxjnIJmyMiZeP4ba0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/SJlsvFT4E5ldh3wuX+4RaRKAbwGljrYTgE+EAW2CCZDew6IQEgYYzFIgXneVjPpbTcxrC4QjUUh9LkmamKMygGkezimnOAHZZeFI9zcC9XiiaOVtP6t3CQnTivjsHboOxCqre8CCl8NGMF4Iabx73vBo1M/or+D7yE4UKuQ9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tefdVrOx; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROwKmyJwt34jGDPhfOVnD8Ql7AMgktn/rY2SpxbXJHYFEhZbKrVz6qc9Q32ncpDSFnvS9S4urrVeYVgTSzvBl5W6RVIQmxXMuBbqM51qDApa4p7/DRiT0ZcjuAL9sp1iIuWlEByyXD1+/e8Nj4qv+V4XltFF5vahz6T/sC4VMpEgMRXolZ4Un9z90NX8R4GlSkr99avZx5HOSSux0Eb+6EGLuCYuzRFQY5sU/ZTuVBgmmwTLcDgznxq9MBDGqrM7WrTzjksEzpoVRvaadWBK7wkVBinwauXKfJK3lji0JBwTNWZjcME382ryNFryKJ3yQf/Vp17XqquTHthKT3pdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3+syFMIdPRsSwKv6dIasPXpigAHdg4yKUCrBMjbzVc=;
 b=a4sTK7t3zowIhG0Hog2eEZo5iCJ/UTdDwQdN8LOHFVR5nRYSdb3I/0w1p38KQGiOjLIBLn52tk+vb/oVr5ytDRKeubzy8VLPSVhTn+0OYXQz5W4e2hMqRb14dNUxIudtA9uXjgccRJBvdP67cnAE+knFlxRyPfCimVY/zv3T05w/hl2KOeRNy0U0Ix3QjGlm71henoMOwri/bMooxa6Rok8DGXillZfXE/uya/pnJdBi80biAj32ITqYH0Izw3zA3dmaigMCvlkeZPqh5NSz235DFX2i0/ARALfi5w1wAdnI27RkDNiCHutjm8o3HF09tFjJvyAd6y9stQXPenXr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3+syFMIdPRsSwKv6dIasPXpigAHdg4yKUCrBMjbzVc=;
 b=tefdVrOx1YZQrncAJfdktEHumz+QgywtbUVE15sTMaYX+bh7jwqm/1ftlJjuw56VYmF+zGbvH1nVkgu8w+0oyW9O2Ctg8RIMuWnOlmF2Pf3o2sbbuVJIXuXINWqw8LUEguCSfJABvYwop0ce81HZAbUvkiG3BWFEFyX/4cmt1tesXSTxjkSGj7I0UlB9wwSvxDLYQS2nBZg9oMrYNgIuLYBGiZ4LoFQ3lRqozpQx8OlSqLzLScZF0TeaCWoudr60DmPs79Y5wK7nKaucoVnehxLRp6FFNK9+N+y7o/VWHScNPCKbcMMRofjnsH9h5CajVXxqnt84qGW81NnPaleEcw==
Received: from DS7PR03CA0180.namprd03.prod.outlook.com (2603:10b6:5:3b2::35)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 05:01:28 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::ff) by DS7PR03CA0180.outlook.office365.com
 (2603:10b6:5:3b2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 05:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:18 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:17 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 08/12] virtio_net: Use existing classifier if possible
Date: Thu, 16 Oct 2025 00:00:51 -0500
Message-ID: <20251016050055.2301-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016050055.2301-1-danielj@nvidia.com>
References: <20251016050055.2301-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 574ccdfb-6eef-43fe-df0f-08de0c7110e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?axi1FggcuuUVAXGIbttmRCnndhKEj5hvDAWhvUdQlHS2A7aRmMC15ROt+cvu?=
 =?us-ascii?Q?jNaTmk1RuT7Tt+qlBr+NlHDbAYN09NKBgiDF5awAlsBWHUFzgSWtxsS8wNGm?=
 =?us-ascii?Q?0RCu/uWtE8UvYk+uGF1JqJc5cS6incJaQbpm0IlgRcJvUorwRMOjVTWdJKZZ?=
 =?us-ascii?Q?5Fffgm9IqtH862VSoItCMIBL54GBr2t/LZGqDn1yqiPWaHdDGtK1h8B4FG7O?=
 =?us-ascii?Q?WdHWPx6A8CB55MxWU4ZhEOQIcJ97/+SZ4puZECn3dW+esdldOqdlfYurkLEm?=
 =?us-ascii?Q?ahcz2eugzEAbPebwn5d+igRzVWTNp3Ilr9I7CU9iXyGZ0cqknEfQgK6jSyHE?=
 =?us-ascii?Q?otu8dBsfucBnRLQdliK6+dekzTKugB4hLovKUV241P3pzQdGOTOaMQb3MeS1?=
 =?us-ascii?Q?k2TfDiIJrye0QC1TjRBk2QrgWhaRN0ug5KttA6eXsF9rl2K9+ZD0IT5UY98f?=
 =?us-ascii?Q?IbNaS85a+hhSbOm8xrel4GqbUpmCO8Vluk01Hc2ZTpwueXlkLPC/TQmwPHMj?=
 =?us-ascii?Q?bhqDapBeinM7BRLU8x0J/BlMslvrk8VaXKRQLJkYToAkByJgp+5N1K5I7N6i?=
 =?us-ascii?Q?d4wvYFa3ozEDiRowB7R3AmBj8zpl09U6iRVF8niy7KT70PPg1BmQ0Gtd8Q1g?=
 =?us-ascii?Q?2yTNZUc+PIU8MBq995rwoBNd14PHFikCNU302iFuS0bWBlMm7JL0gW/Bxx0p?=
 =?us-ascii?Q?KIg0DGEcOgN6N083Rqdh4cMVfQA8Qp1iNCHhH7+XuWHtM9kQ/m2m2/BZsVcu?=
 =?us-ascii?Q?EY7qiYGs414zr1rH9vBZsspRjerbRrbxYxzPMWeu1rFemf+1CaBrWKsZg8Mr?=
 =?us-ascii?Q?g05qe3BYgI8K2/oMve009baKLWupfPiLuEd6NRkUfmWREBe0ARZeKX7IJoZd?=
 =?us-ascii?Q?eCvbcckPvKSTFXQSjWtXuSlFgOJmHEsVR6BuzX67XVroOEWDE6Vt9K9IZzoJ?=
 =?us-ascii?Q?iT5Pgb/fJP6VJvYTATf/B3OlMkvWzlE9zcLaJo/rMygCrHmkLUyEHV/O4a9L?=
 =?us-ascii?Q?0x2npsUIdh4eCKD8GrRZV45ONL5qmB2xNkzywx7/m+dUYr27qDYBj42lAGCZ?=
 =?us-ascii?Q?h/QEIN3qPZm8+4jzoBIS9Zyv/fYngwT9eU18+zKMa2eoiGSwetcXJ6o9Wm5P?=
 =?us-ascii?Q?nZ3hQc+5Ep8XHlWqV9e1qYd0oVX2h8BEhuGgQWLuFHJlinPoIEmpuVBKJXL3?=
 =?us-ascii?Q?A6IhMc23+zsgfBKhtwbKrk13vftPnljN6DhAlUF4xjhaLfuBSBW/WVLgWuqU?=
 =?us-ascii?Q?o53WfeXxYpI3H5ZkI23cVzRIM6gwNdOMvRhgcrcP/FkqbUirTQ+b+30QMApz?=
 =?us-ascii?Q?ts9k6u0zPhRp29RLZcViCkk2KMah4blKOB2RPpA5y2qaiVwQQG/9WkLxsg7p?=
 =?us-ascii?Q?NwjqO1EAjFBIR1qTBdZKSuxEqESqx1NnMtBc/WnUJuP5qiV9Cxueh1j3YqVy?=
 =?us-ascii?Q?VvWkL5KEBOX5UhnXjXqF5CBtBfkUZpXYm0kLpA9yKn56M2b6UCXQfkqX4xdc?=
 =?us-ascii?Q?+aXuKviIAiiQVL1AunIvpvolVZSFr1sKkk2Pp0XHEOrLKe6PaLQfScSJ37XE?=
 =?us-ascii?Q?FW35l9VLWOttDYFXxCg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:28.5857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574ccdfb-6eef-43fe-df0f-08de0c7110e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4:
    - Fixed typo in commit message
    - for (int -> for (
---
 drivers/net/virtio_net.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 405ffc015272..e7816e1cc955 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6806,6 +6806,7 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -6899,11 +6900,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
+		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
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
@@ -6911,29 +6925,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->classifier,
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
@@ -6957,7 +6972,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -7082,8 +7097,9 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 			      int num_hdrs)
 {
 	struct virtio_net_ff_selector *selector = classifier->selectors;
+	int i;
 
-	for (int i = 0; i < num_hdrs; i++) {
+	for (i = 0; i < num_hdrs; i++) {
 		if (!validate_mask(ff, selector))
 			return -EINVAL;
 
@@ -7137,14 +7153,14 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_key;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
 		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


