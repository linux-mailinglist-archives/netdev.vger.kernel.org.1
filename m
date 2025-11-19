Return-Path: <netdev+bounces-240124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08396C70C53
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 859DD3559A4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330736CDF1;
	Wed, 19 Nov 2025 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8RM2Ufl"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FE2F6186
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579779; cv=fail; b=tlCoL4R/2CqwT5Yzmvy6eKh9v9hMEmRGrEYxorTDwG7sTvuTxQcxkZVyDIY1Od4+39k6Y0syL3CJhfam4v1dR6SYga6FHedkqTHCpklEIGXMyVc0nxEoqwjZeEJJ9PNJXPcnICJlU/gulKm93h+Q0HKnKW4pupgUOrdK55vQukw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579779; c=relaxed/simple;
	bh=gLvjEGXEw+8O/VTZbk33DgFu54Q/kdC/rqtkndp/XNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHEbC2yGsXyfewNtMPAYRtn5sDA7njU5q64/ocu8Uoa2oGzykhnWm1bqsV/mJeDfNcFE0MpiTnKSclmel3A82npp82JfKTJOpeq/PWmrgmNSxZb7Czzr2W/bZtTLE5jTYgnYvJSCRoJiJXV0etISaxy/3Xw+uzMxW4XlTrUfOq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8RM2Ufl; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWsVuFtRuqx1baLbmvXkk4JO/NH3YSPLc5opIIfeqDb2IRSHb087/Kt+iHCrffpUI8UmNFvnroM9BaF/pO4+4xPgq4EGBiTYurIsSBbER1javerHpBsaGEh0cTgLFx3OU4jR7OQU1jS6IUshiyGBlARTDutsaNZXYFLM0k3WLZzsnneSCImygiX9RVohRALCHPw6HA++PCJRqlA+KIYM/Di1a2DD6TA1eLNAAamXEcI4GzuOXNKRFpgsPrLrt6VZjtqyW8G2F3ujYRXOfMzphh3naLRVk+tILXsNkz+kTosZiHtCuZ7D4SJuI4UZ2wHzCS46sHX5o7cHshi20xNo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhX6thZJaJwAPrvqr+Sbzj3W2Fu4+qny6gbhS1b1bOA=;
 b=AOXsh579PFPT6JdNR3Rgyncsvvold4FxMA649nG6N/gbBD8gwH1zE1D+yf5D86hxkNNSO/PxAf1vIKALYbs+396e5d74jxdyf/WF1/GfljiO6NgTcevwhab63Cd6nkYQ4RUtc07O37uvRs5Qy59dmv/wjr+nTVW6Wj9+SqpCm4Jul4sPY/+Ed5+DLf9l7XI7fjJdBfNssAkPruka/tPPApK2fjNUUBslsI2TJvOLXm8mRr92Fiytxj8/MgdwFXlck1mGh8XGT0mRHjH7D+6yrgE3cVLGCU6GaCBTTkrR9FewOvuF2DXH/v2cAXVlXzNfSju87+AW1+q5hphEn1Xx8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhX6thZJaJwAPrvqr+Sbzj3W2Fu4+qny6gbhS1b1bOA=;
 b=M8RM2Ufl96MoPbLlVK3DzYMIYP53Q7jXO4kmntoRP8TBHSsByNsSwm9V+VabZUfg6Yz/u/UoZHWxvYaVf/67o7XveSxjE7Lnq+whre3oaL9muCvkM4HVlU7uhtAkV05rJMXmsqN543Omk8U8NIGTsfE3zI12YdOUmqTwXOOu8GxtkoaHpXPLhPz0m9+mAFxQYR2Pe9Cb88Sf+ay2/aS+PvqzL2wbq+bY19kL14ei89JrwI0W4dEZFE9kE54kRvVzkU/DC69NK2kJc78HD7/FgBnJ4d2leGKj8qfgSnzgyg5U6MEUy/JXHTZnEK3cJ2gRB08/h0v3bKeqm06sYCwoRA==
Received: from CYXPR03CA0069.namprd03.prod.outlook.com (2603:10b6:930:d1::9)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 19:16:05 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::2b) by CYXPR03CA0069.outlook.office365.com
 (2603:10b6:930:d1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:16:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:43 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:42 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:41 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 08/12] virtio_net: Use existing classifier if possible
Date: Wed, 19 Nov 2025 13:15:19 -0600
Message-ID: <20251119191524.4572-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe7c04d-b6c7-4c67-f5bb-08de27a0162d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CoJkD0RfiMVUGXSCRKR/sRdWwztjPvAOO+fEZOaC23+iMbj4Q0X3UpVji72?=
 =?us-ascii?Q?TM3f7S6fhsTXC86gHr/HX5B4qfP73LXGQWocFF71syn8woAHhPeU/dhLyybs?=
 =?us-ascii?Q?NWIAiPg4lvnEOwebpkI2KBRSFdjUa3g4geLSawW449q5UVE/5adPt1oxtskU?=
 =?us-ascii?Q?ghNx1zlRzvit7xtnq1Qq5K68Iu6C1U0MlHwx/OKLKq++3u3QLW25bt/FmE93?=
 =?us-ascii?Q?ilVVdQm7e5uRBDAyYOxtYP3Fk465drfbsXRQ3bGsaA5T2Nqs+RkLtql39FcA?=
 =?us-ascii?Q?2Uf2WnkkRaI3wN2spyda6999KJ3DvMRq6E3nKYaxBoI7BeahFKV9f59hxVX5?=
 =?us-ascii?Q?TWBknLgFiwqmyed/AXa5Ugm1z/3Ur6Af516LR3A7OWTXBAskc/mufZcgn385?=
 =?us-ascii?Q?6wBROE7wYZkwV7yEIsorJKO4mhBqhwpo+BJRbVrUA+GYBe8JY9nmGqOvJjmc?=
 =?us-ascii?Q?RS6EwncnPkz8rNasmDSahme9Au8MC6Iyc34gVaoIf7lW/1cezjtDsBfbYeIR?=
 =?us-ascii?Q?VhXnynEFG3im4DYGvw7sa+CLQySt9BMOrspaYyHLo8lGkiy8cXLzAyZg9mf/?=
 =?us-ascii?Q?3ojiSW5ddKADRIrpqzXFQq3VHGq0kjsWwXYyIWYW7Sb+AJGRtFfgc0HgURkU?=
 =?us-ascii?Q?k2NKapVUD/M1sZiPSBRlLPCC/yNNcphmgw3wbJSd7z+kEIf//HJfTEu3ZvB0?=
 =?us-ascii?Q?0H56lCnjtD+KMjTXqOZ+togNpjwXyy1pBtiwaWOPEeBWCADn9Kkv7TBG7r9Z?=
 =?us-ascii?Q?cvnKC6rmFZeBVq04ZNWL2CdN2Ib/X3eu//sQFgjpoN/7JhExZ7tDmnsHgDB6?=
 =?us-ascii?Q?As/9nqz3sK+kFPBZ7U0aVdwKh3ArJ76PceogtIL2aj2spMkU4ZP+5XxylJ/0?=
 =?us-ascii?Q?BAjSUO6gRjZeGDzM719cq0BSC2WMLii66T8CVAMWWrVubhY2Rz80NTOTMahz?=
 =?us-ascii?Q?OprcaBGS30zJWY18YpZ3aIYQfFpeueqOCUdmjbynnCfbGpKJ75BKcG8YfXxS?=
 =?us-ascii?Q?9OYaxndBFXmW1VQOcmkKm5bK+CEkWrfdXkdT13Jbp7/0XMuK55gX/wnfXsfM?=
 =?us-ascii?Q?ds1YMFqeqJk8rHxZN3BV4P8cFaPg7lGz5uHGOth3o7yg0jpdLNYpETH0rIIw?=
 =?us-ascii?Q?ynMIc/ISF+4x9oLXqCEIZoq/+yavfNmBdLdP+MgAApKUlSP6Wp+bVVbwp/nC?=
 =?us-ascii?Q?nS66lWBnaAiitiB0c9GcPk2RD3vsO51lACEJYvqXPcgJ/bsbSLdgQ1Dbz0RI?=
 =?us-ascii?Q?m43wU4csVFsxSquMbQ8GInJlbhmpoWCyM+XKJTPj8hq8pyvYyVeEq3dKlR0J?=
 =?us-ascii?Q?kbP9ncSCj/CVMIjwYccO2uYYFV5MTVCCzM7ozIK13HSM+S0iQ1A+cQ51VLA5?=
 =?us-ascii?Q?T/b6/8/3z5rnqvEbiupCDEoWVIUiDS8T7gRe6isOiZakDl6aXvwh7NvpRtty?=
 =?us-ascii?Q?mCElbqMfyWjfhaZBzeiY2UbrjHd5msfEMQIpN0PyVVAObZKdl1C4dnRen2TU?=
 =?us-ascii?Q?j5rfApKO2n9NRmWJ2R+t5IPCEz031CgYc6p9ndSIxCVFsw4YfwNncIhOhBr3?=
 =?us-ascii?Q?ktKiB9CzCVsZs3IdqyA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:16:05.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe7c04d-b6c7-4c67-f5bb-08de27a0162d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859

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
---
---
 drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7600e2383a72..5e49cd78904f 100644
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
 
@@ -5816,12 +5816,13 @@ struct virtnet_ethtool_rule {
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
 
@@ -5909,11 +5910,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -5921,29 +5935,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
@@ -5967,7 +5982,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6139,7 +6154,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6149,14 +6164,16 @@ static int build_and_insert(struct virtnet_ff *ff,
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
+		/* destroy_classifier release the reference on the classifier
+		 * and free it if needed.
+		 */
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


