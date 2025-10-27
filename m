Return-Path: <netdev+bounces-233273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E85C0FB71
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB12619C1E93
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783FA31A055;
	Mon, 27 Oct 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I9MhN909"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8133191D5
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586852; cv=fail; b=NblSy4JHbkLoVDGX1dqITHy9LKuvzS3lKBbEc7Z0KTOBCBRiyCd8B5mQ1v3tIUqHBsMN61I1oe4YHf2jp9ZmlQfkcAf68ZyTFCLEqBAnCvF8U3Xo+NNCEESLtJVAHd7V8AlTacgWFXx7EKmWfEF8Z9/Ui22WsXQBtwWw6bpQg2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586852; c=relaxed/simple;
	bh=DQ/2XhWCiyxc+TOoAwIeVo22tgpIoP3lbkAhUvFqPFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao5ZrzkKG6PDAwxhD7QtUxvFaKltX5+0XTX/T02tWaokLjEpCPRnZVPr+UBBrpcF4wH85DzP4z1YnLfMIcCpLYMSVm94JxynpTKGiajjCB7Q8dBel8MZuMMao/Oulerel0YMs/iMET/lT3d7QTtRoiR7h23JNRO2OhfXg3CcFWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I9MhN909; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS85JHKxYsmxwNf2R4IfzBmqVmFJzrr50JrUrtVKbajIzxZ8W5Fge7oNCi65YGPaqvEu4hhgvJQUGF8SxUCit/TCe0fn3CXBxpX187U1U/5Q7uvxHaeD8TWGpQz4WCl99jbEg92uQVrritFoP8MEPnxnw6LyDTiDfA1xR1sMaGPsZMzpqeR2Vm03otEu/Av6j+n1jwRyCw2soe1fsZhnezDAewObuT6KWVMIspuoVHjFYx1xxnhLZlryMxjXmeCCjZ4mTXKqKS7rXSfedbV7JLpxXOwk3n8ofnCleZGJscQN6fhSui0xpozYfVaOuHaA+NoKBmfBnJHhJOKyBYb2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDPk5RDcAeu9z3NxEvFl+fXgryvwQjkMAb9n19d1NZw=;
 b=WZ3Dpno79Lk7tyrtcOMCEtW1H1PX5nRlfLvptBoE2bj6kYqWL53lFGtPbzRB2Zz1OGNWrSZcUKL/rqSfCJZOOCtnf59fKQDNSU5uXOG/K+hpAvExnPFozHQlEANxDFeJFamfiknmgB237SiEnq1rztN+iucQUZyZ5M5Pg49Ao29gqm7ygFVbbewxCdJ9kqdIhsd3osDqvXwnWJOe9D0D1ZzXliDZ5aw1T2YHWZIDMi7AxFNFd66ggfv+nbtpGD6CtCM0T7oJr1opVtVerXkLVTQstLXq5xI1fpbXP01YIM/JnsDYj6kVEZLF+C3/J24LiZXOYchNY9rguibqvbLEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDPk5RDcAeu9z3NxEvFl+fXgryvwQjkMAb9n19d1NZw=;
 b=I9MhN909WhfklDM0+dCZglhzqPWpd9CUTRdy+Rhs1sInWv7QGPer8MGgH2wFJCVBf8A4IjDTHYXvJqf31x7yxCvx5cHmHHc9KEzXoeDD+LZEmaHshh9yTDAoFD1e689Bq8k5LHCzuUTNNkyfVaoGMBmHrPOA9caW2PfCOXRna0Iu0SnI3BmFgK9Eg9xvMzCtlhUEuP3tq0mmu71GU68NeaDPcoflbfYFK6icgCHdZE1UqDHe3y/CgR1aewPv8yfb+xNDGRNB1y0dgNhu9JCZ0mrsyMkPE7krQWmW/wmg5e7f++KWxjB2i4Axxd3F71Qz0BWN1NHNgnX8kCJz1GUyKg==
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 17:40:48 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::fc) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.16 via Frontend Transport; Mon,
 27 Oct 2025 17:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:40:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:24 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:23 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 08/12] virtio_net: Use existing classifier if possible
Date: Mon, 27 Oct 2025 12:39:53 -0500
Message-ID: <20251027173957.2334-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027173957.2334-1-danielj@nvidia.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: c0635155-0027-4152-bd35-08de157ff6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iEglr+SWSIUjYyT+Z6VNBguC40mCO0nSXudmoMl+E06tp87Xf80eOTOreh88?=
 =?us-ascii?Q?d7lBuIog6lidGkNQQL5cMc0VQEPAgkpSdwshsy21r1E1izkNsT1KDyAKayP4?=
 =?us-ascii?Q?n+dE3nFbWENhZs5UvKy6VcfXmwA4wwH+oI59Ov77hhbkPatKnSihljzgIUsI?=
 =?us-ascii?Q?cMJ46sHTOWyF7sUu5tHdtxvs9YnTBOB4X1mb6W+4EHOiB0wXOfcwHIKqwjkk?=
 =?us-ascii?Q?RqQGFXP/VXnImwTHl+h0D6WK/CmP0oZ4tUh4yor+3RRSwuZ8JcjUwc5I+lfv?=
 =?us-ascii?Q?kVvmV+8akfZzcXaB/N75KMyYPmsobFcHu/Rrsb6Rof3HbwoUqgYHPvMxWfeD?=
 =?us-ascii?Q?kcFWWRvqO+LpzSarExLhQwH6thnUg5sR7iN2lwkFdCxWRSeLVegKlCZ3thlh?=
 =?us-ascii?Q?x6Y7JF6af7FEpdUDG6EiWgDICuJhivK3Gr3379PKGVBQ5pcAZtsj5FRmDfFj?=
 =?us-ascii?Q?7MlJxpUC7+hsqwfG22XMKT4UoXTyntEK7oj+8jcxILkFiqNbrIqS/QLQp8fI?=
 =?us-ascii?Q?4d7WKVUdtBBlwL6y21peVwwia2dvMx3yobvYo3Aimp3zLSU8uEcNqmxCO1Td?=
 =?us-ascii?Q?D/MF5yGQ9eygpf2j/mMaWQeow3bCVZAX1Wd2HWkyaYu9r4erkGQKytJEtfYT?=
 =?us-ascii?Q?H6VSnze15H0ntH95oCHuWfSrAcHwkwdMRUjECOMPlcq7m7dpKaPPGL1G8QYC?=
 =?us-ascii?Q?1QCmME7RsVSIwMXN6h30h5CfUxhbbaXvaGYHOsM7W7uJhCta18S44/n5KtKG?=
 =?us-ascii?Q?+X3etqge04TiKWyy7ZhPFQB3gA3RhoYhE0u64pflGTn+nFiJ4DddesNbuTou?=
 =?us-ascii?Q?1qqs439XtqdfGtcV0DBGRIWdvXcGJJ5mhpfhxfDMOg2jBa68ckN+j0peWCIg?=
 =?us-ascii?Q?S3VJFkop3X9We2UPctf5K08/D2TL9iRP0ufVri8uK00xsFkfpyqIet8iyX9N?=
 =?us-ascii?Q?IidKsGldfSGu1Vq7YCHgEKkWr/e0R7fCB3Iqp88jUbXcUs11lvRsRL7BBBqW?=
 =?us-ascii?Q?XCGTIhj8ioFtqwuRLGaSXFfgrF514EIm+MY5xHL6Thrb7BECAhxEahs4cRii?=
 =?us-ascii?Q?bbOn4bM/OZQWUI51f7PeLjyWyjuOqBMesHAqgW8B5Ivqlmuwq+At7/1bwovA?=
 =?us-ascii?Q?jjfT9mudN8LAubiD5N35DzFWXS869aWmMM9pT2EHy+S/2L5yo2o1UzGW+wkX?=
 =?us-ascii?Q?djzBOID7sJo/Tx2JU1AktIvqKliZak6Dl/Uh/3OcMHrorVysDFXKlAdhRuds?=
 =?us-ascii?Q?NVpG4O3I4CNcv03PwspCFt1CFjs5fHjN4rVAwKgmAwIqQ+hzMfY3R/MLe6Aa?=
 =?us-ascii?Q?83NMpXUTc0wG58updm6X6om045uCyWb0coha9AUMoE1G6ZIlgmHK9H01TKez?=
 =?us-ascii?Q?HLufV5JRyWa+fOiDGLxOgGffS9v9EsVWHSiUP+9o1z+9bMCD26IuxFXzfSx5?=
 =?us-ascii?Q?zcC7Jarae/bd0Cr/QgUo0yo+ez7B6rsD2bjOtpOgHilPpwJqGIw2MKfI25Eu?=
 =?us-ascii?Q?PxoQ8sC3OoKoBUrU0ig2+iyIRCjH1m913uKk6jEjhRM3zTB3Ny1XoCOCr0Sw?=
 =?us-ascii?Q?qxaew3cO8g0fxFcAvSI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:47.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0635155-0027-4152-bd35-08de157ff6e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736

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
index 73194b51c318..d94ac72fc02c 100644
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
 	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
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


