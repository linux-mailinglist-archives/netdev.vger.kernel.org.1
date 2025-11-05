Return-Path: <netdev+bounces-236080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 037BCC383BC
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBCD14ECA20
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DADB2F5A16;
	Wed,  5 Nov 2025 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t0uWvJnq"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A12F49F7
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382718; cv=fail; b=NCZ2+PGgsRzKJ/XLM3l3dYB5zYmJQaVdt0L3Zfzu/hBmkd+5ibPtaNufluchpA8aZ2OszUEgmrjZB4Zr2ITWr5gYtc6FRvCMVhn5mdP2TjKzyUlt/kH0w45Qg8/kTKIUWNbi/JqzXhChVCTC2hcKLeNxHsFT2jXCifASZBilDrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382718; c=relaxed/simple;
	bh=dCI2UjeHrV3wOC51UUQxkrIpzPLEbaipTUha+L+lnZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUVFAZQ6WB57cOEXIp4GQs+DfCCg5SyaZlM6t719ZixpV0eyTPDHhRczyXfY09BMlnxLpAQ9zAGad2Nw2JQ7NDgPQYeEGUSvvz7YQeOUB8OW3LC18yEvnMyKAtKrEfgdrPDnkWd52rXSQmVu4EDP9QBSubrg+KYJrjRsvWD76XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t0uWvJnq; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTOr0vJ4eLPgaCXiTI+XTbt0H0cwR3EIlxynZA2Fr1+ma2KwMGxPE4yMFeLqsfCCGgf0aOohbV0kbFAuZPWQwYARuB1/l6Ujw4AZzA2CX905t5RgrjDysYOjYLw8tGXdqbcdF5qxLqQFpJKjTHp4vhb2IubFCy2WKnJPO2CVfXvH8rRdISQodPG/qJgU/ZDEzAtIANFDn6eoXxyr81z8AGai6viXYA0s3wor97l2zJZ5Obzp+M11bfUlL0qI/WgZgmnnGJPazdKS1KPxSg6iK+FMCKDfn4mphXBRc4Ab6/84XMoje+IrA24H4ueBbsf14juPZZOR5xRkHTPbZzzEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX7J1Do2XeUPl42xuG6ywX19Io2cdAn1VdBsHWkpSWI=;
 b=Sv7cU6MYEdTBJR41h+5jQJALjmA76OWYX+RNBNrTBkL3eROVyKqcqz9YC/1iIlk7rBWkNWAyHtB7HfFi/woQ7qRxG6fvWJPnDcNe82vCUlCX7SPS5LRZgbiIm7U039oqBCiGimS7bPXHI+W6zylDB73kbXnTArj3wmK/JMLbspB/fdRdcN/+9P99XncD4LqGGE+P51rpCIl4J+zDCcKqQY1a4X8ldGEf1daORlAxGjmBjQrkOpNS6X03MTgV6IjNGt25AVISEv20k2p2IECzzMcFnaBeg4NK9+2YmejzT7WadhtJHkbV9t1sGUIIzrG+YJf22TnylLoDixTdXaK6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=nvidia.com; dmarc=temperror action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX7J1Do2XeUPl42xuG6ywX19Io2cdAn1VdBsHWkpSWI=;
 b=t0uWvJnq2wS6bzFJ4vhesF9KPN9pMHt/WdMkSkCUCILYeeDMoB5uOCShY12UW0zY2iE7YcVcPfmce3TKFBjR11CDQqbcIG5PsIWzgBmH7VNnQSkYG4wSOVq+830i3PkeTBtZuCy5U1O+1NaVQX/qZHuQt3LnsHuILDwpZQR2l7NoseAROSUqFeZDGb5exqAInHUObP4LO8eYFkf780XZV/axUKi+Vd6wmYGCu2Z7mG6HwsDMSXLz47Jwb7KbP13FXwVe1XUnUkDCq/yA25wvJm5+yCMy6H9D5sMDP9f4ZXlyhyI21usOth0Fp1d6MU/fylExWL1l4jKFXurnQ7Z4Qg==
Received: from BN9PR03CA0436.namprd03.prod.outlook.com (2603:10b6:408:113::21)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 22:45:12 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::d8) by BN9PR03CA0436.outlook.office365.com
 (2603:10b6:408:113::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 22:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:45:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:51 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:51 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:49 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 08/12] virtio_net: Use existing classifier if possible
Date: Wed, 5 Nov 2025 16:43:52 -0600
Message-ID: <20251105224356.4234-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105224356.4234-1-danielj@nvidia.com>
References: <20251105224356.4234-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab34669-0e4e-46bc-8d8a-08de1cbcfa1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7gUeR5otkgOy0gBqMjoSi+TxtM1mOld5yR0fSs4A3i+KueJbdkEl/0jIJlUI?=
 =?us-ascii?Q?67S46KMJ0wehvTHIBIyxUBqzMZmP32Q3fNPBPurYGbpcgdLZFq1pgAmkfv1N?=
 =?us-ascii?Q?zDhAyiQHNxZ8eC9/WPSZ1ShZ7n1VJVBa2tnvraAX3kNDx5vi7BSzrviC20zv?=
 =?us-ascii?Q?GsMMTtVZNuKRMODST/f667Fo/4gs2Wkc+MmS5hqZHN82lwn2SJnMdt3a1HeS?=
 =?us-ascii?Q?tBtSrlIoba7PSb9lEN3jRVsVIWVpuoByI4VV8vgYnVP8FX8yGO6h4IFPUexG?=
 =?us-ascii?Q?s06Qn/hBundkLsn82acgPJWjAWs8F4tmyRJ1206XyXAOmaVmMSKwLNj7o/k3?=
 =?us-ascii?Q?LNmZ8H9rfa91+s8CV2zo7yQEx8S0CpJMBhT9F51zspBWQf5vRIqY5AGCWuCr?=
 =?us-ascii?Q?TtEfR/RrU1gLHWX1RA4h20erKpO/x3945jRqX/1WKVPwvWi+6cHv6u9oteyO?=
 =?us-ascii?Q?M6f4zqhWnfjxL0+WlUal61QLus4o09fX3HFmwEdXqJtgQIoVNKcwz0XOG1ax?=
 =?us-ascii?Q?BKmsr80m933p+TH22Xx+FbGS8HA7uI/Jj5CsEn1ls0JS8qG3iKzm4dZmSzn6?=
 =?us-ascii?Q?QILYCF5a467AW50yRLUm/k8utjGaoy1Jk+WhtGUAfnV0US/SMecN4AnRLkWd?=
 =?us-ascii?Q?/Zklp0QOrZD/1UC3oGyoJNk+ePwQWKx6Hlu9WGwQ7I1z7OA4lgp11mwu3vUg?=
 =?us-ascii?Q?k/2YqstFIUDQNMhlShjnQCGP5akqOTNvkfXN1Psdj409275J6Fm3pXbyfwBB?=
 =?us-ascii?Q?FzOwouCaJ6TJltA1NupwHLuB8TA1m+tVGAP4ds7eZnvRK/2mw9L2HCD/BNFo?=
 =?us-ascii?Q?WRjlg2lZfVyD0y06SSJZ+9gyFUOk4ATYMgz9BB6a/pXC3i9GLHgN5o52hz2t?=
 =?us-ascii?Q?CfuD+JL3+6cXrv8m0LcWr5ljAoIEfTMd3S/Y5bqUHxyY5WHd9rBjNJFtnRwX?=
 =?us-ascii?Q?1iNWoNyqeRDjNxWNu4UdV34OlmH9ipz41AFQjc3cSlrTC7Z4X9DGtq9a1ZIb?=
 =?us-ascii?Q?D7DoZsSphko8r5uGunMmOi9xji4lwGrqEiWSvSh1GcTINeVsSpnmsCjT5YI/?=
 =?us-ascii?Q?t6Yig6jD4vQ5V9eqm/8Vbi0eHRz5Sfs8pwO1j1MqVBfXm0ZTALV36T2ymzmH?=
 =?us-ascii?Q?PvGCT4x5BZJ9X73PjIb8YImy47HHpH8WXQKOLpHzsfZxon2sxNtuuIhxKWBc?=
 =?us-ascii?Q?fnE7Wqcv94QyPpapcpYHVUwVg+KwFB1f2/WcVcw2GeqhF09CLHVdBvanXWNk?=
 =?us-ascii?Q?T6zg/E5RhNSzApHMVrsjziEMRvLjjatHOo9Hwy9Un1CsiJ5Jgnf0rzRHzjKD?=
 =?us-ascii?Q?2Myj1FJnx/9wNbfpsCO41W1qAI8QPyHP6hULQY/jUevopFY8BQ9iDvWPIVxH?=
 =?us-ascii?Q?HrJTcjtfjEPSJ8B6uAX+aZwX+xwFqc+tMyL3E6pjuvE0MQpLHIL6kwjaVbxX?=
 =?us-ascii?Q?/kB9lhXREBWg6tcIiFkJD0nax58EO7cXH+iqOLSTpbjFvpHpu5TqArLDsytW?=
 =?us-ascii?Q?77Jtp8Y8xdzvHjkukKEfWI2VirTMmQMfd4uLoHg4AaBqj8LsDkNt4X6BuvRj?=
 =?us-ascii?Q?UgF2OeDYEJVRZEVUjP0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:45:10.6996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab34669-0e4e-46bc-8d8a-08de1cbcfa1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580

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
index 85df425f993e..a9b3e5da3ccb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -299,7 +299,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -6811,6 +6810,7 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -6904,11 +6904,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -6916,29 +6929,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
@@ -6962,7 +6976,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -7143,14 +7157,14 @@ static int build_and_insert(struct virtnet_ff *ff,
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


