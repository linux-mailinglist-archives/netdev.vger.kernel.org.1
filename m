Return-Path: <netdev+bounces-238114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F95C54387
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E84D94EDA9F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23506350A2D;
	Wed, 12 Nov 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hIY54Oy1"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E32E0904
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976128; cv=fail; b=d1s4NEhA2lb78d2PJn8jfvU4kLolygKdwKBkaH0ke615OdfclSGKG3B2QZ0dOwdK8X9aqHYi5W/qZXk5VUy3sso1RW6XB+6LKkY+H9NYyFk39a31usrNb779vjLjKtifd5U6NE1fHS0ap96POEdgDedxCMhgK0pqiHyYGDQ0Buk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976128; c=relaxed/simple;
	bh=5G5kVKQ5pFExinwmnhH9uNbcqHi5K9IWNwTWskrXbIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFg6q9OrxMMDtbQ7wh3xKIYKWhGQsuQT2PS9ZoU3zgSz5yKqNpYHLXwd1cZrJn43fhXWYLHdaiLSBj5wxFRgfazBaRES4mhwZfuHX7b+ZHpwHFLFDAKadiYbmZFZwocwSBPvdYqNcDiKyUOECo+12a1u4hCqnyf4XoMI1YyNuxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hIY54Oy1; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHccG20IbHIYpjUT3TzQBJKwhs+rmRPCwfbY7DbxnWcHKs1wAUTtw0RMM74frup+sxFgJe2Lx597biWhgVGqUl4YpJnpzlmkdoNZKt8vJ4tpGtvVrZxWX+stnigXFUALtVi4AjVQRdwuyyBWzDkCRBHZkMl8pmdakbJWwi/LWwubdJiOCJv02+2cEV+qKI7tjfOutwKOpuvPae6KVblJlaMGcUgdGUCLuDQeyXfMzEQAsggzIb4BmJJBPhm/KWf/RJKiwLGyxs7PiJtJOUHXCbHjpFj0oPT1t/0IT4FREAUaqOGBjTQ7bhwcyYflM8EHAlRnttGB5EBVi6DvzG8LNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXgBohQ7JiRzVcqMvbPwdA8OVOSdbCAay0wzSfYb6uE=;
 b=TGUvxDaB6CxpqhUq9s0BGlikTWoENHkIeowCPB4JDJltH3xyWs2eBE6xP4SzxauZ0znlcmBpoqr0fTeBB4tyA0QQiyvgO1shSkdJV7hjL9tOo4XOmB+Yo1NQbi9IPeFXBEH3GUgYtLlPh5vLUY055CMO3CWINeCOWiovxcKM5bIn8LBv3FkFqMDO/+RU58xVLJWFdo9FeXivDG048aOgO2mFmWHfaSLWSsY9jntYbS3BDM5slW8a6TaMnssJYcnMxXnmfbquBTnIwz8KjLjz775AHT6EY6xD6On9NOA80gl9vNK4VRtSn5V6tzU0xinh2x6QP4Vd/M2ah9ALjzPtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXgBohQ7JiRzVcqMvbPwdA8OVOSdbCAay0wzSfYb6uE=;
 b=hIY54Oy1AgqG6kRzbe8YkmUiZ39las6L8z1e45zr4AfyB6rsEDvYermtyGCPR6kVqkWD0hroQroY+ibq+KrKQHXna9r+iYbqwc3aeRvZZTU/aBuicp0X2x3chpdVhWbCJZ1IlijjO2EMGtXG0rrSum/FBBpC6eYaVLwnAjhiXUwlFBFsIvh2lE5DEN5rrzu1+C07F7fltbsKpuIRmWowTS/i70QX7bEPe2IcUeVI9b6g2HWsZegodOVtxev0AV4sfistQLtizlt1cDCkaiWJJ05BCqdZn7qHK6Sges6BQ8eYsB3nVKPrLeVl075yH0NoIzGJZN3i342mPObtjZ/2kw==
Received: from BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 19:35:20 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::29) by BLAPR03CA0072.outlook.office365.com
 (2603:10b6:208:329::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 19:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:35:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:35:03 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:35:01 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 08/12] virtio_net: Use existing classifier if possible
Date: Wed, 12 Nov 2025 13:34:31 -0600
Message-ID: <20251112193435.2096-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112193435.2096-2-danielj@nvidia.com>
References: <20251112193435.2096-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fc3459-c34e-4c0b-dbbd-08de22229dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+ub8XlTUHwsOXBWWytJXYnZq3wJBglta18SAjMbjnHgbkko0jAwohXg1x7/?=
 =?us-ascii?Q?wibLDlINryHLckBWvidJ/3T+uKnrKfO3SFBeh/qDvVuV9/NoqmMuL0sH7sqn?=
 =?us-ascii?Q?1YZhlNqfstI0x2IjbqAnxEzt4B+GPoiiMgsLfJmnGuKi62m2oUm0++/92Rep?=
 =?us-ascii?Q?M9D6MQi96aMgp+vC1I2Idc9ZjW7gbyvtaqofsaIYRu/LrnHFdw8h8WOIPv6W?=
 =?us-ascii?Q?o8Z6j98lJN2flVxfZHx3k11EE5+MFhKS4MF2Ou1WEKmk08YA6gF/Uvhwejfe?=
 =?us-ascii?Q?KHnmJH/HO9TIfk+jH1UZxxkEJkuO5BpCy+LnUgx4VMijY52lGirOiAolvc3I?=
 =?us-ascii?Q?c6d0DaDDF9lumdnX/lL/tfhWmvoDuuSP/bxvuqrbZtVxkMJu+7uWBcwv98gH?=
 =?us-ascii?Q?S+eKBfz0yHiEVDRSfphfmL73RkgNhYl3P3zojYAS7Ai0q30gpC9XFxdoCVvX?=
 =?us-ascii?Q?4WGsxtNQicvnCA9vKIYknjknoyDfcqxY2J332ql7n83ifMyBL2PL43Z6flLI?=
 =?us-ascii?Q?lWicKbh1/2mRSMzdwD5Oztgm/ukuGe+BD5Z4dfpVxtIUxcfxQBqcicM0n261?=
 =?us-ascii?Q?X/stzPYZB2GDQmI/bC+gwTBTOIsHfuXx8beM7Il3pYDQuI4uBthoZh6qKyQd?=
 =?us-ascii?Q?0iVi803z5vhpXqx00xnp1iAGV+xarceovU2zGhymEOlOwJbkrjBHosuoYa4P?=
 =?us-ascii?Q?mxZ9VIBZM68+xX3IMy/3YYs7cmFZSrp2GnGByHsl3b2onKw0wJCiyzkMN1Wf?=
 =?us-ascii?Q?l1AIyCDogOYa0gVYMqMpXEjmYFQM4yDZWyYO8LROo6ZLDLeOZroPII3a6T5k?=
 =?us-ascii?Q?Z/oT4kwjeW00FkQQjpmsx+XHJot26XNANONoUnU0N1Jgu9dKkZbDJrVcl58q?=
 =?us-ascii?Q?Ca8TKF87EkegSbdFy8+wm8qD04/k1sa1W/xfArDvpOBJ4nvq0y50gnPcYByt?=
 =?us-ascii?Q?u3sk8T1FzUOSmCNRpihkKFu6Cg3d8TKavJdbtf0fDwKOUn/XhTKIR9NAICdF?=
 =?us-ascii?Q?pnt+ga6YpHCS00W/txt1DRee6DHlsPFTt4BXh8glbJYxk51KiLqgnc+loT+i?=
 =?us-ascii?Q?A3UTFnTyVVp4iMXoS5S+9SeD4kqTzlVoTx2QeOgmT6QAYDIGylYU4Qu9Q31q?=
 =?us-ascii?Q?EVhGG0/ybWiTgjwm64aa0fmFxLWz+h0UKiV0V3C4WkfAWvx6Q4p4yyyIYhBA?=
 =?us-ascii?Q?cWtXHSAWsJLI4HCACLHwpjcu8X8O7qy0FI52+wqZxNyX0aG5EGYsb+SxrhZY?=
 =?us-ascii?Q?JaguUnBetqzNIDdhgNZuLLcvHXQAOJRePA3s0vUL0TJUHC+0/oJ/6ZikQoY9?=
 =?us-ascii?Q?TRDpnK/kp/ZSJUibBRG/0Ex2izd0LWU+HW2H62O99yeK11NB3nGCwHqsj7yM?=
 =?us-ascii?Q?6fti2EhPw9wI1ki+pKRylldVLiUFoQHi9ncCySe5oNJpHt1GP0uBaK2aMw3M?=
 =?us-ascii?Q?uY1GBLVcN+gJkaGV9FI1NT6YUTQdv67IljYTvVWHcxQefRL8G47wOuUc/+b+?=
 =?us-ascii?Q?4ocWEUSmv4spkoX+93kDBhMAOHw1WfUhpnubMcwlDMF+8x0yF7dbGM9f9wLr?=
 =?us-ascii?Q?R0xEKlCfUeKPqM2fOb8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:20.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fc3459-c34e-4c0b-dbbd-08de22229dfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one.

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
---
 drivers/net/virtio_net.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 199d1a076cfa..e09fea6d08cb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -299,7 +299,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -6821,6 +6820,7 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -6914,11 +6914,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -6926,29 +6939,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
@@ -6972,7 +6986,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -7153,14 +7167,14 @@ static int build_and_insert(struct virtnet_ff *ff,
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


