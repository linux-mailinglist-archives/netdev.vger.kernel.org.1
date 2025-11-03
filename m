Return-Path: <netdev+bounces-235254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F41BCC2E550
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491D218993C9
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C02FD683;
	Mon,  3 Nov 2025 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H2T655Hu"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97C2FD66D
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210572; cv=fail; b=N7i2ej9YYCj586FQK7FZnTrS26wJNL0KjHyewDNa7j43XNnPjPcaIVn1NT6NgqSAmMmH3k+f59qeqEr9ulk1qMXAp3jK6w0E0RSXXtfziSGjMIcW4PFjZ5DlORHTikwnwNGXjkfPPlPo3gzgI5nWxejPLcZI1CNPGWR553youv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210572; c=relaxed/simple;
	bh=pKby3tndCaMlu+YVI23TZTlLJvPm5TqduZ5pR7YDVsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gX/6TFQobzprHBnx9AQqY9DDuIYmJtzAhaiENPI8nZhfQmHGB+G7xNXOsyBhVj1iETOfJ0x1pR4H4XaVsReISYt3rGd6kTOd/wJZdkZkKJOf91FPP6419zNkA3ay0jIdbCGGd1wj6uRyF3skccOn2MgtPNV8wD7QGfd0R3fWVdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H2T655Hu; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3uYFhafMA0JoR962Fvla1OZymSI87S7oWODXddkASpGe2gbNraEPvwcDwD6bX6Nrb6IkFtvK8ne2SUL6JXJEmqA0kDiZVJxiGDPsGnm1ZJELphyWJduMkzoOhnwNa4c2PY4XOADRDty7iMwtt/UjgrRSB/oopOd0ia/keexMqU2k2tJRHunqVcoP7KkLrx1QMOzaN855nMQZ0V5CRJ4j/YbbZ/MMSdao3ukbGT7Ngrab4Jp3akpmfMPy8tl8jFEff5ywI6jX+/nTVP7Ncn+H5hO16NYSegxKguxeM28d+VT1By0B5m9slLKdyJ1ubdnHA4u7Ggd31nyeyazv5ToFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DjFW+0q+84OdGAimIF01FmgmdoeREvvJWF+xz4WFGs=;
 b=rkndqRBq7W4KtoVpLnMktzSK/D+Jt4r2wIqbR8gJDHoEIrrosj1FPTmnm+WUSHobubyGyNViGmPM6qvFkkdnFqmgWf0dknJrtWRaGZYW1fX6p4r0L4jV0h4LWkf6Cll2X45AnI4+TLX9prT+LCeNtadp0eOZftvV4JpZ5gSP1hcpusjF/tF7kCzrtLWYL6RF7j2gsyXnagl+HOlsmKjKJBBgJEUh3X7yBs6Xwkqrz5unyvWTcvIc8ZxP4/08Ts5swWSOaBXlr75pd4DPGtps9o95/VMqf2x+zjrSkPGyWsORiFoM5Tg7YG2nead9ss0axsm7Lsb9vmvFyWxVuKM/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DjFW+0q+84OdGAimIF01FmgmdoeREvvJWF+xz4WFGs=;
 b=H2T655Hu77mNhSOYbVRgZH+BdS5SpD6cx1DisBZZ52QV9NJvFQodixHgQ7KAbhYq8wIUGiMV7uZLh7rB0txXvZDyBWZiauY27I2phFjrm4IGkArzK0E25GsMFzCNXoqndLK8tRMYnHSmPzx+/cHp0TJjO6aUXGgvwn6S50wT4EENSq2lFF1U1UxdN5SSNLJzVNIC7Iv7MYV04NCLW14maM+GZ8Ylxgmp2kYqrZC5aQ/NmCHo4PTgcKrpgu5eWO4LN7rcs7CvfLKPi4CoPpZLUnDiP0ioGucBTZbn3jyTsKss9VNzr1xW1l3MXFj8jruhrPUv/T2DOi104yMt5MB4MQ==
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:56:08 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::26) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:56:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:51 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:50 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:48 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 08/12] virtio_net: Use existing classifier if possible
Date: Mon, 3 Nov 2025 16:55:10 -0600
Message-ID: <20251103225514.2185-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe28883-b34c-440a-d12a-08de1b2c2d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DfdyhtGOj4R1RhlmmiyOzMuR9qhcPS04TiOELs7bp7lbyAU8Iuz0wJpJNEAB?=
 =?us-ascii?Q?Rlg7ycqO4kRkhcVbIpvziFwGTFR53/xOPI3mTVFKmj51u7joKO5UV4U6Z72d?=
 =?us-ascii?Q?3v9CFRsncsrvqxALMNtJf8JJmwXboJsdamgTIx43p1rdjUtunMSHC9LDDgFE?=
 =?us-ascii?Q?iD91AmbRz24/zPZkV71xBzDbmjVg3+8xAES1W5mkbatOmF5pvMXeAuXvWKpV?=
 =?us-ascii?Q?+gSK1abjUTCjtW6ltyfxKHEffqloLevn9dUy9FIMZTbjXYolKS6MqCmdZQCx?=
 =?us-ascii?Q?PwKZ4MSLxfAFymHTCctEW5hANNsPm0p7r6Txz82VtXW417PSKAjGKjFEP3n4?=
 =?us-ascii?Q?G5PAvp75QLRC3rrQ43ceh9qCnNcZ+sMiHAKqy6KMSUba5ZwgIk7z2cseW8HL?=
 =?us-ascii?Q?1Nyh2aoyHB3sx5wsAdoO4MirTVLxkgDGtG4EZbWaxqHvKwBDE63b7y1GOQeX?=
 =?us-ascii?Q?1I85HdC8gmkAWBgz8nKnuB6gxls6OsorUnYmtJvO2IxO5T17DRlCeCH3i7Yd?=
 =?us-ascii?Q?Uy34qOlDExutOVYcLAsom/NsYsYo9ZHnxk4yHXgLfUcOMX6kjJmTLRkH1aNF?=
 =?us-ascii?Q?bjoO0AbafA3213xTxY2GUXthJtn4lJpjQhjldN3UTm2oMrEQshnoA71BTlT4?=
 =?us-ascii?Q?bR3++DPhOzpi9eF0ZJWPcJYsBLH2S2ZzWwiniaGe+P2YBft6BKnYK8VZFyjx?=
 =?us-ascii?Q?B5L8/Hq9eCIkL9Nz7KmBAdZearumdIN1WnPShzzKcEIVyieUMiNAFYILVzcg?=
 =?us-ascii?Q?w9V+gpJh3+jE+p/elfTYmHEP4fFeCoXTPgvjLwgCkcQsxPF8cMDapBTpEbXN?=
 =?us-ascii?Q?g6bwS5hTX2BF8mtnO3G0b2na9oTCk3at6UdObUQIfYupaVCmjUaaN0oxC6Yv?=
 =?us-ascii?Q?toovlHc2udw6/0Y9/QLfGFYNbRYgtlbt9L7lhUqS6OMZeiQIQtD6csnXvLVg?=
 =?us-ascii?Q?PXzZ9YMH8F1Qc172AUCWmx6e3YbfX/BOLG8GRdEVIn4aC9QgmANHvnwgXXZr?=
 =?us-ascii?Q?gChCldboDgEu/anci16wavJDJ34ZyXLVGw/s6vo7uXy4545N1wa9RBeIonOd?=
 =?us-ascii?Q?OmPp5cKG1KTMdwechGOREu7G9FdevpfUxMVYK01mcL//OsQoE0Btbw8zdoN/?=
 =?us-ascii?Q?zujBkUmrGhoiVIa7l6I24VNANCdHt4Vzg0xMy/4CDzqdbe4LGrIDPOORpxyq?=
 =?us-ascii?Q?dyQ21IlCfnE00HRb0qvwKQUsBizCHHoIdxESgIMyQ8/M8cI3znispy9zvGMF?=
 =?us-ascii?Q?HxttdWN6+2tsktegL+Hv5dM+MEmbyqpzShezfLJC/4vJd4BNqly97AoIiWbi?=
 =?us-ascii?Q?XJ+pEqte8oYq8/3zM3QhAA2H/YbI1czF33EBgSgAV7S6qPg1cXRKDsvUN6n9?=
 =?us-ascii?Q?PMlnGltA8gVz08afmZYGO5BJ//QUu7QuSltL2pt0eFjUr+cXCWNkUwtF/Rvk?=
 =?us-ascii?Q?tRgcMEci3cD+33z4RAnnozhOP6wM6ZZ0wGOCcct0t+2KJOKFS49eDVLy0Tfr?=
 =?us-ascii?Q?cDufNvRvUhbQsruihIVSv+p8tbPLxelS8Na1bsscG1PL5aGG9nswc89zPrub?=
 =?us-ascii?Q?cGa0L1iupU/1pDL6+DI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:56:07.9382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe28883-b34c-440a-d12a-08de1b2c2d01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

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
---
 drivers/net/virtio_net.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 032932e5d616..a0e94771a39e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6811,6 +6811,7 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -6904,11 +6905,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -6916,29 +6930,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
@@ -6962,7 +6977,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -7143,14 +7158,14 @@ static int build_and_insert(struct virtnet_ff *ff,
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


