Return-Path: <netdev+bounces-217413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14266B389BC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946784E1F2D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1E2FD1A3;
	Wed, 27 Aug 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HeBbT+N3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9C2E1C56
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319973; cv=fail; b=ijQ9CjEVouzrjLcoOnNw6UkDP0aWJ2vce8dRP5pgSfota8CySuchYBREToVJ+JMZBerFBt+LVL120ZzHCYrr55zbsyuEnwvGgWaJqcOtaFT3d5qNSA5XjKDf17ObTK2fT5sVUWubHxX6E5KhmGb/DXVhDmq8vuST48TIYVm+AaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319973; c=relaxed/simple;
	bh=og2CXEkYFxBSZow3uM09l8JzZcbaR4ATvnDHcaCilHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jW+lremRo5oS3AJ5sl+q65bnvOCxIPv/c3LCXjsKxbfF8SMuHlFtygC+bFMRtEdiw9um7XYcsn7fuL8diXqWBfPWHyv6RMZqw90kzuo/2HWKZKfg3QJOn3kNxT0JAMd7FZnGJ6BJMqu1o/t0yOy9rwzlik6aAim3MgYc5rYRwp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HeBbT+N3; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7t9GlnR8P6QPC+3OT10R5lUWkn0B9Tgtk6wq4lWBG/bqQuY7G6kgnBSNe+sm5a1TMN/VfhYKQLhb0201ZreVxd80uDUHQWdfTnS898fIKvoMIepK9a9X3C0JBM8eaYgLnHLs7azo0QF39SR5rAM3JOiUIrreVGJ2nasUgpLMX4gJfts7Al50k/mCQGKstLXqBWXmE03jbXNL5xzB6IDttwPlvT2x/t4a022kw4NCHJEBbi9r/oOG9yME6Zwu76wb3tYItiC6SyBrIE7fx/KZYEKl+agLU/nePWIPfiq8gKSxY2CdQhFjW9Ivm7mSgdcZ85idpGZfuiD9Io94QPJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LjQB2hc0QqFtGlU3vIRXQ+Vyd+ldsiI2nZnlJ+PZ5o=;
 b=jNP8QOYC5p58vVLDquKQGrzar9klopGxMM7hiNpF0V4WVWhwBmJNsjwK6mTc5uxUd7mEF6G+wBQC5qGIvVuDsDTI4MpkTsYQM4yfiPt+bunof5KLUGkjirI14srss0Ue2Vj+q2n7GHwq0RBI+N6VSkHlY4Nc00GjUv141HHd4XGPeiaIj5ICL6MvfmtkaLPk5epi+po046iJ/bVhQD6q2PSon9fatCaU7bQAtxri9Gu0QltFePtVCvLNP7aH89veddnwesLGnCxrIoizHJ8FRyMj7UtdWuWCZXb0sC74sD/ms0p1Tdk75WRKEh0mV//wsUzqTqvFAAxiv/T0DzY7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LjQB2hc0QqFtGlU3vIRXQ+Vyd+ldsiI2nZnlJ+PZ5o=;
 b=HeBbT+N3OhHblpHQsGjceDT7kPqdL+hvzhgtz0ABaWTlK66VDMZ1qRbNfkJZ7HdmZbN+CyJANhtZRXui+sfjLeoj/aZzPU/QFrKQsNAT09z0pymhD+nMZ4ZLtgQKM9YyUDWwgaIJ3X1lLMMPjd7ghABMx0yJsmFNgu3p4AwQ0YdKNrk9M7oB9Dpd/85JDxfXP+ZyTtkwfpDDsDWH7W8bThLKgvAw1d69mu2w3GSD9XprnzgS62L8hPpu9kcTYJ9S0CO6mjZbHyOrt0qXiSjs6CV8Hgndt6TDWNWetu43PSspkIbejxb/Tcni75Zo7FEKK4VTYaGS+omiWPolDAbFqw==
Received: from BL1PR13CA0419.namprd13.prod.outlook.com (2603:10b6:208:2c2::34)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 18:39:28 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::47) by BL1PR13CA0419.outlook.office365.com
 (2603:10b6:208:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Wed,
 27 Aug 2025 18:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 18:39:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:09 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:08 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 07/11] virtio_net: Use existing classifier if possible
Date: Wed, 27 Aug 2025 13:38:48 -0500
Message-ID: <20250827183852.2471-8-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827183852.2471-1-danielj@nvidia.com>
References: <20250827183852.2471-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e672af-4da8-4d38-e738-08dde5990d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R2Si9SXbRxXrdQIbHb7L/a9KBoxBstc2iGGdeZdv5dhcZ8VuAdHtsL56LPfV?=
 =?us-ascii?Q?BB29S9fEWdWyKIMNQ7qe5uXShQFKWzj74NG8tcmGxkzvfy7AdVg1KTIcyBoV?=
 =?us-ascii?Q?zpzNtjJblf6jnqDjD6aRkh/5pXxrIjsX5HlHsEBrBss6x8lDSV6BJm+i0jFk?=
 =?us-ascii?Q?wKoFjaxJIYo7kiMBIDEnCe1KFtxgvp/4HRwvHdUzLIsQtAEFRNUolHGnHQPK?=
 =?us-ascii?Q?NsHZcG9bqUCx8+RfbenzVQIuS9ljrzqkprUNZEAj3i63IaCCQVzWcmB5Zbi+?=
 =?us-ascii?Q?FOLick5KYLD0RZWZYeePmsPJlfdsnoV/JGGcAsL7Ww68ptKae+VRRDYBL+wB?=
 =?us-ascii?Q?TLLob2/klWeC16qSLJqnZzKh6/6SIDP5uLvLo9FXHkuhwWk/HQnv25udLdcT?=
 =?us-ascii?Q?D6cxWMGctn1brpYVnDeEM0Y3xvf7F0uIS2KSaUSrdJueCNNInu+w7oSvQi7I?=
 =?us-ascii?Q?4c4gRPcYebWOvTgoPqoJDkq8o1Y/YthpHKj0XmJhXHhpGY9tBpRiEf9u/9jO?=
 =?us-ascii?Q?9/PJQX6ZNlx5GZMnsNUjIADXg7Vux8WagJjr9xmTyyEhTVniWNkDvapbAAB3?=
 =?us-ascii?Q?cHRR3uA7S4wN5KVtDfB2XNuj6fwNl77kVVikRrLNWg8XVxp0//0fYlSIslyI?=
 =?us-ascii?Q?odwqRkdq8xVUMOiz186MAdIWTXnRhdpSF7oRAQzreNMt4RMhYJGrdOoobTgP?=
 =?us-ascii?Q?wJ1ALCZgNmj7lIy7lVwsn+pCOd2XYLF+4RYLkQUJ4pnEJ8Cxzkwo8Qc/P+ZZ?=
 =?us-ascii?Q?PNcmTqbC3id+EjO16i4jyE3z9xdTSbYXKwuElX7abbecY8v2Zrl9wbPeYJSZ?=
 =?us-ascii?Q?nXfM2ysLyjUqPhh40JlFjjhJlvSJGtKmNTSpWl3S8heP8X6g70CQvxY/xHZN?=
 =?us-ascii?Q?3S/wG2Uyc82Ks+b5EYMl1PwJo7JnIx4fspIXrAH6qks+75/9RhfXflww3vWC?=
 =?us-ascii?Q?8eWV0DAgwFHxrhasK4I9+IwxYM3wqOOk1ucs6gs1mr5mfNHzruRc9bJ4C/2E?=
 =?us-ascii?Q?eGXUd4gValNMVP9GxOu/bI8S4u812xBseOFqZ1m5+Vx/GLUzwpwLuLUfbhBW?=
 =?us-ascii?Q?xjOO2+/prVOTLnIZ+a46lrJEEyPgZ6MixkAZE35twtMXSVQupbKCIRbEF7aG?=
 =?us-ascii?Q?mm/DPuu/1AJ42UFDZjCdpUL0G+sHkwyBeU8gqn2zYN9SOERfbCbX6lDLjW8P?=
 =?us-ascii?Q?Pt3JMsx+8OFeFVeWRyXqR24X01ebBrEZ7dYg5RM2osR8e+nOGusRbrdB/TvT?=
 =?us-ascii?Q?OdpJ1x84CnNgFp1rSRV9M9QxyuO0wUMNJ4hE1MW2ByA5UF1ys717JNNxpAS0?=
 =?us-ascii?Q?F2UrLkphHnb9Ykm5Gj9CR94Lfvo02oset55kIBwCJNBMtfqrgcJfDzdMa+lH?=
 =?us-ascii?Q?43YMB+DZtunzy1BBEQ71ELa/nEWP7rxL3m0Zw8w5N0YEu/qkG6wb8Epo2kLE?=
 =?us-ascii?Q?ytkL/ptZUo71BYooigC33qFTGDAPw6Juh3exlGkaoox60yLjQNHu8E/4kySO?=
 =?us-ascii?Q?kQ2cy8kIyv54JSqzuxfFEKHeZKqyf2qiXARu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:27.5566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e672af-4da8-4d38-e738-08dde5990d9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177

Classifiers can be used by more than one rule. If there is an exisitng
classifier, use it instead of creating a new one.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c | 39 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 473c2f169cfa..ebdac1fb49dd 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -17,6 +17,7 @@ struct virtnet_ethtool_rule {
 /* New fields must be added before the classifier struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -105,11 +106,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
 		       XA_LIMIT(0, ff->ff_caps->classifiers_limit - 1),
 		       GFP_KERNEL);
 	if (err)
@@ -117,27 +131,28 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_device_object_create(ff->vdev,
 					  VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-					  c->id,
-					  &c->classifier,
-					  c->size);
+					  (*c)->id,
+					  &(*c)->classifier,
+					  (*c)->size);
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
 		virtio_device_object_destroy(ff->vdev,
 					     VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					     c->id);
@@ -157,7 +172,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				     eth_rule->flow_spec.location);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -338,13 +353,13 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_key;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
-		destroy_classifier(ff, c->id);
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


